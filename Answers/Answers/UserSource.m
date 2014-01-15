//
//  UserSource.m
//  Answers
//
//  Created by Joris Vervuurt on 14-01-14.
//  Copyright (c) 2014 IntelliCloud. All rights reserved.
//

#import "UserSource.h"

@implementation UserSource

/**
 * Initializes a UserSource with attributes from a (JSON) dictionary.
 * @param attributes to be parsed
 */
- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self || [attributes isKindOfClass:[NSNull class]])
    {
        return nil;
    }
    
    self.name = [attributes valueForKey:@"Name"];
    self.value = [attributes valueForKey:@"Value"];
    
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
        self.name = [aDecoder decodeObjectForKey:@"Name"];
        self.value = [aDecoder decodeObjectForKey:@"Value"];
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
    [aCoder encodeObject:self.name forKey:@"Name"];
    [aCoder encodeObject:self.value forKey:@"Value"];
}

@end
