//
//  UserSource.h
//  Answers
//
//  Created by Joris Vervuurt on 14-01-14.
//  Copyright (c) 2014 IntelliCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Model representing the UserSource instance of a User retrieved from the Webservice
 */
@interface UserSource : NSObject <NSCoding>

/**
 * @property name
 * @brief Gets or sets the name for the for the given user source.
 */
@property (nonatomic, strong) NSString *name;

/**
 * @property value
 * @brief Gets or sets the value for the for the given user source.
 */
@property (nonatomic, strong) NSString *value;

/**
 * Initializes a UserSource with attributes from a (JSON) dictionary.
 * @param attributes to be parsed
 */
- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
