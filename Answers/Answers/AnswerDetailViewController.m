//
//  ReviewDetailViewController.m
//  Answers
//
//  Created by Paul Poos on 04-12-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import "AnswerDetailViewController.h"

@interface AnswerDetailViewController () <UITextViewDelegate>

@property (strong, nonatomic) UIPopoverController *masterPopoverController;

@end

@implementation AnswerDetailViewController

- (void)viewDidLoad
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [super viewDidLoad];
	
	if(IS_IPHONE)
	{
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
	}
	
	// Set splitViewController delegate to self (for iPad splitView)
	self.splitViewController.delegate = self;
	
    //Localize the title
    self.title = NSLocalizedString(@"Answer", nil);
    
    // Set questionLabel localized string
    _questionLabel.text = [NSLocalizedString(@"Question", nil) uppercaseString];
    
    // Set answerLabel localized string
    _answerLabel.text = [NSLocalizedString(@"Answer", nil) uppercaseString];
    
    _questionTextbox.text = _selectedQuestion.content;
	
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
	toolbar.tintColor = [UIColor navigationBarTintColor];
    _answerTextbox.inputAccessoryView = toolbar;
    
    //Set answerTextView delegate to self to mimic placeholder effect
    _answerTextbox.delegate = self;
    
    //Localize placeholder text
    _answerPlaceholderLabel.text = NSLocalizedString(@"WriteAnswerHere", nil);
	
	if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
	
	// Send answer button
	UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"SendAnswer", nil) style:UIBarButtonItemStylePlain target:self action:@selector(sendAnswerClick:)];
	self.navigationItem.rightBarButtonItem = anotherButton;
}

- (void) keyboardDidShow:(NSNotification *)aNotification
{
	[self animateTextField:_answerTextbox up:YES];
}

- (void) keyboardDidHide:(NSNotification *)aNotification
{
	[self animateTextField:_answerTextbox up:NO];
}

- (void) animateTextField: (UITextView *) textView up: (BOOL) up
{
	// Movement distance of the view when keyboard appears
    const int movementDistance = 100;
	// Movement duration of the view when keyboard appears
    const float movementDuration = 0.3f;
	
    int movement = (up ? -movementDistance : movementDistance);
	
	// Animate UIView when keyboard appears/disappears
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
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
- (void)sendAnswerClick:(id)sender
{
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Sending answer...", nil)];
    
    [User getAuthorizedUserWithBlock:^(User *user, NSError *error) {
        if (!error)
        {
            NSDictionary *parameters = @{@"questionId": [NSString stringWithFormat:@"%li", (long)_selectedQuestion.questionID],
                                         @"answer": _answerTextbox.text,
                                         @"answererId":[NSString stringWithFormat:@"%li", (long)user.userID],
                                         @"answerState":@"0"};
            
            [Answer postAnswerWithParameters:parameters withBlock:^(NSError* error){
                if (!error)
                {
                    [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Answer sent", nil)];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else
                {
                    [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Failed to send answer", nil)];
                }
            }];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Failed to send answer", nil)];
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
#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
	// Bar button item for menu
	barButtonItem.title = NSLocalizedString(@"Menu", @"Menu");
	[self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
	self.masterPopoverController = popoverController;
}
 
- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
	// Called when the view is shown again in the split view, invalidating the button and popover controller.
	[self.navigationItem setLeftBarButtonItem:nil animated:YES];
	self.masterPopoverController = nil;
}

@end
