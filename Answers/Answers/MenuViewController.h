//
//  MenuViewController.h
//  Answers
//
//  Created by Lex Nicolaes on 02-12-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RESideMenu/RESideMenu.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

/**
 * TableViewCell height for menu
 */
static CGFloat const MenuTableCellHeight = 46.0f;

@interface MenuViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, RESideMenuDelegate>

@property (nonatomic, retain) NSArray *menuItems;

/**
 * @property currentUserImageView
 * @brief IBOutlet of imageView with the image of the logged in user
 */
@property (strong, nonatomic) IBOutlet UIImageView *currentUserImageView;

/**
 * @property currentUserLabel
 * @brief IBOutlet of label with the name of the logged in user
 */
@property (strong, nonatomic) IBOutlet UILabel *currentUserLabel;

@end
