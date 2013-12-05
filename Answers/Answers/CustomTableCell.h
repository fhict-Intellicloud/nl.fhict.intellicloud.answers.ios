//
//  CustomTableCell.h
//  Answers
//
//  Created by Ferdi Duisters on 05-12-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    stateOpen,
    statePending,
    stateRejected,
    stateReview
} myState;

@interface CustomTableCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *CellImage;
@property (strong, nonatomic) IBOutlet UILabel *LabelName;
@property (strong, nonatomic) IBOutlet UILabel *LabelQuestion;
@property (strong, nonatomic) IBOutlet UILabel *LabelTime;

- (void) setState:(myState)state;

+(CustomTableCell *) cellFromNibNamed:(NSString *)nibName;


@end
