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
    [_loginButton setTitle:NSLocalizedString(@"Login with Google", nil) forState:UIControlStateNormal];
}

/**
 * Action to run at login button click/tap
 * @param action sender
 */
- (IBAction)loginButtonClick:(id)sender
{
    [[AuthenticationManager sharedClient] pushGoogleLoginViewControllerTo:self];
}

@end
