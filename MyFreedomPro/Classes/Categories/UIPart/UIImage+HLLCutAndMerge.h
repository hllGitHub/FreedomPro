//
//  UIImage+HLLCutAndMerge.h
//  UIImage 裁剪和合并
//
//  Created by Apple on 16/3/2.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, HLLMergeType)
{
    HLLMergeTypeHorizontal,   //水平合并
    HLLMergeTypeVertical      //垂直拼接
};

@interface UIImage (HLLCutAndMerge)
/**
 *  合并两张图片
 *
 *  @param firstImage   第一张图片
 *  @param secondImage  第二张图片
 *  @param HLLMergeType 合并方式(水平，或竖直)
 *
 *  @return 合并后的图片
 */
+ (UIImage *)addImage:(UIImage *)firstImage toImage:(UIImage*)secondImage withMergeType:(HLLMergeType)HLLMergeType;
/**
 *  设置单色背景图片
 *
 *  @param image    需要设置的图片
 *  @param colorStr 背景色
 *  @param imageSize     图片大小
 *
 *  @return 处理好的图片
 */
+ (UIImage *)addImage:(UIImage *)image onImageWithColorStr:(NSString *)colorStr imageSize:(CGSize)imageSize;
/**
 *  获取视图内指定大小的图像
 *
 *  @param theView 指定视图
 *  @param frame   指定大小
 *
 *  @return 截取后的图像
 */
+ (UIImage *)getImageFromView:(UIView *)theView atFrame:(CGRect)frame;
/**
 *  截取指定view的图像
 *
 *  @param view 指定view
 *
 *  @return 截取图像
 */
+ (UIImage *)snapshotView:(UIView *)view;
/**
 *  全屏截取
 *
 *  @return 全屏图像
 */
+ (UIImage *)snapshot;
/**
 *  上下拼接//专门用于此工程拼接图片的
 *
 *  @param firstImage  第一张图片
 *  @param secondImage 第二张图片
 *
 *  @return 拼接后的图片
 */
+ (UIImage *)addImage:(UIImage *)firstImage toImage:(UIImage *)secondImage;

@end
