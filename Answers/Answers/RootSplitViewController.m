//
//  RootSplitViewController.m
//  Answers
//
//  Created by Bram Kersten on 18-12-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import "RootSplitViewController.h"
#import "MainNavigationController.h"
#import "BaseDetailViewController.h"

@interface RootSplitViewController ()

@end

@implementation RootSplitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
    // Add observer for handling answer created notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showEmptyDetailViewController) name:kAnswerCreatedNotification object:nil];
    
	[self showEmptyDetailViewController];
}

- (void)showEmptyDetailViewController
{
    BaseDetailViewController *emptyDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"emptyDetailViewController"];
    
    // Replace detail viewController
    MainNavigationController *navController = [[MainNavigationController alloc] initWithRootViewController:emptyDetailViewController];
    
    NSArray * viewControllers = self.viewControllers;
    NSArray * newViewControllers = [NSArray arrayWithObjects:[viewControllers objectAtIndex:0], navController, nil];
    [self setViewControllers:newViewControllers];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
