//
//  QuestionDetailViewController.m
//  Answers
//
//  Created by user on 26/11/13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import "QuestionDetailViewController.h"

@interface QuestionDetailViewController ()



@end

@implementation QuestionDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"AnswerQuestion", nil);
    
    _questionLabel.text = [NSLocalizedString(@"TheQuestion", nil) uppercaseString];
    
    _answerLabel.text = [NSLocalizedString(@"Answer", nil) uppercaseString];
    
    _questionTextView.text = _selectedQuestion.content;
    
    [_sendAnswerButton setTitle:NSLocalizedString(@"SendAnswer", nil) forState:UIControlStateNormal];
    [_sendAnswerButton setTitleColor:[UIColor buttonLabelTextColor] forState:UIControlStateNormal];
    
    [_reviewByColleagueButton setTitle:NSLocalizedString(@"ReviewColleague", nil) forState:UIControlStateNormal];
    [_reviewByColleagueButton setTitleColor:[UIColor buttonLabelTextColor] forState:UIControlStateNormal];
}

- (IBAction)sendAnswer:(id)sender {
    NSDictionary *parameters = @{@"questionId": [NSString stringWithFormat:@"%ld",_selectedQuestion.questionID],
                                 @"answer": _answerTextView.text,
                                 @"answererId":@"1",
                                 @"answerState":@"1"};
    
    [Answer withParameters:parameters postAnswerWithBlock:^(NSError* error){
        if(error)
        {
            NSLog(@"%@", error.description);
        }
    }];
}

@end
