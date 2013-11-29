//
//  WebserviceManager.h
//  Answers
//
//  Created by Lex Nicolaes on 21-11-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPSessionManager.h>

/**
 * Base URL for the webservice, used by the networking class
 */
static NSString * const WebserviceManagerBaseURLString = @"http://81.204.121.229/IntelliCloudService/";

/**
 * Class for managing communication with the WebService
 */
@interface WebserviceManager : AFHTTPSessionManager

/**
 * @brief Get singleton instance of WebserviceManager
 */
+ (instancetype)sharedClient;

@end
