//
//  NSString+Date.m
//  SignSystem
//
//  Created by Apple on 16/8/5.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "NSString+Date.h"

@implementation NSString (Date)

+ (NSString *)judgeNowTime {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"HH:mm";
    NSString *nowDateStr = [formatter stringFromDate:[NSDate date]];
    DB_Log(@"nowDateStr = %@", nowDateStr);
    
    NSDate *nowDate = [self timeToDate:nowDateStr];
    NSDate *beforeDawnDate = [self timeToDate:@"00:00"];
    NSDate *morningDate = [self timeToDate:@"06:00"];
    NSDate *forenoonDate = [self timeToDate:@"09:00"];
    NSDate *noonDate = [self timeToDate:@"12:00"];
    NSDate *afteroonDate = [self timeToDate:@"13:00"];
    NSDate *nightfallDate = [self timeToDate:@"18:00"];
    
    if ([[nowDate earlierDate:morningDate] isEqual:nowDate] && [[nowDate earlierDate:beforeDawnDate] isEqual:beforeDawnDate]) {
        return @"凌晨好";
    }
    
    if ([[nowDate earlierDate:morningDate] isEqual:morningDate] && [[nowDate earlierDate:forenoonDate] isEqual:nowDate]) {
        return @"早上好";
    }
    
    if ([[nowDate earlierDate:forenoonDate] isEqual:forenoonDate] && [[nowDate earlierDate:noonDate] isEqual:nowDate]) {
        return @"上午好";
    }
    
    if ([[nowDate earlierDate:noonDate] isEqual:noonDate] && [[nowDate earlierDate:afteroonDate] isEqual:nowDate]) {
        return @"中午好";
    }
    
    if ([[nowDate earlierDate:afteroonDate] isEqual:afteroonDate] && [[nowDate earlierDate:nightfallDate] isEqual:nowDate]) {
        return @"下午好";
    }
    
    if ([[nowDate earlierDate:nightfallDate] isEqual:nightfallDate]) {
        return @"晚上好";
    }
    
    return @"早上好";
}

+ (NSDate *)timeToDate:(NSString *)timeStr {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"HH:mm";
    NSDate *newDate = [formatter dateFromString:timeStr];
    newDate = [NSDate dateWithTimeInterval:(8 * 3600) sinceDate:[formatter dateFromString:timeStr]];
    return newDate;
}

+ (NSString *)easyJudgeNowTime {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"HH:mm";
    NSString *now = [[formatter stringFromDate:[NSDate date]] substringToIndex:2];
    NSInteger nowHour = [now integerValue];
    if (nowHour >= 0 && nowHour < 6) {
        return @"凌晨好";
    }
    
    if (nowHour >= 6 && nowHour < 9) {
        return @"早上好";
    }
    
    if (nowHour >= 9 && nowHour < 12) {
        return @"上午好";
    }
    
    if (nowHour >= 12 && nowHour < 13) {
        return @"中午好";
    }
    
    if (nowHour >= 13 && nowHour < 18) {
        return @"下午好";
    }
    
    if (nowHour >= 18 && nowHour < 24) {
        return @"晚上好";
    }
    
    return @"早上好";
}

@end
