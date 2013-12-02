//
//  UIColor+IntelliCloudStyle.m
//  Answers
//
//  Created by Lex Nicolaes on 21-11-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#import "UIColor+IntelliCloudStyle.h"

/*
 * @brief UIColor Category for IntelliCloud styleguide based color
 */
@implementation UIColor (IntelliCloudStyle)

/**
 * @brief Get color for navigationbar background color
 */
+ (UIColor *)navigationBarTintColor
{
    return [UIColor colorWithRed:30/255.0f green:136/255.0f blue:138/255.0f alpha:1.0];
}

/**
 * @brief Get color for navigationbar UI element color
 */
+ (UIColor *)navigationTintColor
{
    return [UIColor whiteColor];
}

/**
 * @brief Get color for navigationbar label color
 */
+(UIColor *)navigationLabelTextColor
{
    return [UIColor whiteColor];
}

/**
 * @brief Get color for tabbar background color
 */
+ (UIColor *)tabBarTintColor
{
    // Same color as navigationbar background
    return [UIColor navigationBarTintColor];
}

/**
 * @brief Get color for table accessory color
 */
+ (UIColor *)tableTintColor
{
    return [UIColor colorWithRed:92/255.0f green:184/255.0f blue:136/255.0f alpha:1.0];
}

/**
 * @brief Get color for button label color
 */
+(UIColor *)buttonLabelTextColor
{
    // Same color as navigationbar background
    return [UIColor navigationBarTintColor];
}

@end
