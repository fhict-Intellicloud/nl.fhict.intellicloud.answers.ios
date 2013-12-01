//
//  LoginViewController.h
//  Answers
//
//  Created by Erik Reusken on 01/12/13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GTMOAuth2ViewControllerTouch.h"
#import "GTMOAuth2Authentication.h"

static NSString *const kKeychainItemName = @"IntelliCloud OAuth2 Google";

static NSString *kMyClientID = @"918910489517-v6j5fmrvi60sn3pog8dvejvsdm9rr7p7.apps.googleusercontent.com";
static NSString *kMyClientSecret = @"RgK9Kx23RitsfPEJVwA-Nhkh";

static NSString *scope = @"openid profile email";

/**
 * This is a temporary view controller that shows some options about login in to google
 */
@interface LoginViewController : UIViewController

/**
 * @property viewController
 * @brief A instance of a GTMOAuth2ViewControllerTouch
 */
@property (nonatomic, strong) GTMOAuth2ViewControllerTouch *viewController;

/**
 * @property btnNext
 * @brief Outlet to change btnNext
 */
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

/**
 * @property questionID
 * @brief Outlet to change btnLoginWithGoogle
 */
@property (weak, nonatomic) IBOutlet UIButton *btnLoginWithGoogle;

/**
 * Wil executed when btnLoginWithGoogle is touched
 * Method wil push viewController (GTMOAuth2ViewControllerTouch)
 */
- (IBAction)btnLoginWithGoogle:(id)sender;

@end
