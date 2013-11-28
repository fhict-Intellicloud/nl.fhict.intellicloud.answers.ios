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

- (IBAction)sendAnswer:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendAnswerButton;
@property (weak, nonatomic) IBOutlet UIButton *reviewByColleagueButton;
@property (strong, nonatomic) Question *selectedQuestion;
@property (weak, nonatomic) IBOutlet UITextView *questionTextView;
@property (weak, nonatomic) IBOutlet UITextView *answerTextView;

@end
