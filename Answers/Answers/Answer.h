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

/**
 * Sends a answer with the WebserviceManager SharedInstance.
 * @param parameters: parameters for the service
 */
+ (NSURLSessionDataTask *) postAnswerWithParameters:(NSDictionary*) parameters withBlock: (void (^)(NSError *error))block;

@end
