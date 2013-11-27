//
//  Question.m
//  Answers
//
//  Created by Lex Nicolaes on 21-11-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import "Question.h"

/**
 * Model for representing a Question retreived from the Webservice
 */
@implementation Question

/**
 * Initialized a User with attributes from a (JSON) dictionary.
 * @param attributes to be parsed
 */
- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    self.questionID = [[attributes valueForKeyPath:@"Id"] integerValue];
    self.content = [attributes valueForKey:@"Content"];
    self.questionUser = [[User alloc] initWithAttributes:[attributes valueForKey:@"User"]];
    self.answerUser = [[User alloc] initWithAttributes:[attributes valueForKey:@"Answerer"]];
    self.questionState = [[attributes valueForKey:@"QuestionState"] integerValue];
    self.sourceType = [[SourceDefinition alloc] initWithAttributes:[attributes valueForKey:@"SourceType"]];
    
    return self;
}

/**
 * Get questions from webservice with block for processing
 * @param array to hold questions (unused)
 * @param error object for retrieval
 */
+ (NSURLSessionDataTask *)getQuestionsWithBlock:(void (^)(NSArray *questions, NSError *error))block
{
    return [[WebserviceManager sharedClient] GET:@"getQuestions/1"
                                      parameters:nil
    success:^(NSURLSessionDataTask __unused *task, id JSON)
    {
        NSMutableArray *mutableQuestions = [NSMutableArray arrayWithCapacity:[JSON count]];
        for (NSDictionary *attributes in JSON)
        {
            Question *question = [[Question alloc] initWithAttributes:attributes];
            question.content = @"To be or not to be?";
            [mutableQuestions addObject:question];
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
