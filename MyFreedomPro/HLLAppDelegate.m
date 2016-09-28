//
//  HLLAppDelegate.m
//  MyFreedomPro
//
//  Created by Apple on 16/9/28.
//  Copyright © 2016年 亮哥. All rights reserved.
//

#import "HLLAppDelegate.h"
#import "HLLTabbarController.h"
#import "HLLHomePageViewController.h"

@implementation HLLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [HLLTabbarController new];
//
    
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[HLLHomePageViewController new]];
//    self.window.rootViewController = nav;
//    
//    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
