//
//  ReviewDetailViewController.h
//  Answers
//
//  Created by Paul Poos on 04-12-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"
#import "WebserviceManager.h"
#import "User.h"
#import "Answer.h"
#import "BaseDetailViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface AnswerDetailViewController : BaseDetailViewController

/**
 * @property selectedQuestion
 * @brief The selected question from the QuestionTableViewController.
 */
@property (strong, nonatomic) Question *selectedQuestion;

/**
 * @property questionLabel
 * @brief Textlabel for question
 */
@property (strong, nonatomic) IBOutlet UILabel *questionLabel;

/**
 * @property questionTextbox
 * @brief Textbox for question
 */
@property (strong, nonatomic) IBOutlet UITextView *questionTextbox;

/**
 * @property answerLabel
 * @brief Textlabel for answer
 */
@property (strong, nonatomic) IBOutlet UILabel *answerLabel;

/**
 * @property answerTextbox
 * @brief Input textbox for answer
 */
@property (strong, nonatomic) IBOutlet UITextView *answerTextbox;

/**
 * @property answerPlaceholderLabel
 * @brief A property for the answerPlaceholderLabel to mimic the placeholder effect.
 */
@property (strong, nonatomic) IBOutlet UILabel *answerPlaceholderLabel;

/**
 * @property barItem
 * @brief A bar button item for the menu on iPad
 */
@property (strong, nonatomic) UIBarButtonItem *barItem;

@end
