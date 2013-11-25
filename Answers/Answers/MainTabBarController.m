//
//  MainTabBarController.m
//  Answers
//
//  Created by Lex Nicolaes on 25-11-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Localization for the tab titles
    [[self.viewControllers objectAtIndex:0] setTitle:NSLocalizedString(@"Questions", nil)];
    [[self.viewControllers objectAtIndex:1] setTitle:NSLocalizedString(@"Reviews", nil)];
}

@end
