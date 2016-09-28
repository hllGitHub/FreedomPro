//
//  NSString+Emoji.h
//  Calendar
//
//  Created by Apple on 15/11/11.
//  Copyright © 2015年 yingjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZYLEmoji)

/**
 *  判断字符串中是否有Emoji字符串
 */
+ (BOOL)stringContainsEmoji:(NSString *)string;

/**
 *  剔除字符串中的Emoji表情
 */
+ (NSString *)stringDropEmoji:(NSString *)string;

@end
