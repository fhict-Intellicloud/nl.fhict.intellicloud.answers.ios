//
//  UserSource.m
//  Answers
//
//  Created by Joris Vervuurt on 14-01-14.
//  Copyright (c) 2014 IntelliCloud. All rights reserved.
//

#import "UserSource.h"

/**
 * Model representing a source for a user retrieved from the webservice
 */
@implementation UserSource

/**
 * @brief Initializes an object of class UserSource using an attributes dictionary.
 * @param Attributes to be used
 */
- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    // Initialize the base object
    if (self != [super init] || [attributes isKindOfClass:[NSNull class]]) return nil;
    
    // Set all properties using the attributes dictionary
    self.name = ![[attributes objectForKey:@"Name"] isKindOfClass:[NSNull class]] ? [attributes objectForKey:@"Name"] : nil;
    self.value = ![[attributes objectForKey:@"Value"] isKindOfClass:[NSNull class]] ? [attributes objectForKey:@"Value"] : nil;
    
    // Return the initialized object
    return self;
}

/**
 * @brief NSCoding interface method for initializing an instance of this class.
 */
- (id)initWithCoder:(NSCoder *)aDecoder
{
    // Instantiate a new object and decode the values using the decoder
    if (self == [super init])
    {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.value = [aDecoder decodeObjectForKey:@"value"];
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
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.value forKey:@"value"];
}

@end
