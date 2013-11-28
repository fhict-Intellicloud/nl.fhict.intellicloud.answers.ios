//
//  QuestionDetailViewController.h
//  Answers
//
//  Created by user on 26/11/13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"
#import "WebserviceManager.h"
#import "Answer.h"


@interface QuestionDetailViewController : UIViewController 

/**
 * @brief A action connected to the answerButton to send an answer to the service.
 */
- (IBAction)sendAnswer:(id)sender;

/**
 * @property questionLabel
 * @brief A property for the questionLabel to use localized strings.
 */
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

/**
 * @property answerLabel
 * @brief A property for the answerLabel to use localized strings.
 */
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;

/**
 * @property sendAnswerButton
 * @brief A property for the answer button to use localized strings and tintcolor from style.
 */
@property (weak, nonatomic) IBOutlet UIButton *sendAnswerButton;

/**
 * @property reviewByColleagueButton
 * @brief A property for the review button to use localized strings and tintcolor from style.
 */
@property (weak, nonatomic) IBOutlet UIButton *reviewByColleagueButton;

/**
 * @property selectedQuestion
 * @brief The selected question from the QuestionTableViewController.
 */
@property (strong, nonatomic) Question *selectedQuestion;

/**
 * @property questionTextView
 * @brief A property for the questionTextView to set it to selectedQuestion.content.
 */
@property (weak, nonatomic) IBOutlet UITextView *questionTextView;

/**
 * @property answerTextView
 * @brief A property for the answerTextView to get the given answer.
 */
@property (weak, nonatomic) IBOutlet UITextView *answerTextView;

@end
