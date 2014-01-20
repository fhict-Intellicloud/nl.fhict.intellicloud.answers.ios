//
//  Answer.m
//  Answers
//
//  Created by Lex Nicolaes on 04-12-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import "Answer.h"

/**
 * Model representing an answer retrieved from the webservice
 */
@implementation Answer

/**
 * @brief Initializes an object of class Answer using an attributes dictionary.
 * @param Attributes to be used
 */
- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    // Initialize the base object
    if (self != [super init] || [attributes isKindOfClass:[NSNull class]]) return nil;
    
    // Set all properties using the attributes dictionary
    self.state = ![[attributes objectForKey:@"AnswerState"] isKindOfClass:[NSNull class]] ? [[attributes objectForKey:@"AnswerState"] integerValue] : 0;
    self.content = ![[attributes objectForKey:@"Content"] isKindOfClass:[NSNull class]] ? [attributes objectForKey:@"Content"] : nil;
    self.creationTime = ![[attributes objectForKey:@"CreationTime"] isKindOfClass:[NSNull class]] ? [NSDate dateFromDotnetDate:[attributes objectForKey:@"CreationTime"]] : nil;
    self.answerID = ![[attributes objectForKey:@"Id"] isKindOfClass:[NSNull class]] ? [[[[attributes objectForKey:@"Id"] componentsSeparatedByString:@"/"] lastObject] integerValue] : 0;
    self.isPrivate = ![[attributes objectForKey:@"IsPrivate"] isKindOfClass:[NSNull class]] ? [[attributes objectForKey:@"IsPrivate"] boolValue] : NO;
    self.language = ![[attributes objectForKey:@"Language"] isKindOfClass:[NSNull class]] ? [attributes objectForKey:@"Language"] : nil;
    self.lastChangedTime = ![[attributes objectForKey:@"LastChangedTime"] isKindOfClass:[NSNull class]] ? [NSDate dateFromDotnetDate:[attributes objectForKey:@"LastChangedTime"]] : nil;
        
    // Return the initialized object
    return self;
}

/**
 * @brief Retrieves an answer from a URL.
 * @param Resource URL
 * @param Block to invoke when finished
 */
+ (NSURLSessionDataTask *)getWithURL:(NSString *)url
                  andCompletionBlock:(void (^)(Answer *answer, NSError *error))completionBlock
{
    return [[WebserviceManager sharedClient] GET:url
                                      parameters:nil
                                         success:^(NSURLSessionDataTask __unused *task, id JSON)
            {
                if (completionBlock)
                    completionBlock([[Answer alloc] initWithAttributes:JSON], nil);
            } failure:^(NSURLSessionDataTask *task, NSError *error)
            {
                if (completionBlock)
                    completionBlock(nil, error);
            }];
}

/**
 * Creates an answer using an attributes dictionary.
 * @param Attributes to be used
 * @param Block to invoke when finished
 */
+ (NSURLSessionDataTask *)createAnswerWithAttributes:(NSDictionary*)attributes andCompletionBlock:(void (^)(NSError *error))completionBlock
{
    return [[WebserviceManager sharedClient] POST:@"AnswerService.svc/answers"
                                       parameters:attributes
    success:^(NSURLSessionDataTask *task, id responseObject)
    {
        if (completionBlock)
            completionBlock(nil);
    }
    failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        if (completionBlock)
            completionBlock(error);
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
        self.state = [aDecoder decodeIntegerForKey:@"state"];
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.creationTime = [aDecoder decodeObjectForKey:@"creationTime"];
        self.answerID = [aDecoder decodeIntegerForKey:@"answerId"];
        self.isPrivate = [aDecoder decodeBoolForKey:@"isPrivate"];
        self.language = [aDecoder decodeObjectForKey:@"language"];
        self.lastChangedTime = [aDecoder decodeObjectForKey:@"lastChangedTime"];
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
    [aCoder encodeInteger:self.state forKey:@"state"];
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.creationTime forKey:@"creationTime"];
    [aCoder encodeInteger:self.answerID forKey:@"answerId"];
    [aCoder encodeBool:self.isPrivate forKey:@"isPrivate"];
    [aCoder encodeObject:self.language forKey:@"language"];
    [aCoder encodeObject:self.lastChangedTime forKey:@"lastChangedTime"];
}

@end