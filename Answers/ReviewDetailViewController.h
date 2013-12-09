//
//  ReviewDetailViewController.h
//  Answers
//
//  Created by Bram Kersten on 04-12-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewDetailViewController : UIViewController

/**
 * @property questionLabel
 * @brief Label for the question
 */
@property (strong, nonatomic) IBOutlet UILabel *questionLabel;

/**
 * @property questionTextView
 * @brief Textview that holds the question to be shown
 */
@property (strong, nonatomic) IBOutlet UITextView *questionTextView;

/**
 * @property answerColleagueLabel
 * @brief Label for colleague answer
 */
@property (strong, nonatomic) IBOutlet UILabel *answerColleagueLabel;

/**
 * @property answerColleagueTableView
 * @brief Tableview that holds one or more answer(s) of colleague
 */
@property (strong, nonatomic) IBOutlet UITableView *answerColleagueTableView;

/**
 * @property commentsLabel
 * @brief Label for comments
 */
@property (strong, nonatomic) IBOutlet UILabel *commentsLabel;

/**
 * @property commentsTextView
 * @brief Textview where user can type a review
 */
@property (strong, nonatomic) IBOutlet UITextView *commentsTextView;

/**
 * @property commentsPlaceholderLabel
 * @brief Label with the comments placeholder
 */
@property (strong, nonatomic) IBOutlet UILabel *commentsPlaceholderLabel;

/**
 * @property sendReviewButton
 * @brief Button for sending the review
 */
@property (strong, nonatomic) IBOutlet UIButton *sendReviewButton;

@end
