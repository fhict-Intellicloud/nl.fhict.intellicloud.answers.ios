//
//  InboxViewController.m
//  Answers
//
//  Created by Lex Nicolaes on 03-12-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import "InboxViewController.h"

@interface InboxViewController ()

@end

@implementation InboxViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Inbox", nil);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"PATHHHH %ld", (long)indexPath.row);
    static NSString *CellIdentifier = @"indexTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UILabel *inboxNameLabel = (UILabel *)[cell.contentView viewWithTag:301];
    UIImageView *inboxImage = (UIImageView *)[cell.contentView viewWithTag:302];
    UILabel *inboxTimeLabel = (UILabel *)[cell.contentView viewWithTag:303];
    UILabel *inboxQuestionLabel = (UILabel *)[cell.contentView viewWithTag:304];
    
    
    
    switch(indexPath.row)
    {
        case 0:
            inboxImage.image = [UIImage imageNamed:@"HourglassIcon"];
            inboxNameLabel.text = @"Paul PHP Poos";
            inboxTimeLabel.text = @"3 minuten geleden";
            inboxQuestionLabel.text = @"Hoe stel ik internet in?";
            break;
        case 1:
            inboxImage.image = [UIImage imageNamed:@"GlassesIcon"];
            inboxNameLabel.text = @"Lex Mastergenie";
            inboxTimeLabel.text = @"3 minuten geleden";
            inboxQuestionLabel.text = @"Hoe maak ik een Xcode project aan?";
            break;
        case 2:
            inboxImage.image = [UIImage imageNamed:@"QuestionmarkIcon"];
            inboxNameLabel.text = @"Gadget Ferdi";
            inboxTimeLabel.text = @"3 minuten geleden";
            inboxQuestionLabel.text = @"Hoe voeg ik Sencha Touch toe aan Phonegap?";
            break;
        case 3:
            inboxImage.image = [UIImage imageNamed:@"StopsignIcon"];
            inboxNameLabel.text = @"Bram iOS Kersten";
            inboxTimeLabel.text = @"3 minuten geleden";
            inboxQuestionLabel.text = @"Android Imageview wilt niet lukken?";
            break;
        default:
            inboxImage.image = [UIImage imageNamed:@"StopsignIcon"];
            inboxNameLabel.text = @"Some user";
            inboxTimeLabel.text = @"Some X minutes";
            inboxQuestionLabel.text = @"Some question";
            break;
    }
    
    //inboxImage.image = [UIImage imageNamed:@"HourglassIcon"];
    
    
    //inboxLabel.text = @"This is test data for my cell";
    
    
    // Configure the cell...
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

@end
