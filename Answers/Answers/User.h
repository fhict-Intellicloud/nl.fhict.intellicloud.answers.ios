//
//  User.h
//  Answers
//
//  Created by Lex Nicolaes on 21-11-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSDate+Dotnet.h"
#import "UserSource.h"
#import "WebserviceManager.h"

/**
 * Definition of all available user types.
 */
typedef NS_ENUM(NSInteger, UserType)
{
    UserTypeCustomer,
    UserTypeEmployee
};

/**
 * Model representing a user retrieved from the webservice
 */
@interface User : NSObject <NSCoding>

/**
 * @property Avatar URL.
 * @brief URL to the user's avatar/profile image.
 */
@property (nonatomic, strong) NSString *avatarURL;

/**
 * @property Creation time.
 * @brief Creation date and time of the user.
 */
@property (nonatomic, strong) NSDate *creationTime;

/**
 * @property First name.
 * @brief First name of the user.
 */
@property (nonatomic, strong) NSString *firstName;

/**
* @property User ID.
* @brief Unique identifier of the user.
*/
@property (nonatomic, assign) NSInteger userID;

/**
 * @property Infix.
 * @brief Infix of the user's name.
 */
@property (nonatomic, strong) NSString *infix;

/**
 * @property Last changed time.
 * @brief Date and time of the last change.
 */
@property (nonatomic, strong) NSDate *lastChangedTime;

/**
 * @property Last name.
 * @brief Last name of the user.
 */
@property (nonatomic, strong) NSString *lastName;

/**
 * @property User type.
 * @brief Indicates the type of user.
 */
@property (nonatomic, assign) UserType type;

/**
 * @property Sources.
 * @brief Array of sources for the user.
 */
@property (nonatomic, strong) NSArray *sources;

/**
 * @brief Initializes an object of class User using an attributes dictionary.
 * @param Attributes to be used
 */
- (instancetype)initWithAttributes:(NSDictionary *)attributes;

/**
 * @brief Retrieves the authorized user.
 * @param Block to invoke when finished
 */
+ (NSURLSessionDataTask *)getAuthorizedUserWithCompletionBlock:(void (^)(User *user, NSError *error))completionBlock;

/**
 * @brief Retrieves a user from a URL.
 * @param Resource URL
 * @param Block to invoke when finished
 */
+ (NSURLSessionDataTask *)getWithURL:(NSString *)url andCompletionBlock:(void (^)(User *user, NSError *error))completionBlock;

@end
