//
//  NSDate+ZYLDateExtension.h
//  Cartoon
//
//  Created by 张玉龙 on 10/5/15.
//  Copyright (c) 2015 yingjun. All rights reserved.
/**
 *  类的扩展 格式化时间
 */

#import <Foundation/Foundation.h>

@interface NSDate (ZYLDateExtension)

/** 智能格式化时间
 * 5分钟内（刚刚）
 * X分钟前（60分钟内）
 * X小时前（5小时内）
 * hh:mm （1天内）
 * X天前  （7天内）
 * 6月X日 （今年内）
 * 2014年X月 （跨年的）
 */
- (NSString *)smartDateWithReference:(NSDate *)reference;

@end
