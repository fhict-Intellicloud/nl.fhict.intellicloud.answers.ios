//
//  Question.h
//  Answers
//
//  Created by Lex Nicolaes on 21-11-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UserSource.h"
#import "NSDate+Dotnet.h"
#import "Answer.h"
#import "WebserviceManager.h"

/**
 * Definition of all available question states.
 */
typedef NS_ENUM(NSInteger, QuestionState)
{
    QuestionStateOpen,
    QuestionStateUpForAnswer,
    QuestionStateUpForFeedback,
    QuestionStateClosed
};

/**
 * Model representing a question retrieved from the webservice
 */
@interface Question : NSObject <NSCoding>

/**
 * @property Answer URL.
 * @brief Resource URL for the answer to this question.
 */
@property (nonatomic, strong) NSString *answerURL;

/**
 * @property Content.
 * @brief The question.
 */
@property (nonatomic, strong) NSString *content;

/**
 * @property Creation time.
 * @brief Creation date and time of the question.
 */
@property (nonatomic, strong) NSDate *creationTime;

/**
 * @property Question ID.
 * @brief Unique identifier of the question.
 */
@property (nonatomic, assign) NSInteger questionID;

/**
 * @property Is Private.
 * @brief Boolean value indicating if the question is private.
 */
@property (nonatomic, assign) BOOL isPrivate;

/**
 * @property Language.
 * @brief The language in which the question is written.
 */
@property (nonatomic, strong) NSString *language;

/**
 * @property Last changed time.
 * @brief Date and time of the last change.
 */
@property (nonatomic, strong) NSDate *lastChangedTime;

/**
 * @property State.
 * @brief State of the question.
 */
@property (nonatomic, assign) QuestionState state;

/**
 * @property Source.
 * @brief The source of the question.
 */
@property (nonatomic, strong) UserSource *source;

/**
 * @property Source post ID.
 * @brief The post ID that belongs to the source of the question.
 */
@property (nonatomic, strong) NSString *sourcePostID;

/**
 * @property Title.
 * @brief The title of the question.
 */
@property (nonatomic, strong) NSString *title;

/**
 * @brief Initializes an object of class Question using an attributes dictionary.
 * @param Attributes to be used
 */
- (instancetype)initWithAttributes:(NSDictionary *)attributes;

/**
 * @brief Retrieves all questions.
 * @param Block to invoke when finished
 */
+ (NSURLSessionDataTask *)getQuestionsWithCompletionBlock:(void (^)(NSArray *questions, NSError *error))completionBlock;

@end
