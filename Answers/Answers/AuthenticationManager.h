//
//  GoogleAcces.h
//  Answers
//
//  Created by Erik Reusken on 05/12/13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GTMOAuth2ViewControllerTouch.h"

#import "MainNavigationController.h"
#import "User.h"
#import "SVProgressHUD.h"
#import "LoginViewController.h"

static NSString *const kKeychainItemName = @"IntelliCloud OAuth2 Google Plus";

static NSString *const kMyClientID = @"918910489517-v6j5fmrvi60sn3pog8dvejvsdm9rr7p7.apps.googleusercontent.com";
static NSString *const kMyClientSecret = @"RgK9Kx23RitsfPEJVwA-Nhkh";

static NSString *const kMyClientScope = @"openid profile email";

static NSString *const kShouldSaveInKeychainKey = @"shouldSaveInKeychain";

@interface AuthenticationManager : NSObject

/**
 * @property onCompletion
 * @brief Save onCompletion.
 */
@property (nonatomic, copy) void (^onCompletion)(void);

/**
 * @property lastVC
 * @brief Save the vc to push the google login to it.
 */
@property (nonatomic, strong) UIViewController* lastVC;

/**
 * @property auth
 * @brief Save the google auth2 object.
 */
@property (nonatomic, strong) GTMOAuth2Authentication* auth;

/**
 * @property viewController
 * @brief View controller
 */
@property (strong, nonatomic) GTMOAuth2ViewControllerTouch *viewController;


/**
 * @brief Get singleton instance of AuthenticationManager
 */
+ (instancetype)sharedClient;

/**
 * @brief Push a google login view over vc
 */
- (void) pushGoogleLoginViewControllerTo:(UIViewController*) vc;

/**
 * @brief Push a google login view over vc with handler
 */
- (void) pushGoogleLoginViewControllerTo:(UIViewController*) vc completion:(void (^)(void))completion;

/**
 * @brief Sign out from google
 */
- (void)signOut;

/**
 * @brief check if signed in
 */
- (BOOL)isSignedIn;

/**
 * @brief check if autenticated
 */
- (BOOL) checkAuthentication;

/**
 * @brief get accessToken
 */
-(NSString*) getAccessToken;

@end
