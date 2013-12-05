//
//  LoginViewController.m
//  Answers
//
//  Created by Paul Poos on 04-12-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set loginButton localized string
    _loginButton.titleLabel.text = NSLocalizedString(@"Login with Google", nil);
}

/**
 * Action to run at login button click/tap
 * @param action sender
 */
- (IBAction)loginButtonClick:(id)sender {
    NSLog(@"Make connection with Google to login");
}
@end
