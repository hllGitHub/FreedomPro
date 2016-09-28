//
//  MBProgressHUD+ZYL.h
//  Offer92
//
//  Created by Apple on 15/12/23.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <MBProgressHUD.h>

#define HUD_DELAY 0.8

@interface MBProgressHUD (ZYL)

+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (void)showMessage:(NSString *)message Delay:(CGFloat)delay;
+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

+ (void)hideHUD;
+ (void)hideHUDForView:(UIView *)view;

/**
 *  增加方法
 */

// 获取到制定模式的HUD
+ (MBProgressHUD *)hudWithModel:(MBProgressHUDMode)mode toView:(UIView *)view;

// 仅显示文字提示信息
+ (void)showMessageWithTitle:(NSString *)title Detail:(NSString *)detail Delay:(CGFloat)delay;

@end
