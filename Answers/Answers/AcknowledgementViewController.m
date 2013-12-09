//
//  AcknowledgementViewController.m
//  Answers
//
//  Created by Paul Poos on 05-12-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import "AcknowledgementViewController.h"

@interface AcknowledgementViewController ()

@end

@implementation AcknowledgementViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //Localize the title
    self.title = NSLocalizedString(@"Info", nil);
    
    // Get the acknowledgements file from Cocoapods and set the text in the view
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"Pods-acknowledgements" ofType:@"markdown"];
    NSString *acknowledgements =[NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:nil];
    _infoTextView.text = acknowledgements;    
}

@end
