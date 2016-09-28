//
//  UIImage+HLLCutAndMerge.m
//  UIImage 裁剪和合并
//
//  Created by Apple on 16/3/2.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "UIImage+HLLCutAndMerge.h"
#import "UIColor+ZYLHexColor.h"
#import "UIImage+YYWebImage.h"

@implementation UIImage (HLLCutAndMerge)

/**
 *  合并两张图片
 *
 *  @param firstImage   第一张图片
 *  @param secondImage  第二张图片
 *  @param HLLMergeType 合并方式(水平，或竖直)
 *
 *  @return 合并后的图片
 */
+ (UIImage *)addImage:(UIImage *)firstImage toImage:(UIImage*)secondImage withMergeType:(HLLMergeType)HLLMergeType
{
    CGSize size;
    CGRect newFrame;
    if (HLLMergeType == HLLMergeTypeHorizontal) {
        size = CGSizeMake(firstImage.size.width + secondImage.size.width, firstImage.size.height);
        newFrame = CGRectMake(firstImage.size.width, 0, secondImage.size.width, firstImage.size.height);
    }else{
        size = CGSizeMake(firstImage.size.width, firstImage.size.height + secondImage.size.height);
        newFrame = CGRectMake(0, firstImage.size.height, firstImage.size.width, secondImage.size.height);
    }

    UIGraphicsBeginImageContext(size);
    //Draw firstImage
    [firstImage drawInRect:CGRectMake(0, 0, firstImage.size.width, firstImage.size.height)];
    //Draw secondImage
    [secondImage drawInRect:newFrame];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

//专门用于此工程拼接图片的
+ (UIImage *)addImage:(UIImage *)firstImage toImage:(UIImage *)secondImage{
    
    CGSize size = CGSizeMake(KSCREEN_WIDTH, firstImage.size.height + secondImage.size.height);
    
    UIGraphicsBeginImageContext(size);
    //Draw firstImage
    [firstImage drawInRect:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_WIDTH / firstImage.size.width * firstImage.size.height)];
    //Draw secondImage
    [secondImage drawInRect:CGRectMake(0, KSCREEN_WIDTH / firstImage.size.width * firstImage.size.height, KSCREEN_WIDTH, KSCREEN_WIDTH / secondImage.size.width * secondImage.size.height)];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

+ (UIImage *)addImage:(UIImage *)image onImageWithColorStr:(NSString *)colorStr imageSize:(CGSize)imageSize
{
    UIColor *backgroundColor = [UIColor colorWithHexString:colorStr];
    CGSize size = CGSizeMake(imageSize.width + 20, imageSize.height);
    UIImage *backgroundImage = [UIImage yy_imageWithColor:backgroundColor size:size];
    UIGraphicsBeginImageContext(size);
    [backgroundImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    [image drawInRect:CGRectMake(10, 0, size.width - 20, size.height)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    DB_Log(@"resultImage = %@", resultImage);
    DB_Log(@"size = %@", NSStringFromCGSize(size));
    
    return resultImage;
}

/**
 *  获取视图内指定大小的图像
 *
 *  @param theView 指定视图
 *  @param frame   指定大小
 *
 *  @return 截取后的图像
 */
+ (UIImage *)getImageFromView:(UIView *)theView atFrame:(CGRect)frame
{
    //方法一
//    UIGraphicsBeginImageContext(frame.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSaveGState(context);
//    UIRectClip(frame);
//    
//    [theView drawViewHierarchyInRect:theView.frame afterScreenUpdates:NO];
//    UIImage *theImage = [UIGraphicsGetImageFromCurrentImageContext() imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    UIGraphicsEndImageContext();
//    return theImage;
    //方法二
    CGSize imageSize = CGSizeZero;
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        imageSize = [UIScreen mainScreen].bounds.size;
    } else {
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    }
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft) {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        } else if (orientation == UIInterfaceOrientationLandscapeRight) {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        } else {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //这是可以保存到本地相册，根据需要进行选择，默认不保存
    //        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    //   获取scale
    CGFloat scale = [UIScreen mainScreen].scale;
    UIImage *newImage = [UIImage getPartOfImage:image rect:CGRectMake(frame.origin.x *scale, frame.origin.y * scale, frame.size.width * scale, frame.size.height *scale)];
    
    DB_Log(@"newImage = %@", newImage);
    
//    UIImageWriteToSavedPhotosAlbum(newImage, nil, nil, nil);
    
    return newImage;
}

+ (UIImage *)snapshotView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, [[UIScreen mainScreen] scale]); //0
    [view drawViewHierarchyInRect:view.frame afterScreenUpdates:YES];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //默认不保存到系统相册
    //    UIImageWriteToSavedPhotosAlbum(snapshot, nil, nil, nil);
    return snapshot;
}

+ (UIImage *)getPartOfImage:(UIImage *)img rect:(CGRect)partRect{
    CGImageRef imageRef = img.CGImage;
    CGImageRef imagePartRef = CGImageCreateWithImageInRect(imageRef, partRect);
    UIImage *retImg = [UIImage imageWithCGImage:imagePartRef];
    CGImageRelease(imagePartRef);
    return retImg;
}

+ (UIImage *)snapshot {
    CGSize imageSize = CGSizeZero;
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        imageSize = [UIScreen mainScreen].bounds.size;
    } else {
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    }
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft) {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        } else if (orientation == UIInterfaceOrientationLandscapeRight) {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        } else {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //这是可以保存到本地相册，根据需要进行选择，默认不保存
//        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    UIImage *newImage = [UIImage getPartOfImage:image rect:CGRectMake(0, 0, image.size.width * 2, image.size.height )];
    
    DB_Log(@"newImage = %@", newImage);
    
    UIImageWriteToSavedPhotosAlbum(newImage, nil, nil, nil);
    
    return newImage;
}



@end
