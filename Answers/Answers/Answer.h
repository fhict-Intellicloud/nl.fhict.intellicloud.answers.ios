//
//  Answer.h
//  Answers
//
//  Created by Lex Nicolaes on 04-12-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSDate+Dotnet.h"
#import "WebserviceManager.h"

/**
 * Definition of all available answer states.
 */
typedef NS_ENUM(NSInteger, AnswerState)
{
    AnswerStateReady,
    AnswerStateUnderReview
};

/**
 * Model representing an answer retrieved from the webservice
 */
@interface Answer : NSObject <NSCoding>

/**
 * @property State.
 * @brief State of the answer.
 */
@property (nonatomic, assign) AnswerState state;

/**
 * @property Content.
 * @brief The answer.
 */

@property (nonatomic, strong) NSString *content;
/**
 * @property Creation time.
 * @brief Creation date and time of the answer.
 */

@property (nonatomic, strong) NSDate *creationTime;
/**
 * @property Answer ID.
 * @brief Unique identifier of the answer.
 */

@property (nonatomic, assign) NSInteger answerID;
/**
 * @property Is Private.
 * @brief Boolean value indicating if the answer is private.
 */

@property (nonatomic, assign) BOOL isPrivate;
/**
 * @property Language.
 * @brief The language in which the answer is written.
 */

@property (nonatomic, strong) NSString *language;
/**
 * @property Last changed time.
 * @brief Date and time of the last change.
 */

@property (nonatomic, strong) NSDate *lastChangedTime;

/**
 * @brief Initializes an object of class Answer using an attributes dictionary.
 * @param Attributes to be used
 */
- (instancetype)initWithAttributes:(NSDictionary *)attributes;

/**
 * @brief Retrieves an answer from a URL.
 * @param Resource URL
 * @param Block to invoke when finished
 */
+ (NSURLSessionDataTask *)getWithURL:(NSString *)url
                  andCompletionBlock:(void (^)(Answer *answer, NSError *error))completionBlock;

/**
 * Creates an answer using an attributes dictionary.
 * @param Attributes to be used
 * @param Block to invoke when finished
 */
+ (NSURLSessionDataTask *)createAnswerWithAttributes:(NSDictionary*)attributes
                                  andCompletionBlock:(void (^)(NSError *error))completionBlock;

@end
