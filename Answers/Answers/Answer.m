//
//  Answer.m
//  Answers
//
//  Created by user on 28/11/13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import "Answer.h"

@implementation Answer

/**
 * Sends a answer with the WebserviceManager SharedInstance.
 * @param parameters: parameters for the service
 */
+ (NSURLSessionDataTask *) postAnswerWithParameters:(NSDictionary*) parameters withBlock: (void (^)(NSError *error))block
{
    return [[WebserviceManager sharedClient] POST:@"CreateAnswer" parameters:parameters
            success:^(NSURLSessionDataTask *task, id responseObject) {
                if (block) {
                    block(nil);
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error){
                if (block) {
                    block(error);
                }
            }];
}

@end
