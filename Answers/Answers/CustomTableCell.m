//
//  CustomTableCell.m
//  Answers
//
//  Created by Ferdi Duisters on 05-12-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import "CustomTableCell.h"

@implementation CustomTableCell

- (void) setState:(myState)state;
{
    switch(state){
        case stateOpen:
            _CellImage.image = [UIImage imageNamed:@"MenuIconOpen"];
            break;
        case statePending:
            _CellImage.image = [UIImage imageNamed:@"MenuIconPending"];
            break;
        case stateRejected:
            _CellImage.image = [UIImage imageNamed:@"MenuIconRejected"];
            break;
        case stateReview:
            _CellImage.image = [UIImage imageNamed:@"MenuIconReview"];
            break;
        default:
            _CellImage.image = [UIImage imageNamed:@"MenuIconOpen"];
            break;
    }
    
}

+ (CustomTableCell *)cellFromNibNamed:(NSString *)nibName {
    
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:NULL];
    NSEnumerator *nibEnumerator = [nibContents objectEnumerator];
    CustomTableCell *xibBasedCell = nil;
    NSObject* nibItem = nil;
    
    while ((nibItem = [nibEnumerator nextObject]) != nil) {
        if ([nibItem isKindOfClass:[CustomTableCell class]]) {
            xibBasedCell = (CustomTableCell *)nibItem;
            break;
        }
    }
    
    return xibBasedCell;
}

@end
