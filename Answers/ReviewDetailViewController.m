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

@synthesize questionTextView, answerColleagueTableView, commentsTextView, commentsPlaceholderLabel, questionLabel, answerColleagueLabel, commentsLabel, sendReviewButton;

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
	
	// Set navigationBar title localized string
	self.title = NSLocalizedString(@"ReviewAnswer", nil);
	
	// Set questionLabel localized string
    questionLabel.text = [NSLocalizedString(@"Question", nil) uppercaseString];
	
	// Set questionLabel localized string
    questionTextView.text = @"The question";
	
	// to-do: get question from previous screen and set it to questionTextView
    
    // Set answerColleagueLabel localized string
    answerColleagueLabel.text = [NSLocalizedString(@"AnswerColleague", nil) uppercaseString];
	
	// Set commentsLabel localized string
    commentsLabel.text = [NSLocalizedString(@"YourComments", nil) uppercaseString];
	
	// Set sendReviewButton localized string
	[sendReviewButton setTitle:NSLocalizedString(@"SendReview", nil) forState:UIControlStateNormal];
	
	// Notification which ensures that view animates to top when keyboard appears
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow) name:UIKeyboardDidShowNotification object:nil];
	
	//Add a inputAccessory to hide the keyboard when typing an answer.
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", nil) style:UIBarButtonItemStyleDone target:commentsTextView action:@selector(resignFirstResponder)];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
	// Change the tintColor of the toolbar to IntelliCloud navigationBarTintColor
	toolbar.tintColor = [UIColor navigationBarTintColor];
	// Set barButton as item of the toolbar
    toolbar.items = [NSArray arrayWithObject:barButton];
    
    commentsTextView.inputAccessoryView = toolbar;
    
    //Set answerTextView delegate to self to mimic placeholder effect
    commentsTextView.delegate = self;
    
    //Localize placeholder text
    commentsPlaceholderLabel.text = NSLocalizedString(@"WriteReviewHere", nil);
}

/**
 *@brief Hide the commentsPlaceholderLabel in the commentsTextView to mimic the placholder effect
 */
- (void)textViewDidEndEditing:(UITextView *)textView {
    if(![commentsTextView hasText]) {
        commentsPlaceholderLabel.hidden = NO;
    }
	
	// Animate view to bottom
	[self animateTextField:commentsTextView up:NO];
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
	
	// Call animate textfield when keyboard did show
	[self animateTextField:commentsTextView up:YES];
}

- (void) animateTextField: (UITextView*) textView up: (BOOL) up
{
	// Movement distance of the view when keyboard appears
    const int movementDistance = 200;
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of rows in the section
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"AnswerOfColleagueCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
	// Set title of cell
	UILabel *answerTitle = (UILabel *)[cell.contentView viewWithTag:100];
	answerTitle.text = @"Answer";
	
	// todo: Get answer from backend and set it to the label
	
    // todo: Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	// Deselect row when returning to this viewController
	[answerColleagueTableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
