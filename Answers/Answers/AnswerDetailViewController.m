//
//  ReviewDetailViewController.m
//  Answers
//
//  Created by Paul Poos on 04-12-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import "AnswerDetailViewController.h"

@interface AnswerDetailViewController () <UITextViewDelegate>

@end

@implementation AnswerDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Localize the title
    self.title = NSLocalizedString(@"Answer", nil);
    
    // Set questionLabel localized string
    _questionLabel.text = [NSLocalizedString(@"Question", nil) uppercaseString];
    
    // Set answerLabel localized string
    _answerLabel.text = [NSLocalizedString(@"Answer", nil) uppercaseString];
    
    //Localize the sendAnswer button and set the styling color
    [_sendAnswer setTitle:NSLocalizedString(@"SendAnswer", nil) forState:UIControlStateNormal];
    [_sendAnswer setTitleColor:[UIColor buttonLabelTextColor] forState:UIControlStateNormal];
    
    //Localize the reviewByColleague button and set the styling color
    [_reviewByColleague setTitle:NSLocalizedString(@"ReviewColleague", nil) forState:UIControlStateNormal];
    [_reviewByColleague setTitleColor:[UIColor buttonLabelTextColor] forState:UIControlStateNormal];
    
    //Add a inputAccessory to hide the keyboard when typing an answer.
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", nil) style:UIBarButtonItemStyleDone target:_answerTextbox action:@selector(resignFirstResponder)];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolbar.items = [NSArray arrayWithObject:barButton];
    
    _answerTextbox.inputAccessoryView = toolbar;
    
    //Set answerTextView delegate to self to mimic placeholder effect
    _answerTextbox.delegate = self;
    
    //Localize placeholder text
    _answerPlaceholderLabel.text = NSLocalizedString(@"WriteAnswerHere", nil);
}

/**
 *@brief Hide the placeholderlabel in the answerTextView to mimic the placholder effect
 */
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(![_answerTextbox hasText])
    {
        _answerPlaceholderLabel.hidden = NO;
    }
}

/**
 *@brief Hide or show the placeholderlabel in the answerTextView to mimic the placeholder effect
 */
-(void) textViewDidChange:(UITextView *)textView
{
    if(![_answerTextbox hasText])
    {
        _answerPlaceholderLabel.hidden = NO;
    }
    else
    {
        _answerPlaceholderLabel.hidden = YES;
    }
}

/**
 * Action to send answer
 * @param action sender
 */
- (IBAction)sendAnswerClick:(id)sender
{
    NSDictionary *parameters = @{@"questionId": [NSString stringWithFormat:@"%ld",(long)_selectedQuestion.questionID],
                                 @"answer": _answerTextbox.text,
                                 @"answererId":@"1",
                                 @"answerState":@"1"};
    
    [Answer postAnswerWithParameters:parameters withBlock:^(NSError* error){
        if(error)
        {
            NSLog(@"%@", error.description);
        }
    }];
}

/**
 * Action to review by colleague
 * @param action sender
 */
- (IBAction)reviewByColleagueClick:(id)sender
{
    //todo: add action for colleague review
}

@end
