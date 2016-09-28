//
//  HLLTabbarController.m
//  MyFreedomPro
//
//  Created by Apple on 16/9/28.
//  Copyright © 2016年 亮哥. All rights reserved.
//

#import "HLLTabbarController.h"
#import "HLLHomePageViewController.h"       // 首页

@interface HLLTabbarController ()

@end

@implementation HLLTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tabbar的属性
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#0074d9"]} forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSBackgroundColorAttributeName : [UIColor colorWithHexString:@"#efeff4"]} forState:UIControlStateNormal];

    [self createSubViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Initial data and view
- (void)createSubViewControllers {
    HLLHomePageViewController *homePageVC = [[HLLHomePageViewController alloc]init];
    homePageVC.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:101];
    homePageVC.tabBarItem.title = @"首页";
    homePageVC.navigationItem.title = @"我的首页";
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:homePageVC];
    self.viewControllers = @[nav];
}

@end
