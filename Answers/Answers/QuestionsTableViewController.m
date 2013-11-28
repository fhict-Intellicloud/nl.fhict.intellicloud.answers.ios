//
//  QuestionsTableViewController.m
//  Answers
//
//  Created by Lex Nicolaes on 21-11-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import "QuestionsTableViewController.h"

@interface QuestionsTableViewController ()

@end

/**
 * TableView for holding questions
 */
@implementation QuestionsTableViewController

/*
 * @brief set formatting of table on VC load
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set table seperator inset to line up with content text
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0.0f, 50.0f, 0.0f, 0.0f)];
    
    // Add pull to refresh control
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(reload:) forControlEvents:UIControlEventValueChanged];
    refresh.tintColor = [UIColor tableTintColor];
    self.refreshControl = refresh;
    
    TTTColorFormatter *cf = [[TTTColorFormatter alloc] init];
    self.tableView.backgroundColor = [cf colorFromHexadecimalString:@"#fcfcfc"];
    
    // Set title
    self.title = NSLocalizedString(@"Questions", nil);
    
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Back", nil)
                                     style:UIBarButtonItemStyleBordered
                                    target:nil action:nil];
    // Static height for tableviewcell, see storyboard
    self.tableView.rowHeight = QuestionTableCellHeight;
    
    // Load questions for view
    [self reload:nil];
}

/**
 * @brief Loads data from the webservice and reloads the tableview
 */
- (bool)reload:(__unused id)sender
{
    // return state succeesed/failed
    __block bool state = NO;
    
    // retrieve data from webservice
    [Question getQuestionsWithBlock:^(NSArray *questions, NSError *error)
    {
        if (!error)
        {
            // Set questions array with retrieved questions
            self.questions = (NSMutableArray *)questions;
            
            // reload the table
            [self.tableView reloadData];
            
            state = YES;
        }
    }];
    
    [self.refreshControl endRefreshing];
    
    return state;
}

/**
 * @brief Reloads data for background fetch
 */
- (void)reloadForFetchWithCompletionHandler:(void(^)(UIBackgroundFetchResult))completionHandler
{
    UIBackgroundFetchResult result = UIBackgroundFetchResultFailed;
    
    if ([self reload:nil])
    {
        result = UIBackgroundFetchResultNewData;
    }
    
    completionHandler(result);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Count nr of items in questions array
    return (NSInteger)[_questions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"QuestionCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Get question for this row
    Question *question = (Question *)[_questions objectAtIndex:indexPath.row];
    
    // Get author label from storyboard
    UILabel *authorLabel = (UILabel *)[cell.contentView viewWithTag:100];
    
    // Prepare infix, add suffix space when we have a infix
    NSString *infix = question.questionUser.infix ? [NSString stringWithFormat:@"%@ ", question.questionUser.infix] : nil;
    
    // Set author label
    authorLabel.text = [NSString stringWithFormat:@"%@ %@%@", question.questionUser.firstname, infix, question.questionUser.lastname];
    
    // Get time label from storyboard
    UILabel *timeLabel = (UILabel *)[cell.contentView viewWithTag:110];
    
    // Set time label (static for now)
    timeLabel.text = @"just now";
    
    // Get question label from storyboard
    UILabel *questionLabel = (UILabel *)[cell.contentView viewWithTag:130];
    
    // Set question label
    questionLabel.text = question.content;
    
    return cell;
}

/*- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Static height for tableviewcell, see storyboard
    return 82.0f;
}*/

#pragma mark - Navigation

// Send the selected question to the QuestionDetailController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    QuestionDetailViewController *questionDetailController = segue.destinationViewController;
    questionDetailController.selectedQuestion = (Question *)[_questions objectAtIndex:self.tableView.indexPathForSelectedRow.row];
}

@end
