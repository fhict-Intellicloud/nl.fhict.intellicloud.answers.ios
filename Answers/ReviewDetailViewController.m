//
//  ReviewDetailViewController.m
//  Answers
//
//  Created by Bram Kersten on 04-12-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import "ReviewDetailViewController.h"

@interface ReviewDetailViewController () <UITextViewDelegate>

@end

@implementation ReviewDetailViewController

@synthesize questionTextView, answerColleagueTableView, commentsTextView, commentsPlaceholderLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow) name:UIKeyboardDidShowNotification object:nil];
	
	//Add a inputAccessory to hide the keyboard when typing an answer.
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", nil) style:UIBarButtonItemStyleDone target:commentsTextView action:@selector(resignFirstResponder)];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolbar.items = [NSArray arrayWithObject:barButton];
    
    commentsTextView.inputAccessoryView = toolbar;
    
    //Set answerTextView delegate to self to mimic placeholder effect
    commentsTextView.delegate = self;
    
    //Localize placeholder text
    commentsPlaceholderLabel.text = NSLocalizedString(@"WriteAnswerHere", nil);
}

/**
 *@brief Hide the commentsPlaceholderLabel in the commentsTextView to mimic the placholder effect
 */
- (void)textViewDidEndEditing:(UITextView *)textView {
    if(![commentsTextView hasText]) {
        commentsPlaceholderLabel.hidden = NO;
    }
}

/**
 *@brief Hide or show the commentsPlaceholderLabel in the commentsTextView to mimic the placeholder effect
 */
-(void) textViewDidChange:(UITextView *)textView {
    if(![commentsTextView hasText]) {
        commentsPlaceholderLabel.hidden = NO;
    }
    else{
        commentsPlaceholderLabel.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) keyboardDidShow {
	
	[self animateTextField:commentsTextView up:YES];
}

- (void) animateTextField: (UITextView*) textView up: (BOOL) up
{
    const int movementDistance = 150; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
	
    int movement = (up ? -movementDistance : movementDistance);
	
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

@end
