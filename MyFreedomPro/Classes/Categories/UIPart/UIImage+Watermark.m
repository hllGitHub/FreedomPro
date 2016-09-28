//
//  UIImage+Watermark.m
//  SafeSchool
//
//  Created by Apple on 16/6/21.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "UIImage+Watermark.h"

       @implementation UIImage (Watermark)

- (UIImage *)watermarkImage:(NSString *)text{
    UIGraphicsBeginImageContext(self.size);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    //绘制水印文字
    CGRect rect = CGRectMake(0, self.size.height - 50, self.size.width, 20);
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentCenter;
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowColor = [UIColor blackColor];
    shadow.shadowBlurRadius = 1;
    shadow.shadowOffset = CGSizeMake(2, 3);
    //文字的属性
    NSDictionary *dic = @{
                          NSFontAttributeName : [UIFont systemFontOfSize:14.f],
                          NSParagraphStyleAttributeName : style,
                          NSForegroundColorAttributeName : [UIColor whiteColor],
                          NSShadowAttributeName : shadow,
                          NSExpansionAttributeName : [NSNumber numberWithFloat:0.1]
                          };
    //将文字绘制上去
    [text drawInRect:rect withAttributes:dic];
    
    //获取绘制到的图片
    UIImage *watermarkImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //结束图片的绘制
    UIGraphicsEndImageContext();
    
    return watermarkImage;
}

@end
