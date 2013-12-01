//
//  LoginViewController.m
//  Answers
//
//  Created by Erik Reusken on 01/12/13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

/**
 * @brief on succes changes ui, on error log error.
 */
- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController finishedWithAuth:(GTMOAuth2Authentication *)auth error:(NSError *)error
{
    //check if GTMOAuth2ViewControllerTouch returned error
    if (error != nil)
    {
        //Log authentication failed to console.
        NSLog(@"Authentication failed.");
    }
    else
    {
        //Hide Login with google button.
        [_btnLoginWithGoogle setHidden:YES];
        
        //Unhide Next button.
        [_btnNext setHidden:NO];
        
        //Dismiss _viewController
        [_viewController dismissViewControllerAnimated:YES completion:nil];
    }
}

/**
 * Wil executed when btnLoginWithGoogle is touched
 * Method wil push viewController (GTMOAuth2ViewControllerTouch)
 */
- (IBAction)btnLoginWithGoogle:(id)sender
{
    //Initialize an instance of GTMOAut2ViewControllerTouch
    _viewController = [[GTMOAuth2ViewControllerTouch alloc] initWithScope:scope
                              clientID:kMyClientID
                          clientSecret:kMyClientSecret
                      keychainItemName:kKeychainItemName
                              delegate:self
                      finishedSelector:@selector(viewController:finishedWithAuth:error:)];
    
    //Present _viewController
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:_viewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

@end
