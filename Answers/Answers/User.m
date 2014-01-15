//
//  User.m
//  Answers
//
//  Created by Lex Nicolaes on 21-11-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import "User.h"

#import "WebserviceManager.h"

/**
 * Model representing a User retreived from the Webservice
 */
@implementation User

/**
 * Initialized a User with attributes from a (JSON) dictionary.
 * @param attributes to be parsed
 */
- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self || [attributes isKindOfClass:[NSNull class]])
    {
        return nil;
    }
    
    self.userID = [[[[attributes valueForKeyPath:@"Id"] componentsSeparatedByString:@"/"] lastObject] integerValue];
    self.avatarURL = ![[attributes valueForKey:@"Avatar"] isKindOfClass:[NSNull class]] ? [attributes valueForKey:@"Avatar"] : nil;
    self.firstname = ![[attributes valueForKey:@"FirstName"] isKindOfClass:[NSNull class]] ? [attributes valueForKey:@"FirstName"] : nil;
    self.infix = ![[attributes valueForKey:@"Infix"] isKindOfClass:[NSNull class]] ? [attributes valueForKey:@"Infix"] : nil;
    self.lastname = ![[attributes valueForKey:@"LastName"] isKindOfClass:[NSNull class]] ? [attributes valueForKey:@"LastName"] : nil;
    NSMutableArray *tempSources = [[NSMutableArray alloc] init];
    for (NSDictionary *attr in [attributes valueForKey:@"Sources"])
    {
        Source *leSource = [[Source alloc] initWithAttributes:attr];
        [tempSources addObject:leSource];
    }
    self.sources = [tempSources copy];
    self.type = [[attributes valueForKey:@"Type"] integerValue];
    self.creationTime = [NSDate dateFromDotnetDate:[attributes valueForKey:@"CreationTime"]];
    
    return self;
}

/**
 * Retrieves the authorized user.
 * @param attributes to be parsed
 * @param attributes to be parsed
 */
+ (NSURLSessionDataTask *)getAuthorizedUserWithBlock:(void (^)(User *user, NSError *error))block
{
    return [[WebserviceManager sharedClient] GET:@"UserService.svc/users"
                                      parameters:nil
                                         success:^(NSURLSessionDataTask __unused *task, id JSON)
            {
                if (block)
                    block([[User alloc] initWithAttributes:JSON], nil);
            } failure:^(NSURLSessionDataTask *task, NSError *error)
            {
                if (block)
                    block(nil, error);
            }];
}


+ (NSURLSessionDataTask *)getWithURL:(NSString *)url block:(void (^)(User *user, NSError *error))block
{
    return [[WebserviceManager sharedClient] GET:url
                                      parameters:nil
                                         success:^(NSURLSessionDataTask __unused *task, id JSON)
            {
                if (block)
                    block([[User alloc] initWithAttributes:JSON], nil);
            } failure:^(NSURLSessionDataTask *task, NSError *error)
            {
                if (block)
                    block(nil, error);
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
        self.userID = [aDecoder decodeIntegerForKey:@"Id"];
        self.avatarURL = [aDecoder decodeObjectForKey:@"Avatar"];
        self.firstname = [aDecoder decodeObjectForKey:@"FirstName"];
        self.infix = [aDecoder decodeObjectForKey:@"Infix"];
        self.lastname = [aDecoder decodeObjectForKey:@"LastName"];
        self.sources = [aDecoder decodeObjectForKey:@"Sources"];
        self.type = [aDecoder decodeIntegerForKey:@"Type"];
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
    [aCoder encodeInteger:self.userID forKey:@"Id"];
    [aCoder encodeObject:self.avatarURL forKey:@"Avatar"];
    [aCoder encodeObject:self.firstname forKey:@"FirstName"];
    [aCoder encodeObject:self.infix forKey:@"Infix"];
    [aCoder encodeObject:self.lastname forKey:@"LastName"];
    [aCoder encodeObject:self.sources forKey:@"Sources"];
    [aCoder encodeInteger:self.type forKey:@"Type"];
    [aCoder encodeObject:self.creationTime forKey:@"CreationTime"];
}

@end
