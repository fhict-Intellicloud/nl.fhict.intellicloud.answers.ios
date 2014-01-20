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
#import "BaseTableViewController.h"
#import "Question.h"
#import "Source.h"
#import "AnswerDetailViewController.h"
#import "AuthenticationManager.h"

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

@class AnswerDetailViewController;

/**
 * TableView for holding questions
 */
@interface QuestionsTableViewController : BaseTableViewController

@property (strong, nonatomic) AnswerDetailViewController *answerDetailViewController;

/**
 * @property tableData
 * @brief Holds questions to be shown in the TableView, values are loaded from WS
 */
@property (readwrite, strong, nonatomic) NSPredicate *predicate;
@property (readwrite, strong, nonatomic) NSMutableArray *rawData;
@property (readwrite, strong, nonatomic) NSArray *tableData;

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

/**
 * Apply the NSPredicate to the table data and reload the table
 */
-(void)filterTableWithPredicate;

/**
 * Apply a NSPredicate to the table data
 * @param predicate to use
 */
- (void)filterTableWithPredicate:(NSPredicate *)predicate;

/**
  * PopOverController for iPad menu
 */
@property (strong, nonatomic) UIPopoverController *masterPopoverController;

@end
