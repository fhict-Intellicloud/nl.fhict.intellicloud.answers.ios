//
//  User.m
//  Answers
//
//  Created by Lex Nicolaes on 21-11-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import "User.h"

/**
 * Model representing a user retrieved from the webservice
 */
@implementation User

/**
 * @brief Initializes an object of class User using an attributes dictionary.
 * @param Attributes to be used
 */
- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    // Initialize the base object
    if (self != [super init] || [attributes isKindOfClass:[NSNull class]]) return nil;
    
    // Set all properties using the attributes dictionary
    self.avatarURL = ![[attributes objectForKey:@"Avatar"] isKindOfClass:[NSNull class]] ? [attributes objectForKey:@"Avatar"] : nil;
    self.creationTime = ![[attributes objectForKey:@"CreationTime"] isKindOfClass:[NSNull class]] ? [NSDate dateFromDotnetDate:[attributes objectForKey:@"CreationTime"]] : nil;
    self.firstName = ![[attributes objectForKey:@"FirstName"] isKindOfClass:[NSNull class]] ? [attributes objectForKey:@"FirstName"] : nil;
    self.userID = ![[attributes objectForKey:@"Id"] isKindOfClass:[NSNull class]] ? [[[[attributes objectForKey:@"Id"] componentsSeparatedByString:@"/"] lastObject] integerValue] : 0;
    self.infix = ![[attributes objectForKey:@"Infix"] isKindOfClass:[NSNull class]] ? [attributes objectForKey:@"Infix"] : nil;
    self.lastChangedTime = ![[attributes objectForKey:@"LastChangedTime"] isKindOfClass:[NSNull class]] ? [NSDate dateFromDotnetDate:[attributes objectForKey:@"LastChangedTime"]] : nil;
    self.lastName = ![[attributes objectForKey:@"LastName"] isKindOfClass:[NSNull class]] ? [attributes objectForKey:@"LastName"] : nil;
    self.type = ![[attributes objectForKey:@"UserType"] isKindOfClass:[NSNull class]] ? [[attributes objectForKey:@"UserType"] integerValue] : 0;
    
    // Set all sources using the attributes dictionary
    NSMutableArray *mutableSources = [[NSMutableArray alloc] init];
    if (![[attributes objectForKey:@"Sources"] isKindOfClass:[NSNull class]])
    {
        for (NSDictionary *sourceAttributes in [attributes objectForKey:@"Sources"])
        {
            UserSource *source = [[UserSource alloc] initWithAttributes:sourceAttributes];
            [mutableSources addObject:source];
        }
    }
    self.sources = mutableSources;
    
    // Return the initialized object
    return self;
}

/**
 * @brief Retrieves the authorized user.
 * @param Block to invoke when finished
 */
+ (NSURLSessionDataTask *)getAuthorizedUserWithCompletionBlock:(void (^)(User *user, NSError *error))completionBlock
{
    return [User getWithURL:@"UserService.svc/users" andCompletionBlock:completionBlock];
}

/**
 * @brief Retrieves a user from a URL.
 * @param Resource URL
 * @param Block to invoke when finished
 */
+ (NSURLSessionDataTask *)getWithURL:(NSString *)url
                  andCompletionBlock:(void (^)(User *user, NSError *error))completionBlock
{
    return [[WebserviceManager sharedClient] GET:url
                                      parameters:nil
            success:^(NSURLSessionDataTask __unused *task, id JSON)
            {
                if (completionBlock)
                    completionBlock([[User alloc] initWithAttributes:JSON], nil);
            } failure:^(NSURLSessionDataTask *task, NSError *error)
            {
                if (completionBlock)
                    completionBlock(nil, error);
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
        self.avatarURL = [aDecoder decodeObjectForKey:@"avatarURL"];
        self.creationTime = [aDecoder decodeObjectForKey:@"creationTime"];
        self.firstName = [aDecoder decodeObjectForKey:@"firstName"];
        self.userID = [aDecoder decodeIntegerForKey:@"userID"];
        self.infix = [aDecoder decodeObjectForKey:@"infix"];
        self.lastChangedTime = [aDecoder decodeObjectForKey:@"lastChangedTime"];
        self.lastName = [aDecoder decodeObjectForKey:@"lastName"];
        self.type = [aDecoder decodeIntegerForKey:@"type"];
        self.sources = [aDecoder decodeObjectForKey:@"sources"];
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
    [aCoder encodeObject:self.avatarURL forKey:@"avatarURL"];
    [aCoder encodeObject:self.creationTime forKey:@"creationTime"];
    [aCoder encodeObject:self.firstName forKey:@"firstName"];
    [aCoder encodeInteger:self.userID forKey:@"userID"];
    [aCoder encodeObject:self.infix forKey:@"infix"];
    [aCoder encodeObject:self.lastChangedTime forKey:@"lastChangedTime"];
    [aCoder encodeObject:self.lastName forKey:@"lastName"];
    [aCoder encodeInteger:self.type forKey:@"type"];
    [aCoder encodeObject:self.sources forKey:@"sources"];
}

@end
