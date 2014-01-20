//
//  BaseDetailViewController.h
//  Answers
//
//  Created by Bram Kersten on 08-01-14.
//  Copyright (c) 2014 IntelliCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) UIPopoverController *masterPopoverController;

@end