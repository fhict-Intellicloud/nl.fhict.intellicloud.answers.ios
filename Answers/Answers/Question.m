//
//  Question.m
//  Answers
//
//  Created by Lex Nicolaes on 21-11-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import "Question.h"

/**
 * Model representing a question retrieved from the webservice
 */
@implementation Question

/**
 * @brief Initializes an object of class Question using an attributes dictionary.
 * @param Attributes to be used
 */
- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    // Initialize the base object
    if (self != [super init] || [attributes isKindOfClass:[NSNull class]]) return nil;
    
    // Set all properties using the attributes dictionary
    self.answerURL = ![[attributes objectForKey:@"Answer"] isKindOfClass:[NSNull class]] ? [attributes objectForKey:@"Answer"] : nil;
    self.content = ![[attributes objectForKey:@"Content"] isKindOfClass:[NSNull class]] ? [attributes objectForKey:@"Content"] : nil;
    self.creationTime = ![[attributes objectForKey:@"CreationTime"] isKindOfClass:[NSNull class]] ? [NSDate dateFromDotnetDate:[attributes objectForKey:@"CreationTime"]] : nil;
    self.questionID = ![[attributes objectForKey:@"Id"] isKindOfClass:[NSNull class]] ? [[[[attributes objectForKey:@"Id"] componentsSeparatedByString:@"/"] lastObject] integerValue] : 0;
    self.isPrivate = ![[attributes objectForKey:@"IsPrivate"] isKindOfClass:[NSNull class]] ? [[attributes objectForKey:@"IsPrivate"] boolValue] : NO;
    self.language = ![[attributes objectForKey:@"Language"] isKindOfClass:[NSNull class]] ? [attributes objectForKey:@"Language"] : nil;
    self.lastChangedTime = ![[attributes objectForKey:@"LastChangedTime"] isKindOfClass:[NSNull class]] ? [NSDate dateFromDotnetDate:[attributes objectForKey:@"LastChangedTime"]] : nil;
    self.state = ![[attributes objectForKey:@"QuestionState"] isKindOfClass:[NSNull class]] ? [[attributes objectForKey:@"QuestionState"] integerValue] : 0;
    self.source = ![[attributes objectForKey:@"Source"] isKindOfClass:[NSNull class]] ? [[UserSource alloc] initWithAttributes:[attributes objectForKey:@"Source"]] : nil;
    self.sourcePostID = ![[attributes objectForKey:@"SourcePostId"] isKindOfClass:[NSNull class]] ? [attributes objectForKey:@"SourcePostId"] : nil;
    self.title = ![[attributes objectForKey:@"Title"] isKindOfClass:[NSNull class]] ? [attributes objectForKey:@"Title"] : nil;
    
    // Return the initialized object
    return self;
}

/**
 * @brief Retrieves all questions.
 * @param Block to invoke when finished
 */
+ (NSURLSessionDataTask *)getQuestionsWithCompletionBlock:(void (^)(NSArray *questions, NSError *error))completionBlock
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
        
        // Persist the retrieved questions
        [[PersistentStoreManager sharedClient].persistentStoreData setQuestions:mutableQuestions];
        
        if (completionBlock)
            completionBlock(mutableQuestions, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        if (completionBlock)
        {
            // Return persisted (cached) questions if the request failed
            PersistentStoreData *persistentStoreData = [PersistentStoreManager sharedClient].persistentStoreData;
            completionBlock(persistentStoreData.questions, error);
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
        self.answerURL = [aDecoder decodeObjectForKey:@"answerURL"];
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.creationTime = [aDecoder decodeObjectForKey:@"creationTime"];
        self.questionID = [aDecoder decodeIntegerForKey:@"questionId"];
        self.isPrivate = [aDecoder decodeBoolForKey:@"isPrivate"];
        self.language = [aDecoder decodeObjectForKey:@"language"];
        self.lastChangedTime = [aDecoder decodeObjectForKey:@"lastChangedTime"];
        self.state = [aDecoder decodeIntegerForKey:@"state"];
        self.source = [aDecoder decodeObjectForKey:@"source"];
        self.sourcePostID = [aDecoder decodeObjectForKey:@"sourcePostID"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
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
    [aCoder encodeObject:self.answerURL forKey:@"answerURL"];
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.creationTime forKey:@"creationTime"];
    [aCoder encodeInteger:self.questionID forKey:@"questionId"];
    [aCoder encodeBool:self.isPrivate forKey:@"isPrivate"];
    [aCoder encodeObject:self.language forKey:@"language"];
    [aCoder encodeObject:self.lastChangedTime forKey:@"lastChangedTime"];
    [aCoder encodeInteger:self.state forKey:@"state"];
    [aCoder encodeObject:self.source forKey:@"source"];
    [aCoder encodeObject:self.sourcePostID forKey:@"sourcePostID"];
    [aCoder encodeObject:self.title forKey:@"title"];
}

@end
