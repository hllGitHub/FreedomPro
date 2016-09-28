//
//  NSDate+ZYLDateExtension.m
//  Cartoon
//
//  Created by iThink on 10/5/15.
//  Copyright (c) 2015 yingjun. All rights reserved.
//

#import "NSDate+ZYLDateExtension.h"

@implementation NSDate (ZYLDateExtension)

/** 智能格式化时间
 * 5分钟内（刚刚）
 * X分钟前（60分钟内）
 * X小时前（5小时内）
 * hh:mm （1天内）
 * X天前  （7天内）
 * X月X日 （今年内）
 * 2014年X月 （跨年的）
 */
- (NSString *)smartDateWithReference:(NSDate *)reference {
//    NSLog(@"reference: %@, self: %@", reference, self);
    NSString *suffix = @"前";
    
    float different = [self timeIntervalSinceDate:reference];
//    NSLog(@"%lf", different);
    if (different < 0) {
        different = -different;
        suffix = @"从现在起";
    }
    
    // days = different / (24 * 60 * 60), take the floor value
    float dayDifferent = floor(different / 86400);
    
    int days   = (int)dayDifferent;
//    int weeks  = (int)ceil(dayDifferent / 7);
    int months = (int)ceil(dayDifferent / 30);
//    int years  = (int)ceil(dayDifferent / 365);
    
    // It belongs to today
    if (dayDifferent <= 0) {
        // lower than 60 seconds
//        if (different < 60) {
//            return @"just now";
//        }
        
        // lower than 120 seconds => one minute and lower than 60 seconds
//        if (different < 120) {
//            return [NSString stringWithFormat:@"1 minute %@", suffix];
//        }
        
        
        // lower than 5 minutes
        if (different < 60 *5) {
            return @"刚刚";
        }
        
        // lower than 60 minutes
        if (different < 60 * 60) {
            return [NSString stringWithFormat:@"%d分钟%@", (int)floor(different / 60), suffix];
        }
        
        // lower than 5 hours
        if (different < 3600 *5) {
            return [NSString stringWithFormat:@"%d小时%@", (int)floor(different /3600), suffix];
        }
        
        // lower than 60 * 2 minutes => one hour and lower than 60 minutes
//        if (different < 7200) {
//            return [NSString stringWithFormat:@"1 hour %@", suffix];
//        }
        
        // lower than one day
        if (different < 86400) {
//            return [NSString stringWithFormat:@"%d hours %@", (int)floor(different / 3600), suffix];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"HH:mm"];
            return [dateFormatter stringFromDate:reference];
        }
    }
    // lower than one week
    else if (days < 7) {
        return [NSString stringWithFormat:@"%d天%@", days, suffix];
    }
    // lager than one week but lower than a month
//    else if (weeks < 4) {
//        return [NSString stringWithFormat:@"%d week%@ %@", weeks, weeks == 1 ? @"" : @"s", suffix];
//    }
    // lager than a month and lower than a year
    else if (months < 12) {
//        return [NSString stringWithFormat:@"%d month%@ %@", months, months == 1 ? @"" : @"s", suffix];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"M月d日"];
        return [dateFormatter stringFromDate:reference];
    }
    // lager than a year
    else {  
//        return [NSString stringWithFormat:@"%d year%@ %@", years, years == 1 ? @"" : @"s", suffix];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy年M月"];
        return [dateFormatter stringFromDate:reference];
    }
    
    return self.description;  
}

@end
