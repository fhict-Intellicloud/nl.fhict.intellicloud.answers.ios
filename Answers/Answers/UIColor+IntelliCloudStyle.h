//
//  UIColor+IntelliCloudStyle.h
//  Answers
//
//  Created by Lex Nicolaes on 21-11-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 * @brief UIColor Category for IntelliCloud styleguide based color
 */
@interface UIColor (IntelliCloudStyle)

/**
 * @brief Get color for navigationbar background color
 */
+ (UIColor *)navigationBarTintColor;

/**
 * @brief Get color for navigationbar UI element color
 */
+ (UIColor *)navigationTintColor;

/**
 * @brief Get color for navigationbar label color
 */
+ (UIColor *)navigationLabelTextColor;

/**
 * @brief Get color for tabbar background color
 */
+ (UIColor *)tabBarTintColor;

/**
 * @brief Get color for table accessory color
 */
+ (UIColor *)tableTintColor;

/**
 * @brief Get color for button label color
 */
+ (UIColor *)buttonLabelTextColor;

@end
