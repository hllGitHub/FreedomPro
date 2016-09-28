//
//  Utility.h
//  UtilityPro
//
//  Created by Think on 15/6/11.
//  Copyright (c) 2015年 Think. All rights reserved.
//

// 正则表达式校验字符串
#define ISLANDLINE  @"^[1][3-8]+\\d{9}"                                 // 校验座机号码
//#define ISPHONESTR  @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$"     // 校验电话号码
#define ISPHONESTR  @"^[1][3-8]+\\d{9}"     // 校验电话号码
#define ISIDCARDNO  @"^([0-9]{15}$)|([0-9]{17}([0-9]|X)$)"              // 校验身份证号码
#define ISZIPCODE   @"^[1-9][0-9]{5}$"                                  // 校验邮政编码
#define ISBANKCARD  @"^[0-9]{16}|[0-9]{19}$"                            // 校验银行卡 ^[0-9]*$

#define IS_NEWSTU           @"is_newstu"                                // 是否是新生

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utility : NSObject

/// 校验字符串是否符合校验字符串
+ (BOOL)isValidate:(NSString *)string rule:(NSString *)rule;

/// UserDefaults存储数据
+ (void)writeUserDefaults:(NSString *)key Value:(id)obj;
+ (id)readUserDefaults:(NSString *)key;

@end


@interface UIViewController(ios7back)

@end

@interface UIView (UIViewUtility)

- (void)showActivityView;                   // 显示活动指示器
- (void)hideActivityView;                   // 隐藏活动指示器
- (void)createActivityView:(UIActivityIndicatorViewStyle)style; // 创建活动指示器
- (UIActivityIndicatorView*)getActivityView;// 获取活动指示器

@end