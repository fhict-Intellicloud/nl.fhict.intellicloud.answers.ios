//
//  Review.h
//  Answers
//
//  Created by Erik Reusken on 27/11/13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WebserviceManager.h"

#import "User.h"

/**
 * An enumeration indicating the states of a <see cref="Review"/>.
 */
typedef NS_ENUM(NSInteger, ReviewState)
{
    Open,               /**< Indicates the review is made but not jet implemented in the answer. */
    Closed,             /**< Indicates the review is implemented in the answer. */
};

/**
 * Model representing a Review retreived from the Webservice
 */
@interface Review : NSObject

/**
 * @property id
 * @brief Gets the unique identifier of the review.
 */
@property (nonatomic, assign) NSInteger reviewID;

/**
 * @property content
 * @brief Gets the content of the review.
 */
@property (nonatomic, strong) NSString * content;

/**
 * @property answerid
 * @brief Gets the identifier of answer related to this review.
 */
@property (nonatomic, assign) NSInteger answerID;

/**
 * @property reviewstate
 * @brief Gets or sets the state of the review. This state indicates if the review is processed.
 */
@property (nonatomic, assign) ReviewState reviewState;

/**
 * @property user
 * @brief Gets or sets the user that made the review.
 */
@property (nonatomic, strong) User * user;

/**
 * @property creationtime
 * @brief Gets the creation date and time of the review.
 */
@property (nonatomic, strong) NSDate * creationtime;

/**
 * Initialized a Review with attributes from a (JSON) dictionary.
 * @param attributes to be parsed
 */
- (instancetype)initWithAttributes:(NSDictionary *)attributes;

/**
 * Get reviews from webservice with block for processing
 * @param array to hold reviews (unused)
 * @param error object for retrieval
 */
+ (NSURLSessionDataTask *)getReviewsWithBlock:(void (^)(NSArray *reviews, NSError *error))block;

@end
