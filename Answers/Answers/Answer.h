//
//  Answer.h
//  Answers
//
//  Created by Lex Nicolaes on 04-12-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "LanguageDefinition.h"
#import "NSDate+Dotnet.h"
#import "WebserviceManager.h"

/**
 * An enumeration indicating the state of the an Answer.
 */
typedef NS_ENUM(NSInteger, AnswerState)
{
    AnswerStateReady,            /**< Indicating that the Answer is ready to be used by the system. */
    AnswerStateUnderReview,      /**< Indicating the Answer is under review. During which it cannot be send to users. */
};

/**
 * Model for representing an Answer to a Question retreived from the Webservice
 */
@interface Answer : NSObject <NSCoding>

/**
 * @property answerID
 * @brief Gets or sets the unique identifier of the answer.
 */
@property (nonatomic, assign) NSInteger answerID;

/**
 * @property content
 * @brief Gets or sets the content of the answer. The content contains the answer given to the question.
 */
@property (nonatomic, strong) NSString * content;

/**
 * @property languageDefinition
 * @brief Gets or sets the language the answer is written in.
 */
@property (nonatomic, strong) LanguageDefinition * languageDefinition;

/**
 * @property answerUser
 * @brief Gets or sets the user that gave the answer.
 */
@property (nonatomic, strong) User * user;

/**
 * @property answerState
 * @brief Gets or sets the state of the answer.
 */
@property (nonatomic, assign) AnswerState answerState;

/**
 * @property creationTime
 * @brief Gets the creation date and time of the answer.
 */
@property (nonatomic, strong) NSDate *creationTime;

/**
 * Initialized a Answer with attributes from a (JSON) dictionary.
 * @param [NSDicationary] attributes to be parsed
 */
- (instancetype)initWithAttributes:(NSDictionary *)attributes;

/**
 * Sends a answer with the WebserviceManager SharedInstance.
 * @param body: body for the service
 */
+ (NSURLSessionDataTask *)postAnswerWithParameters:(NSDictionary*) parameters withBlock: (void (^)(NSError *error))block;

@end
