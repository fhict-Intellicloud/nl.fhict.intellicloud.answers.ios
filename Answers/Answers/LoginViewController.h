//
//  LoginViewController.h
//  Answers
//
//  Created by Paul Poos on 04-12-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

/**
 * @property loginButton
 * @brief Login button
 */
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

/**
 * Action to run at login button click/tap
 * @param action sender
 */
- (IBAction)loginButtonClick:(id)sender;

@end
