//
//  UserSource.h
//  Answers
//
//  Created by Joris Vervuurt on 14-01-14.
//  Copyright (c) 2014 IntelliCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Model representing a source for a user retrieved from the webservice
 */
@interface UserSource : NSObject <NSCoding>

/**
 * @property Name.
 * @brief Name of the source.
 */
@property (nonatomic, strong) NSString *name;

/**
 * @property Value.
 * @brief Value of the source.
 */
@property (nonatomic, strong) NSString *value;

/**
 * @brief Initializes an object of class UserSource using an attributes dictionary.
 * @param Attributes to be used
 */
- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
