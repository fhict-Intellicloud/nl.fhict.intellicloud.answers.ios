//
//  MenuViewController.h
//  Answers
//
//  Created by Lex Nicolaes on 02-12-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UITableViewController

/**
 * Handler for topvc to menu segue
 */
- (IBAction)unwindToMenuViewController:(UIStoryboardSegue *)segue;

@end
