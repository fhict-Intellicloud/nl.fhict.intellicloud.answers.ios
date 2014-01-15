//
//  Answer.m
//  Answers
//
//  Created by Lex Nicolaes on 04-12-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import "Answer.h"

@implementation Answer

/**
 * Initialized a Answer with attributes from a (JSON) dictionary.
 * @param attributes to be parsed
 */
- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self || [attributes isKindOfClass:[NSNull class]])
    {
        return nil;
    }
    
    self.answerID = [[attributes valueForKeyPath:@"Id"] integerValue];
    self.content = [attributes valueForKey:@"Content"];
    self.languageDefinition = [[LanguageDefinition alloc] initWithAttributes:[attributes valueForKey:@"LanguageDefinition"]];
    self.user = [[User alloc] initWithAttributes:[attributes valueForKey:@"User"]];
    self.answerState = [[attributes valueForKey:@"AnswerState"] integerValue];
    self.creationTime = [NSDate dateFromDotnetDate:[attributes valueForKey:@"CreationTime"]];
    
    return self;
}

/**
 * Sends a answer with the WebserviceManager SharedInstance.
 * tested with local service waiting for real implementation
 * @param parameters: parameters for the service
 */
+ (NSURLSessionDataTask *)postAnswerWithParameters:(NSDictionary*) parameters withBlock: (void (^)(NSError *error))block
{
    return [[WebserviceManager sharedClient] POST:@"AnswerService.svc/answers"
                                       parameters:parameters
    success:^(NSURLSessionDataTask *task, id responseObject)
    {
      if (block)
          block(nil);
    }
    failure:^(NSURLSessionDataTask *task, NSError *error)
    {
      if (block)
          block(error);
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
        self.answerID = [aDecoder decodeIntegerForKey:@"Id"];
        self.content = [aDecoder decodeObjectForKey:@"Content"];
        self.languageDefinition = [aDecoder decodeObjectForKey:@"LanguageDefinition"];
        self.user = [aDecoder decodeObjectForKey:@"User"];
        self.answerState = [aDecoder decodeIntegerForKey:@"AnswerState"];
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
    [aCoder encodeInteger:self.answerID forKey:@"Id"];
    [aCoder encodeObject:self.content forKey:@"Content"];
    [aCoder encodeObject:self.languageDefinition forKey:@"LanguageDefinition"];
    [aCoder encodeObject:self.user forKey:@"User"];
    [aCoder encodeInteger:self.answerState forKey:@"AnswerState"];
    [aCoder encodeObject:self.creationTime forKey:@"CreationTime"];
}

@end