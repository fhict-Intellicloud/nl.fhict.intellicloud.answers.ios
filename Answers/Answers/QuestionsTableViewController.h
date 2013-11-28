//
//  QuestionsTableViewController.h
//  Answers
//
//  Created by Lex Nicolaes on 21-11-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FormatterKit/TTTTimeIntervalFormatter.h>
#import <FormatterKit/TTTColorFormatter.h>
#import "Question.h"
#import "QuestionDetailViewController.h"

NS_ENUM(NSUInteger, webServiceDataState)
{
    webServiceDataStateNoData,
    webServiceDataStateNewData,
    webServiceDataStateFailed
};

/**
 * TableViewCell height for question
 */
static CGFloat const QuestionTableCellHeight = 82.0f;

/**
 * TableView for holding questions
 */
@interface QuestionsTableViewController : UITableViewController

/**
 * @property questions
 * @brief Holds questions to be shown in the TableView, values are loaded from WS
 */
@property (readwrite, nonatomic, strong) NSMutableArray *questions;

/**
 * @brief Loads data from the webservice and reloads the tableview
 * @param sender of the object (unused)
 */
- (bool)reload:(__unused id)sender;

/**
 * @brief Reloads data for background fetch
 * @param UIBackgroundFetchResult completion handler block
 */
- (void)reloadForFetchWithCompletionHandler:(void(^)(UIBackgroundFetchResult))completionHandler;

@end
