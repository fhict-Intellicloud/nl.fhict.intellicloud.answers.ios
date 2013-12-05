//
//  InboxViewController.h
//  Answers
//
//  Created by Lex Nicolaes on 03-12-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CustomTableCell.h"


@interface InboxViewController : BaseViewController

@property (strong, nonatomic) IBOutlet UITableView *inboxTableView;

@end
