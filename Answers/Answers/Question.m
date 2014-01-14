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
    if (!self || [attributes isKindOfClass:[NSNull class]])
    {
        return nil;
    }
    
    self.questionID = [[[[attributes valueForKeyPath:@"Id"] componentsSeparatedByString:@"/"] lastObject] integerValue];
    self.content = [attributes valueForKey:@"Content"];
    
    [User getWithURL:[attributes valueForKey:@"User"] block:^(User *user, NSError *error) {
        self.questionUser = user;
    }];
    
    self.questionState = [[attributes valueForKey:@"QuestionState"] integerValue];
    self.source = [[UserSource alloc] initWithAttributes:[attributes valueForKey:@"Source"]];
    self.creationTime = [NSDate dateFromDotnetDate:[attributes valueForKey:@"CreationTime"]];
    
    return self;
}

/**
 * Initialized a User with attributes from a (JSON) dictionary.
 * @param attributes to be parsed
 * @param attributes to be parsed
 */
+ (NSURLSessionDataTask *)getQuestionsWithBlock:(void (^)(NSArray *questions, NSError *error))block
{
    return [[WebserviceManager sharedClient] GET:@"QuestionService.svc/questions"
                                      parameters:nil
    success:^(NSURLSessionDataTask __unused *task, id JSON)
    {
        NSMutableArray *mutableQuestions = [NSMutableArray arrayWithCapacity:[JSON count]];
        for (NSDictionary *attributes in JSON)
        {
            Question *question = [[Question alloc] initWithAttributes:attributes];
            [mutableQuestions addObject:question];
        }
        
        // Create a non-mutable array from the parsed questions
        NSArray *questions = [NSArray arrayWithArray:mutableQuestions];
        
        // Persist the retrieved questions
        [[PersistentStoreManager sharedClient].persistentStoreData setQuestions:questions];
        
        if (block)
        {
            block(questions, nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        if (block)
        {
            // Return persisted (cached) questions if the request failed
            PersistentStoreData *persistentStoreData = [PersistentStoreManager sharedClient].persistentStoreData;
            block(persistentStoreData.questions, error);
        }
    }];
}

/**
 * @brief NSCoding interface method for initializing an instance of this class.
 */
- (id)initWithCoder:(NSCoder *)aDecoder
{
    // Instantiate a new object and decode the values using the decoder
    if (self == [super init])
    {
        self.questionID = [aDecoder decodeIntegerForKey:@"Id"];
        self.content = [aDecoder decodeObjectForKey:@"Content"];
        self.questionUser = [aDecoder decodeObjectForKey:@"User"];
        self.questionState = [aDecoder decodeIntegerForKey:@"QuestionState"];
        self.source = [aDecoder decodeObjectForKey:@"Source"];
        self.creationTime = [aDecoder decodeObjectForKey:@"CreationTime"];
    }
    
    // Return the instantiated object
    return self;
}

/**
 * @brief NSCoding interface method for encoding the current instance of this class.
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    // Encode the values using the coder
    [aCoder encodeInteger:self.questionID forKey:@"Id"];
    [aCoder encodeObject:self.content forKey:@"Content"];
    [aCoder encodeObject:self.questionUser forKey:@"User"];
    [aCoder encodeInteger:self.questionState forKey:@"QuestionState"];
    [aCoder encodeObject:self.source forKey:@"Source"];
    [aCoder encodeObject:self.creationTime forKey:@"CreationTime"];
}

@end
