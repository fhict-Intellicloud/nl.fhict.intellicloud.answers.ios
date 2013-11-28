//
//  Answer.h
//  Answers
//
//  Created by user on 28/11/13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WebserviceManager.h"

@interface Answer : NSObject

+ (NSURLSessionDataTask *) postAnswerWithParameters:(NSDictionary*) parameters withBlock: (void (^)(NSError *error))block;

@end
