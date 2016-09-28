//
//  NSString+Date.h
//  SignSystem
//
//  Created by Apple on 16/8/5.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Date)

+ (NSString *)judgeNowTime;

/**
 *  简单判断现在时间范围
 *
 *  @return 时间段值
 */
+ (NSString *)easyJudgeNowTime;

@end
