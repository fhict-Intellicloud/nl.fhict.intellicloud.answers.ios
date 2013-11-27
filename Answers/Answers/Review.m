//
//  Review.m
//  Answers
//
//  Created by Erik Reusken on 27/11/13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import "Review.h"

/**
 * Model representing a Review retreived from the Webservice
 */
@implementation Review

/**
 * Initializes a Review with attributes from a (JSON) dictionary.
 * @param attributes to be parsed
 */
- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    self.reviewID = [[attributes valueForKeyPath:@"Id"] integerValue];
    self.content = [NSString stringWithString:[attributes valueForKey:@"Content"]];
    self.answerID = [[attributes valueForKey:@"AnswerId"] integerValue];
    self.reviewState = [[attributes valueForKey:@"ReviewState"] integerValue];
    self.user = [[User alloc] initWithAttributes:[attributes valueForKey:@"User"]];
    // todo: parse datetime for creationtime (check formatting)
    
    return self;
}

/**
 * Get reviews from webservice with block for processing
 * @param array to hold reviews (unused)
 * @param error object for retrieval
 */
+ (NSURLSessionDataTask *)getReviewsWithBlock:(void (^)(NSArray *questions, NSError *error))block
{
    return [[WebserviceManager sharedClient] GET:@"getReviews/1"
                                      parameters:nil
                                         success:^(NSURLSessionDataTask __unused *task, id JSON)
    {
        NSMutableArray *mutableQuestions = [NSMutableArray arrayWithCapacity:[JSON count]];
        for (NSDictionary *attributes in JSON)
        {
            Review *review = [[Review alloc] initWithAttributes:attributes];
            review.content = @"To be or not to be?";
            [mutableQuestions addObject:review];
        }
        
        if (block)
        {
            block([NSArray arrayWithArray:mutableQuestions], nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        if (block)
        {
            block([NSArray array], error);
        }
    }];
}

@end
