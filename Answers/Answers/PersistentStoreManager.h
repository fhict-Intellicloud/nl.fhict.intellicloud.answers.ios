//
//  PersistentStoreManager.h
//  Answers
//
//  Created by Joris Vervuurt on 09-01-14.
//  Copyright (c) 2014 IntelliCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PersistentStoreData.h"

/**
 * Path of the file containing the persistent store data
 */
static NSString * const PersistentStoreDataFilePath = @"~/Documents/PersistentStore";

/**
 * Class for managing the persistent store
 */
@interface PersistentStoreManager : NSObject

/**
 * Property that contains an instance of wrapper class PersistentStoreData containing the data in the persistent store
 */
@property (nonatomic, strong) PersistentStoreData *persistentStoreData;

/**
 * @brief Get singleton instance of PersistentStore
 */
+ (instancetype)sharedClient;

/**
 * @brief Method for saving all data locally
 * @return Boolean value indicating if the data was saved successfully
 */
- (BOOL)saveData;

/**
 * @brief Method for clearing all data locally
 * @return Boolean value indicating if the data was cleared successfully
 */
- (BOOL)clearData;

@end