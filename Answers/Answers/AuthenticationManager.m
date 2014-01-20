//
//  GoogleAcces.m
//  Answers
//
//  Created by Erik Reusken on 05/12/13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import "AuthenticationManager.h"

@implementation AuthenticationManager

/**
 * @brief Get singleton instance of AuthenticationManager
 */
+ (instancetype)sharedClient
{
	static AuthenticationManager *_sharedClient = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_sharedClient = [[AuthenticationManager alloc] init];
	});
    
	return _sharedClient;
}

/**
 * @brief Load authentication object from keychain on reinitialize
 *
 */
- (id)init
{
    self = [super init];
    if (self)
    {
        _auth = [GTMOAuth2ViewControllerTouch authForGoogleFromKeychainForName:kKeychainItemName
                                                                     clientID:kMyClientID
                                                                 clientSecret:kMyClientSecret];
    }
    return self;
}

/**
 * @brief check if signed in
 */
- (BOOL)isSignedIn
{
	BOOL isSignedIn = self.auth.canAuthorize;
	return isSignedIn;
}

/**
 * @brief check if autenticated
 */
- (BOOL) checkAuthentication
{
    BOOL auth = [_auth canAuthorize];
    
    if(auth)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kLoggedInNotification object:self];
    }
    
	return auth;
}

/**
 * @brief get access token
 */
-(NSString*) getAccessToken
{
    if (self.auth.accessToken == nil)
    {
        [self doAnAuthenticatedAPIFetch];
    }
    return self.auth.accessToken;
}

/**
 * @brief get new access token
 */
- (void)doAnAuthenticatedAPIFetch
{
    NSString *urlStr = @"https://www.googleapis.com/plus/v1/people/me/activities/public";
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [self.auth authorizeRequest:request completionHandler:^(NSError *error)
    {
          NSString *output = nil;
          if (error)
          {
              output = [error description];
          }
          else
          {
              // Synchronous fetches like this are a really bad idea in Cocoa applications
              //
              // For a very easy async alternative, we could use GTMHTTPFetcher
              NSURLResponse *response = nil;
              NSData *data = [NSURLConnection sendSynchronousRequest:request
                                                   returningResponse:&response
                                                               error:&error];
              if (data)
              {
                  // API fetch succeeded
                  output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
              }
              else
              {
                  // fetch failed
                  output = [error description];
              }
              
              //[self displayAlertWithMessage:output];
          }
    }];
}

/**
 * @brief show allert
 */
- (void)displayAlertWithMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Answers"
                                                     message:message
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
    [alert show];
}

/**
 * @brief Push a google login view
 */
- (void) pushGoogleLoginViewControllerTo:(UIViewController*) vc
{
	_lastVC = vc;
    
	[self signInToGoogle];
}

/**
 * @brief Push a google login view with handler
 */
- (void) pushGoogleLoginViewControllerTo:(UIViewController*) vc completion:(void (^)(void))completion
{
	_lastVC = vc;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // Some long running task you want on another thread
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion();
            }
        });
    });
    
	[self signInToGoogle];
}

/**
 * @brief Sign out from google
 */
- (void)signOut
{
    // Clear the persistent store
    [[PersistentStoreManager sharedClient] clearData];
    
	if ([self.auth.serviceProvider isEqual:kGTMOAuth2ServiceProviderGoogle])
	{
		// remove the token from Google's servers
		[GTMOAuth2ViewControllerTouch revokeTokenForGoogleAuthentication:self.auth];
	}
    
	// remove the stored Google authentication from the keychain, if any
	[GTMOAuth2ViewControllerTouch removeAuthFromKeychainForName:kKeychainItemName];
    
	// Discard our retained authentication object.
	self.auth = nil;
}

/**
 * @brief Sign in to google
 */
- (void)signInToGoogle
{
    //Make sure signed out before sign in
	[self signOut];
    
	// Display the autentication view.
	SEL finishedSel = @selector(viewController:finishedWithAuth:error:);
    
	self.viewController = [GTMOAuth2ViewControllerTouch controllerWithScope:kMyClientScope
															  clientID:kMyClientID
														  clientSecret:kMyClientSecret
													  keychainItemName:kKeychainItemName
															  delegate:self
													  finishedSelector:finishedSel];
    
    
    
	// Display some html briefly before the sign-in page loads
	NSString *html = [NSString stringWithFormat:@"<html><body style=\"background-color:#ffffff;font-family:'HelveticaNeue-Light', 'Helvetica Neue Light', 'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;font-weight: 300;\"><div style=\"text-align:center;margin-top:64px;\">%@</div></body></html>", NSLocalizedString(@"Loading...", @"Text to show when login screen is loading.")];
	self.viewController.initialHTMLString = html;
    
	self.viewController.title = NSLocalizedString(@"Login with Google", nil);
    
    UIBarButtonItem * closeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(close:)];
    self.viewController.navigationItem.leftBarButtonItem = closeButton;
    
	UINavigationController *loginNavigationController = [[MainNavigationController alloc] initWithRootViewController:self.viewController];
	[_lastVC presentViewController:loginNavigationController animated:YES completion:nil];
}

- (IBAction)close:(id)sender
{
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
}

/**
 * @brief Handler to catch the response of GTMOAuth2ViewControllerTouch
 */
- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController finishedWithAuth:(GTMOAuth2Authentication *)auth error:(NSError *)error
{
	if (error != nil)
	{
		// Authentication failed
        
		NSLog(@"Authentication error: %@", error);
        
		NSData *responseData = [[error userInfo] objectForKey:@"data"];
        
		if ([responseData length] > 0)
		{
			// Log the body of the server's authentication failure response
			NSString *str = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
			NSLog(@"%@", str);
		}
        
		self.auth = nil;
        
        [viewController dismissViewControllerAnimated:YES completion:nil];	}
	else
	{
		// Authentication succeeded
        
        // Run completion handler
        if (self.onCompletion) {
            self.onCompletion();
        }
        
		// Save the authentication object
		self.auth = auth;
        
		// Dismiss view controllers
		[viewController dismissViewControllerAnimated:NO completion:^
         {
             LoginViewController *loginViewController = (LoginViewController *)_lastVC;
             [loginViewController.loginButton setHidden:YES];
             
             [SVProgressHUD show];
             
             [User getAuthorizedUserWithCompletionBlock:^(User *user, NSError *error)
             {
                 [SVProgressHUD dismiss];
                 
                 if (!error)
                 {
                     [_lastVC dismissViewControllerAnimated:NO completion:nil];
                     [[NSNotificationCenter defaultCenter] postNotificationName:kLoggedInNotification object:self];
                 }
                 else
                 {
                     [loginViewController.loginButton setHidden:NO];
                 }
             }];
         }];
    }
}

@end
