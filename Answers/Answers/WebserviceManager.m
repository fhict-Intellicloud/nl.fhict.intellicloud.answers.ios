//
//  WebserviceManager.m
//  Answers
//
//  Created by Lex Nicolaes on 21-11-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import "WebserviceManager.h"

/**
 * Class for managing communication with the WebService
 */
@implementation WebserviceManager

/**
 * @brief Get singleton instance of WebserviceManager
 */
+ (instancetype)sharedClient
{
    static WebserviceManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[WebserviceManager alloc] initWithBaseURL:[NSURL URLWithString:WebserviceManagerBaseURLString]];
        [_sharedClient setRequestSerializer:[AFJSONRequestSerializer serializer]];
    });
    
    NSString* accessToken = [[AuthenticationManager sharedClient] getAccessToken];
    //NSLog(@"Access Token: %@", accessToken);
    
    if(accessToken != nil)
    {
        NSString* accessToken = [AuthenticationManager sharedClient].auth.accessToken;
        
        NSDictionary *json = @{@"issuer":@"accounts.google.com", @"access_token":accessToken};
        
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:&error];
        
        NSString* backendToken = [jsonData base64EncodedStringWithOptions:0];
        //NSLog(@"Backend Token: %@", backendToken);
        
        [_sharedClient.requestSerializer setValue:backendToken forHTTPHeaderField:@"AuthorizationToken"];
    }
    else
    {
        //TODO: Push login
        NSLog(@"Cant get access token.");
    }
    
    return _sharedClient;
}

@end
