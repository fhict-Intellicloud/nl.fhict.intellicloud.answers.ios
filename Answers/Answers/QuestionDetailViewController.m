//
//  QuestionDetailViewController.m
//  Answers
//
//  Created by Lex Nicolaes on 04-12-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import "QuestionDetailViewController.h"

@interface QuestionDetailViewController () <UITextViewDelegate>

@end

@implementation QuestionDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Localize the title
    self.title = NSLocalizedString(@"AnswerQuestion", nil);
    
    //Localize the labels
    _questionLabel.text = [NSLocalizedString(@"TheQuestion", nil) uppercaseString];
    _answerLabel.text = [NSLocalizedString(@"Answer", nil) uppercaseString];
    
    //Show the selected question
    _questionTextView.text = _selectedQuestion.content;
    
    //Localize the buttons and set the styling color
    [_sendAnswerButton setTitle:NSLocalizedString(@"SendAnswer", nil) forState:UIControlStateNormal];
    [_sendAnswerButton setTitleColor:[UIColor buttonLabelTextColor] forState:UIControlStateNormal];
    
    [_reviewByColleagueButton setTitle:NSLocalizedString(@"ReviewColleague", nil) forState:UIControlStateNormal];
    [_reviewByColleagueButton setTitleColor:[UIColor buttonLabelTextColor] forState:UIControlStateNormal];
    
    //Add a inputAccessory to hide the keyboard when typing an answer.
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", nil) style:UIBarButtonItemStyleDone target:_answerTextView action:@selector(resignFirstResponder)];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolbar.items = [NSArray arrayWithObject:barButton];
    
    _answerTextView.inputAccessoryView = toolbar;
    
    //Set answerTextView delegate to self to mimic placeholder effect
    _answerTextView.delegate = self;
    
    //Localize placeholder text
    _answerPlaceholderLabel.text = NSLocalizedString(@"WriteAnswerHere", nil);
}

/**
 *@brief Hide the placeholderlabel in the answerTextView to mimic the placholder effect
 */
- (void)textViewDidEndEditing:(UITextView *)textView {
    if(![_answerTextView hasText]) {
        _answerPlaceholderLabel.hidden = NO;
    }
}

/**
 *@brief Hide or show the placeholderlabel in the answerTextView to mimic the placeholder effect
 */
-(void) textViewDidChange:(UITextView *)textView {
    if(![_answerTextView hasText]) {
        _answerPlaceholderLabel.hidden = NO;
    }
    else{
        _answerPlaceholderLabel.hidden = YES;
    }
}

/**
 * @brief Sends the answer data to the service
 */
- (IBAction)sendAnswer:(id)sender {
    NSDictionary *parameters = @{@"questionId": [NSString stringWithFormat:@"%ld",(long)_selectedQuestion.questionID],
                                 @"answer": _answerTextView.text,
                                 @"answererId":@"1",
                                 @"answerState":@"1"};
    
    [Answer postAnswerWithParameters:parameters withBlock:^(NSError* error){
        if(error)
        {
            NSLog(@"%@", error.description);
        }
    }];
}

@end
