//
//  Utility.m
//  UtilityPro
//
//  Created by Think on 15/6/11.
//  Copyright (c) 2015年 Think. All rights reserved.
//

#import "Utility.h"

#define activityViewTag         0x401
#define aViewTag                0x402

@implementation Utility

/// 校验字符串是否符合校验字符串
+ (BOOL)isValidate:(NSString *)string rule:(NSString *)rule{
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@" , rule];
    return [phoneTest evaluateWithObject:string];
}

/// UserDefaults存储数据
+ (void)writeUserDefaults:(NSString *)key Value:(id)obj {
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:obj forKey:key];
    [defaults synchronize];
}
+ (id)readUserDefaults:(NSString *)key {
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}

@end

@implementation UIViewController(ios7back)

@end

@implementation UIView (UIViewUtility)
// 显示活动指示器
- (void)showActivityView
{
    UIActivityIndicatorView *activityView = [self getActivityView];
    if (activityView == nil){
        [self createActivityView:UIActivityIndicatorViewStyleWhiteLarge];
        activityView = [self getActivityView];
    }
    
    [activityView startAnimating];
}
// 隐藏活动指示器
- (void)hideActivityView
{
    UIActivityIndicatorView *activityView = [self getActivityView];
    if (activityView != nil){
        [activityView stopAnimating];
    }
    for (UIView *view in [self subviews]) {
        if (view != nil && view.tag == aViewTag){
            [view removeFromSuperview];
            return;
        }
    }
}
// 创建活动指示器
- (void)createActivityView:(UIActivityIndicatorViewStyle)style
{
    static int size = 30;
    UIView* aView = [[UIView alloc] init];
    aView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 50/2, ([UIScreen mainScreen].bounds.size.height-113) /2 - 50/2, 50, 50);
    aView.backgroundColor = [UIColor blackColor];
    aView.layer.cornerRadius = 5;
    aView.layer.masksToBounds = YES;
    aView.tag = aViewTag;
    UIActivityIndicatorView* activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    activityView.frame = CGRectMake(10, 10, size, size);
    activityView.tag = activityViewTag;
    [aView addSubview:activityView];
    
    [self addSubview:aView];
    [self bringSubviewToFront: aView];
}
// 获取活动指示器
- (UIActivityIndicatorView *)getActivityView
{
    for (UIView *view in [self subviews]) {
        if (view.tag == aViewTag) {
            [self bringSubviewToFront:view];
            for (UIView *inview in [view subviews])
            {
                if (inview != nil && [inview isKindOfClass:[UIActivityIndicatorView class]]){
                    return (UIActivityIndicatorView*)inview;
                }
                
            }
        }
        
        
    }
    return nil;
}

@end

