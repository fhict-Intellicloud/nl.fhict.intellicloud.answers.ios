//
//  AppDelegate.m
//  Answers
//
//  Created by Joris Vervuurt on 20-11-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import "AppDelegate.h"
#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Set application background fetch interval
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
	
	// Override point for customization after application launch.
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
	    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
	    UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
	    splitViewController.delegate = (id)navigationController.topViewController;
	}
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                break;
            case AFNetworkReachabilityStatusNotReachable:
                [SVProgressHUD showErrorWithStatus:@"U bent niet verbonden met het internet!"];
                break;
            default:
                break;
        }
    }];
    [manager startMonitoring];
	
    return YES;
}

/**
 * gets called when a background fetch is performed
 */
- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    /*// Get rootviewcontroller (tabbar)
    UITabBarController *rootViewController = (UITabBarController *)self.window.rootViewController;
    
    // Get tableview for selected tab
    // We presume this matches the setup in the Storyboard
    id childViewController = [rootViewController.selectedViewController.childViewControllers firstObject];
    
    // Check if table supports bakground fetching
    if([childViewController respondsToSelector:@selector(reloadForFetchWithCompletionHandler:)])
    {
        // Perform fetch, completion is handled inline
        [childViewController reloadForFetchWithCompletionHandler:completionHandler];
    }
    
    // Return failed status when background fetching in unavailable for the current tab
    completionHandler(UIBackgroundFetchResultFailed);*/
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    // Save the persistent store data
    [[PersistentStoreManager sharedClient] saveData];
}

@end
