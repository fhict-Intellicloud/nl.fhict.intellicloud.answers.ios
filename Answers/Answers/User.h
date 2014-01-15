//
//  User.h
//  Answers
//
//  Created by Lex Nicolaes on 21-11-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Source.h"
#import "NSDate+Dotnet.h"

/**
 * An enumeration indicating the type of User.
 */
typedef NS_ENUM(NSInteger, UserType)
{
    UserTypeCustomer,            /**< Indicates the User is an customer. */
    UserTypeEmployee,            /**< Indicates the User is an employee. */
};

/**
 * Model representing a User retreived from the Webservice
 */
@interface User : NSObject <NSCoding>

/**
* @property id
* @brief Gets the unique identifier of the user.
*/
@property (nonatomic, assign) NSInteger userID;

/**
 * @property avatar url
 * @brief Gets the URL of the avatar of the user.
 */
@property (nonatomic, strong) NSString * avatarURL;

/**
 * @property firdtname
 * @brief Gets the first name of the user.
 */
@property (nonatomic, strong) NSString * firstname;

/**
 * @property content
 * @brief Gets the infix of the users name, e.g. 'van'.
 */
@property (nonatomic, strong) NSString * infix;

/**
 * @property content
 * @brief Gets the last name of the user.
 */
@property (nonatomic, strong) NSString * lastname;

/**
 * @property usertype
 * @brief Gets the type of the user. It indicates if a user is an customer or an employee.
 */
@property (nonatomic, assign) UserType type;

/**
 * @property sources
 * @brief Gets or sets a collection of sources the user supports.
 */
@property (nonatomic, strong) NSArray * sources;

/**
 * @property creationtime
 * @brief Gets the creation date and time of the answer.
 */
@property (nonatomic, strong) NSDate * creationTime;

/**
 * @property keywords
 * @brief Gets the keywords that are linked to the user.
 */
@property (nonatomic, strong) NSArray * keywords;

/**
 * Initialized a User with attributes from a (JSON) dictionary.
 * @param attributes to be parsed
 */
- (instancetype)initWithAttributes:(NSDictionary *)attributes;

/**
 * Retrieves the authorized user.
 * @param attributes to be parsed
 * @param attributes to be parsed
 */
+ (NSURLSessionDataTask *)getAuthorizedUserWithBlock:(void (^)(User *user, NSError *error))block;

/**
 * Retrieves a user from a backend url.
 * @param attributes to be parsed
 * @param attributes to be parsed
 */
+ (NSURLSessionDataTask *)getWithURL:(NSString *)url block:(void (^)(User *user, NSError *error))block;

@end
