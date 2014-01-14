//
//  MenuViewController.m
//  Answers
//
//  Created by Lex Nicolaes on 02-12-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import "MenuViewController.h"
#import "Question.h"
#import "User.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)awakeFromNib
{
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
	    self.clearsSelectionOnViewWillAppear = NO;
	    self.preferredContentSize = CGSizeMake(320.0, 600.0);
	}
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Setup table data
    _menuItems = @[
                   @[
                       @{@"title": NSLocalizedString(@"Inbox", nil), @"icon": @"", @"predicate": [NSPredicate predicateWithFormat:@"questionState == %d", QuestionStateUpForAnswer]},  //implement predicates
                       @{@"title": NSLocalizedString(@"Open", nil), @"icon": @"MenuIconOpen", @"predicate": [NSPredicate predicateWithFormat:@"questionState == %d", QuestionStateOpen]},
                       @{@"title": NSLocalizedString(@"Rejected", nil), @"icon": @"MenuIconRejected", @"predicate": [NSPredicate predicateWithFormat:@"questionState == %d", QuestionStateOpen]},
                       @{@"title": NSLocalizedString(@"Pending", nil), @"icon": @"MenuIconPending", @"predicate": @"pendingViewController"},
                       @{@"title": NSLocalizedString(@"Review", nil), @"icon": @"MenuIconReview", @"predicate": @"reviewViewController"}],
                   @[
                       @{@"title": NSLocalizedString(@"About IntelliCloud", nil), @"icon": @"", @"id": @"aboutViewController"}],  ///rename id to storyboard id?
                   @[
                       @{@"title": NSLocalizedString(@"Sign out", nil), @"icon": @"MenuIconSignOut", @"action": @"inboxViewController"}]];  //implement action
	
    // TableView settings
	
	// Different backgroundColor for iPhone and iPad
	if(IS_IPHONE)
	{
		// Set background color to clear
		self.tableView.backgroundColor = [UIColor clearColor];
	}
	else if(IS_IPAD)
	{
		// Set title of master part in SplitViewController
		self.title = @"IntelliCloud";
		
		// Clear background color of tableView
		self.tableView.backgroundColor = [UIColor clearColor];
		
		// Create UIImage for menu background
		UIImage *menuBackgroundImage = [UIImage imageNamed:@"MenuBackgroundiPad"];
		
		self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:menuBackgroundImage];
		
		self.detailViewController = (QuestionsTableViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
	}
	
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = YES;
    self.tableView.scrollsToTop = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.scrollEnabled = NO;
	
	// Static height for tableviewcell, see storyboard
    self.tableView.rowHeight = MenuTableCellHeight;
    
    // Set avatar for authenticated user
    // todo: retrieve dynamically from AuthenticationManager or backend
    _currentUserImageView.clipsToBounds = YES;
    _currentUserImageView.layer.cornerRadius = _currentUserImageView.frame.size.width / 2; // half of the width
    _currentUserImageView.layer.borderColor = [UIColor colorWithWhite:1.0f alpha:0.55f].CGColor;
    _currentUserImageView.layer.borderWidth = 0.7f;
    
    //Present LoginViewController if not logged in
    if (![[AuthenticationManager sharedClient] checkAutentication])
    {
        UIViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        if (IS_IPAD) {
            [self.splitViewController presentViewController:vc animated:NO completion:nil];
        }
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadUserInfo) name:kLoggedInNotification object:nil];
}

- (void)loadUserInfo
{
    NSLog(@"Load user info");
    
    // Reset
    
    
    [User getAuthorizedUserWithBlock:^(User *user, NSError *error)
    {
        if (!error)
        {
            [_currentUserImageView setImageWithURL:[NSURL URLWithString:user.avatarURL] placeholderImage:[UIImage imageNamed:@"UserIcon"]];
            
            // Set username label
            NSString *authorText = NSLocalizedString(@"Unknown user", nil);
            if (user.firstname != nil && user.lastname != nil)
            {
                // Prepare infix, add suffix space when we have a infix
                NSString *infix = user.infix != nil ? [NSString stringWithFormat:@" %@ ", user.infix] : @" ";
                authorText = [NSString stringWithFormat:@"%@%@%@", user.firstname, infix, user.lastname];
            }
            
            _currentUserLabel.text = authorText;
        }
    }];
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(IS_IPHONE)
	{
		// Deselect row
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
		
		// Get data item for this row
		NSDictionary *itemForRow = [[_menuItems objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
		
		// Get navigation controller for sliding menu
		UINavigationController *navigationController = (UINavigationController *)self.sideMenuViewController.contentViewController;
		
		// Get root view of navigation controller
		UIViewController *rootView = navigationController.viewControllers[0];
		
		//NSStringFromClass([)
		
		
		// Check for @vc property... current vc == target vc do nothing, else make a new one and push it
		
		// press logout? do it
		if ([[itemForRow valueForKey:@"title"] isEqualToString:NSLocalizedString(@"About IntelliCloud", nil)])
		{
			navigationController.viewControllers = @[[self.storyboard instantiateViewControllerWithIdentifier:@"aboutViewController"]];
		}
		// press logout? do it
		else if ([[itemForRow valueForKey:@"title"] isEqualToString:NSLocalizedString(@"Sign out", nil)])
		{
			[[AuthenticationManager sharedClient] signOut];
			[[navigationController.viewControllers objectAtIndex:0] presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"loginViewController"] animated:NO completion:nil];
		}
		// do we have a @predicate? set it
		else if ([[itemForRow objectForKey:@"predicate"] isKindOfClass:[NSPredicate class]])
		{
            if (![rootView respondsToSelector:@selector(filterTableWithPredicate:)])
            {
                navigationController.viewControllers = @[[self.storyboard instantiateViewControllerWithIdentifier:@"questionsViewController"]];
                // Get root view of navigation controller
                rootView = navigationController.viewControllers[0];
            }

			NSLog(@"Setting predicate %@", (NSPredicate *)[itemForRow objectForKey:@"predicate"]);
			QuestionsTableViewController *questionsTable = (QuestionsTableViewController *)rootView;
			[questionsTable filterTableWithPredicate:(NSPredicate *)[itemForRow objectForKey:@"predicate"]];
		}
		
		// do we have an action? run it
		
		// set title, maybe check for @nav_title property first?
		rootView.title = (NSString *)[itemForRow objectForKey:@"title"];
		
		// we just assume there is one "special" property in the data source
		
		// Get item for this row
		//NSDictionary *itemForRow = [[_menuItems objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
		// Instantiate vc from the storyboard using id from datasource
		//navigationController.viewControllers = @[[self.storyboard instantiateViewControllerWithIdentifier:[itemForRow valueForKey:@"id"]]];
		/*NSDictionary *itemForRow = [[_menuItems objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
		 
		 if ([[itemForRow valueForKey:@"title"] isEqualToString:NSLocalizedString(@"Sign out", nil)])
		 {
		 [[AuthenticationManager sharedClient] signOut];
		 [[navigationController.viewControllers objectAtIndex:0] presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"loginViewController"] animated:NO completion:nil];
		 }
		 else
		 {
		 // Instantiate vc from the storyboard using id from datasource
		 navigationController.viewControllers = @[[self.storyboard instantiateViewControllerWithIdentifier:[itemForRow valueForKey:@"id"]]];
		 }*/
		
		// Hide the side menu
		[self.sideMenuViewController hideMenuViewController];
	}
	else if(IS_IPAD)
	{
		// Deselect row
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
		
		// Get data item for this row
		NSDictionary *itemForRow = [[_menuItems objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
		
		// press logout? do it
		if ([[itemForRow valueForKey:@"title"] isEqualToString:NSLocalizedString(@"About IntelliCloud", nil)])
		{
			// About
			
			// Get reference to answerDetailViewController
			UIViewController *aboutViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"aboutViewController"];
			
			// Replace detail viewController
			MainNavigationController *navController = [[MainNavigationController alloc] initWithRootViewController:aboutViewController];
			
			// Get array of viewControllers
			NSArray * viewControllers = self.splitViewController.viewControllers;
			
			// Replace array with new navigationController object
			NSArray * newViewControllers = [NSArray arrayWithObjects:[viewControllers objectAtIndex:0], navController, nil];
			[self.splitViewController setViewControllers:newViewControllers];
		}
		// press logout? do it
		else if ([[itemForRow valueForKey:@"title"] isEqualToString:NSLocalizedString(@"Sign out", nil)])
		{
			// Login
			
			[[AuthenticationManager sharedClient] signOut];
			[self.navigationController.splitViewController presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"loginViewController"] animated:NO completion:nil];
		}
		// do we have a @predicate? set it
		else
		{
			QuestionsTableViewController *questionsTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"questionsViewController"];
			[questionsTableViewController filterTableWithPredicate:(NSPredicate *)[itemForRow objectForKey:@"predicate"]];
			
			questionsTableViewController.title = (NSString *)[itemForRow objectForKey:@"title"];
			
			[self.navigationController pushViewController:questionsTableViewController animated:YES];
		}
	}
}

/*- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
	return NO;
}*/

#pragma mark -
#pragma mark UITableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	// Return the number of sections
    return [_menuItems count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
	// Return the number of rows in the section
    return [[_menuItems objectAtIndex:sectionIndex] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"LeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier  forIndexPath:indexPath];
	
	// Custom view for the cell background when selected cell
	UIView *cellBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
	// White background color with transparency
	cellBackgroundView.backgroundColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.3];
	// Set custom view to selectedBackgroundView
	cell.selectedBackgroundView = cellBackgroundView;
	// Set cell background color to clear
	cell.backgroundColor = [UIColor clearColor];
	
	// Get item for this row from datasource
	NSDictionary *itemForRow = [[_menuItems objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	
	if (![(NSString*)[itemForRow valueForKey:@"icon"] isEqualToString:@""])
	{
		// Get icon imageview from storyboard
		UIImageView *titleImageView = (UIImageView *)[cell.contentView viewWithTag:101];
		// Get icon image from datasource
		UIImage *titleImage = [UIImage imageNamed:[itemForRow valueForKey:@"icon"]];
		// Set image to icon imageview
		[titleImageView setImage:titleImage];
	}
	
	// Get label from storyboard
	UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:102];
	titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
	titleLabel.textColor = [UIColor whiteColor];
	titleLabel.backgroundColor = [UIColor clearColor];
	titleLabel.text = [itemForRow valueForKey:@"title"];
    
    return cell;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

// Send to the QuestionsTableViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    QuestionsTableViewController *questionDetailController = segue.destinationViewController;
	
	NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
	
	NSDictionary *itemForRow = [[_menuItems objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	NSLog(@"ITEM: %@", itemForRow);
	[questionDetailController filterTableWithPredicate:(NSPredicate *)[itemForRow objectForKey:@"predicate"]];
	
	questionDetailController.title = (NSString *)[itemForRow objectForKey:@"title"];
	
}

@end

