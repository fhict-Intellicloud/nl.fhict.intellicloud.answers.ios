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
    
    [self.inboxTableView setRowHeight:86];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CustomCell";
    CustomTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (CustomTableCell *)[CustomTableCell cellFromNibNamed:@"CustomCellView"];
    }
    
    cell.state = stateRejected;
    cell.LabelName.text = @"Paul PHP Poos";
    cell.LabelTime.text = @"3 minuten geleden";
    cell.LabelQuestion.text = @"Hoe stel ik internet in?";
    
    return cell;
}

@end
