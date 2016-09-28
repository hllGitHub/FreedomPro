//
//  Factory.m
//  UtilityPro
//
//  Created by Think on 15/6/23.
//  Copyright (c) 2015年 Think. All rights reserved.
//

#import "Factory.h"
#import <UIImageView+WebCache.h>
#import "UIImageView+CornerRadius.h"

#define GET_FONT(fontSize)       [UIFont systemFontOfSize:fontSize]

@implementation Factory

#pragma mark - 创建按钮

/// 获取背景纯色图片
+(UIImage *)getbuttonImage:(CGRect )rect color:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(rect.size,NO,0);
    UIBezierPath* p =[UIBezierPath bezierPathWithRect:CGRectMake(0,0,rect.size.width,rect.size.height)];
    [color setFill];
    [p fill];
    UIImage*im=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return im;
}

/// 空白button
+ (UIButton *)buttonWithRect:(CGRect)rect Tag:(NSInteger)tag SuperView:(UIView *)superView Target:(id)target Action:(SEL)action events:(UIControlEvents)event
{
    if (![superView viewWithTag:tag]) {
        UIButton *button = [[UIButton alloc] initWithFrame:rect];
        [button addTarget:target action:action forControlEvents:event];
        [button setTag:tag];
        [button setExclusiveTouch:YES];
        [superView addSubview:button];
    }else
    {
        UIButton * button = (UIButton *)[superView viewWithTag:tag];
        [button setFrame:rect];
        [button setExclusiveTouch:YES];
        [button addTarget:target action:action forControlEvents:event];
        [button setTag:tag];
    }
    return (UIButton *)[superView viewWithTag:tag];
}

/// 默认button点击事件是 UIControlEventTouchDown
+ (UIButton *)buttonWithRect:(CGRect)rect Tag:(NSInteger)tag SuperView:(UIView *)superView Target:(id)target Action:(SEL)action
{
    return  [self buttonWithRect:rect Tag:tag SuperView:superView Target:target Action:action events:UIControlEventTouchUpInside];
}

/// 带文字button
+(UIButton *)buttonWithRect:(CGRect)rect Text:(NSString *)text Font:(UIFont *)font NormalTextColor:(UIColor *)normalColor HighLightTextColor:(UIColor *)highLightColor  Tag:(NSInteger)tag SuperView:(UIView *)superView Target:(id)target Action:(SEL)action
{
    UIButton * button = [self buttonWithRect:rect Tag:tag SuperView:superView Target:target Action:action];
    
    [button.titleLabel setFont:font];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitle:text forState:UIControlStateHighlighted];
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    [button setTitleColor:highLightColor forState:UIControlStateHighlighted];
    return button;
}

/// 带图片button
+(UIButton *)buttonWithRect:(CGRect)rect NormalBgImageStr:(NSString *)normalimage HighLightBgImageStr:(NSString *)hightLightImage  Tag:(NSInteger)tag SuperView:(UIView *)superView Target:(id)target Action:(SEL)action
{
    UIButton * button = [self buttonWithRect:rect Tag:tag SuperView:superView Target:target Action:action];
    [button setImage:GET_IMAGE(normalimage) forState:UIControlStateNormal];
    [button setImage:GET_IMAGE(hightLightImage) forState:UIControlStateHighlighted];
    return button;
}

/// 带文字button 带背景颜色的
+(UIButton *)buttonWithRect:(CGRect)rect Text:(NSString *)text Font:(UIFont *)font NormalTextColor:(UIColor *)normalColor HighLightTextColor:(UIColor *)highLightColor  NormalBgColor:(UIColor *)normalBgColor HighLightBgColor:(UIColor *)highLightBgColor Tag:(NSInteger)tag SuperView:(UIView *)superView Target:(id)target Action:(SEL)action
{
    UIButton * button =[self buttonWithRect:rect Text:text Font:font NormalTextColor:normalColor HighLightTextColor:highLightColor Tag:tag SuperView:superView Target:target Action:action];
    [button setBackgroundImage:[self getbuttonImage:CGRectMake(0, 0, rect.size.width, rect.size.height) color:normalBgColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[self getbuttonImage:CGRectMake(0, 0, rect.size.width, rect.size.height) color:highLightBgColor] forState:UIControlStateHighlighted];
    return button;
}

/// 带文字button 带背景颜色的 带圆角
+(UIButton *)buttonWithRect:(CGRect)rect Text:(NSString *)text Font:(UIFont *)font NormalTextColor:(UIColor *)normalColor HighLightTextColor:(UIColor *)highLightColor  NormalBgColor:(UIColor *)normalBgColor HighLightBgColor:(UIColor *)highLightBgColor Tag:(NSInteger)tag SuperView:(UIView *)superView Target:(id)target Action:(SEL)action Radius:(CGFloat)radius
{
    UIButton *button = [self buttonWithRect:rect Text:text Font:font NormalTextColor:normalColor HighLightTextColor:highLightColor NormalBgColor:normalBgColor HighLightBgColor:highLightBgColor Tag:tag SuperView:superView Target:target Action:action];
    button.layer.cornerRadius = radius;
    button.layer.masksToBounds = YES;
    return button;
}

/// 带文字button 带背景颜色的 带边界颜色都button
+(UIButton *)buttonWithRect:(CGRect)rect Text:(NSString *)text Font:(UIFont *)font NormalTextColor:(UIColor *)normalColor HighLightTextColor:(UIColor *)highLightColor NormalBgColor:(UIColor *)normalBgColor HighLightBgColor:(UIColor *)highLightBgColor BorderColor:(UIColor *)borderColor Tag:(NSInteger)tag SuperView:(UIView *)superView Target:(id)target Action:(SEL)action
{
    UIButton * button = [self buttonWithRect:rect Text:text Font:font NormalTextColor:normalColor HighLightTextColor:highLightColor NormalBgColor:normalBgColor HighLightBgColor:highLightBgColor Tag:tag SuperView:superView Target:target Action:action];
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = borderColor.CGColor;
    return button;
}

/// 文字图片button  默认文字居左 UILineBreakModeTailTruncation  //这个不是很好用 换成自定义的以后
+ (UIButton *)buttonWithRect:(CGRect)buttonRect ImageEdgeInsets:(UIEdgeInsets)imageEdgeInsets TitleEdgeInsets:(UIEdgeInsets)titleEdgeInsets NormalImageName:(NSString *)normal SelectedImageName:(NSString *)selected Tag:(NSInteger)tag SuperView:(UIView *)superView Text:(NSString *)text Font:(UIFont *)font TitleNormalColor:(UIColor *)titleNormalColor TitleHighLightColor:(UIColor *)titleHighLightColor Target:(id)target Action:(SEL)action
{
    UIButton * button=  [self buttonWithRect:buttonRect Text:text Font:font NormalTextColor:titleNormalColor  HighLightTextColor:titleHighLightColor Tag:tag SuperView:superView Target:target Action:action];
    [button setImageEdgeInsets:imageEdgeInsets];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [button setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
    [button setImage:GET_IMAGE(normal) forState:UIControlStateNormal];
    [button setImage:GET_IMAGE(selected) forState:UIControlStateHighlighted];
    button.titleLabel.textAlignment = NSTextAlignmentLeft;
    button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [button setTitleEdgeInsets:titleEdgeInsets];
    return (UIButton *)[superView viewWithTag:tag];
}
/// 带文字button 带背景颜色的 带边界颜色的button Radius
+ (UIButton *)buttonWithRect:(CGRect)rect Text:(NSString *)text Font:(UIFont *)font NormalTextColor:(UIColor *)normalColor HighLightTextColor:(UIColor *)highLightColor NormalBgColor:(UIColor *)normalBgColor HighLightBgColor:(UIColor *)highLightBgColor BorderColor:(UIColor *)borderColor Tag:(NSInteger)tag SuperView:(UIView *)superView Radius:(float)radius Target:(id)target Action:(SEL)action
{
    UIButton * button = [self buttonWithRect:rect Text:text Font:font NormalTextColor:normalColor HighLightTextColor:highLightColor NormalBgColor:normalBgColor HighLightBgColor:highLightBgColor BorderColor:borderColor Tag:tag SuperView:superView Target:target Action:action];
    if (radius < 2) {
        radius = 2;
    }
    button.layer.cornerRadius = radius;
    button.layer.masksToBounds = YES;
    return button;
}

#pragma mark - 创建UIView

/// 基本UIView 背景色
+ (UIView *)viewRect:(CGRect)rect SuperView:(UIView *)superView Tag:(NSInteger)tag BackColor:(UIColor *)color
{
    if (![superView viewWithTag:tag]) {
        UIView *view =[[UIView alloc] initWithFrame:rect];
        [view setBackgroundColor:color];
        [view setTag:tag];
        [superView addSubview:view];
    } else {
        UIView *view = (UIView *)[superView viewWithTag:tag];
        [view setFrame:rect];
    }
    return [superView viewWithTag:tag];
}

/// 创建View: rect & superview & tag & backcolor & radiu
+ (UIView *)viewRect:(CGRect)rect SuperView:(UIView *)superView Tag:(NSInteger)tag BackColor:(UIColor *)color Radius:(float)radius {
    UIView *view = [self viewRect:rect SuperView:superView Tag:tag BackColor:color];
    view.layer.cornerRadius = radius;
    view.layer.masksToBounds = YES;
    return view;
}

/// 基本UIView 分割线
+ (UIView *)lineViewRect:(CGRect)rect SuperView:(UIView *)superView Tag:(NSInteger)tag LineColor:(UIColor *)color
{
    if (![superView viewWithTag:tag]) {
        UIView *   lineView =[[UIView alloc] initWithFrame:rect];
        [lineView setBackgroundColor:color];
        [lineView setTag:tag];
        [superView addSubview:lineView];
    }else{
        UIView * lineView = (UIView *)[superView viewWithTag:tag];
        [lineView setFrame:rect];
    }
    return [superView viewWithTag:tag];
}

/// 默认线颜色是 #d2d2d2
+ (UIView *)lineViewRect:(CGRect)rect SuperView:(UIView *)superView Tag:(NSInteger)tag
{
    return [self lineViewRect:rect SuperView:superView Tag:tag LineColor:[self colorWithHexString:DEFAULT_LINE_COLOR]];
}

/// 默认线是颜色 #d2d2d2 线宽是0.5  左右空缺相同
+ (UIView *)lineViewOriginPoint:(CGPoint)point SuperView:(UIView *)superView Tag:(NSInteger)tag
{
    return [self lineViewRect:CGRectMake(point.x, point.y, KSCREEN_WIDTH-point.x, DEFAULT_LINE_WIDTH) SuperView:superView Tag:tag];
}

/// 默认线是颜色 #d2d2d2 线宽是0.5  宽度为屏幕宽度
+ (UIView *)lineView:(CGFloat)line SuperView:(UIView *)superView Tag:(NSInteger)tag
{
    return [self lineViewOriginPoint:CGPointMake(0, line) SuperView:superView Tag:tag];
}
/// 画虚线
+(UIView *)shapeLineWithFrame:(CGRect)frame withSuperView:(UIView *)superView withSpace:(float)space withWidth:(float)width withColor:(UIColor *)color
{
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:frame];
    UIGraphicsBeginImageContext(imageView1.frame.size);   //开始画线
    [imageView1.image drawInRect:CGRectMake(0, 0, imageView1.frame.size.width, imageView1.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
    
    CGFloat lengths[] = {width,space};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, color.CGColor);
    
    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(line, 0.0, 1.0);    //开始画线
    CGContextAddLineToPoint(line, imageView1.frame.size.width, 1.0);
    CGContextStrokePath(line);
    
    imageView1.image = UIGraphicsGetImageFromCurrentImageContext();
    [superView addSubview:imageView1];
    return imageView1;
}
#pragma mark - UIImageView method
/// 添加本地图片 无默认图
+ (UIImageView *)imageViewLoc:(NSString *)imageName Tag:(NSInteger)tag Rect:(CGRect)rect SuperView:(UIView *)superView
{
    if (![superView viewWithTag:tag]) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:rect];
        [imageView setImage:[UIImage imageNamed:imageName]];
        [imageView setTag:tag];
        [superView addSubview:imageView];
    }else {
        UIImageView * imageView = (UIImageView *)[superView viewWithTag:tag];
        [imageView setFrame:rect];
        [imageView setImage:[UIImage imageNamed:imageName]];
    }
    return (UIImageView *)[superView viewWithTag:tag];
}

/// 添加本地图片 圆角
+ (UIImageView *)imageViewLoc:(NSString *)imageName Tag:(NSInteger)tag Rect:(CGRect)rect SuperView:(UIView *)superView Radius:(CGFloat)radius {
    UIImageView *imageView = [self imageViewLoc:imageName Tag:tag Rect:rect SuperView:superView];
    imageView.aliCornerRadius = radius;
    imageView.layer.masksToBounds = NO;
#warning 这里有问题，必须设置layer才有效果，还没找到原因
    imageView.layer.cornerRadius = radius;
    return imageView;
}



/// 添加本地图片 圆形 单击事件
+ (UIImageView *)imageViewRoundingRectLoc:(NSString *)imageName Tag:(NSInteger)tag Rect:(CGRect)rect SuperView:(UIView *)superView Target:(id)target Action:(SEL)action{
    UIImageView *imageView = [self imageViewLoc:imageName Tag:tag Rect:rect SuperView:superView];
    imageView.aliCornerRadius = rect.size.width / 2;
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [imageView addGestureRecognizer:singleTap]; // 添加单击手势
    return imageView;
}

/// 添加本地图片 圆角 单击事件
+ (UIImageView *)imageViewLoc:(NSString *)imageName Tag:(NSInteger)tag Rect:(CGRect)rect SuperView:(UIView *)superView Radius:(CGFloat)radius Target:(id)target Action:(SEL)action {
    UIImageView *imageView = [self imageViewLoc:imageName Tag:tag Rect:rect SuperView:superView Radius:radius];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [imageView addGestureRecognizer:singleTap]; // 添加单击手势
    return imageView;
}

/// 添加异步加载图片 无默认图 无点击事件
+ (UIImageView *)imageViewWeb:(NSString *)imgURLStr Placeholder:(UIImage *)image Tag:(NSInteger)tag Rect:(CGRect)rect SuperView:(UIView *)superView
{
    if (![superView viewWithTag:tag]) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:rect];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imgURLStr] placeholderImage:image];
        [imageView setTag:tag];
        [superView addSubview:imageView];
    }else {
        UIImageView * imageView = (UIImageView *)[superView viewWithTag:tag];
        [imageView setFrame:rect];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imgURLStr] placeholderImage:image];
    }
    return (UIImageView *)[superView viewWithTag:tag];
}

/// 添加异步加载图片  圆形 无点击
+(UIImageView *)imageViewRoundingRectWeb:(NSString *)imgURLStr Placeholder:(UIImage *)image Tag:(NSInteger)tag Rect:(CGRect)rect SuperView:(UIView *)superView{
    UIImageView * imageView = [self imageViewWeb:imgURLStr Placeholder:image Tag:tag Rect:rect SuperView:superView];
    
    imageView.aliCornerRadius = rect.size.width / 2;
    return imageView;
}

/// 添加异步加载图片  圆角 无点击
+(UIImageView *)imageViewWeb:(NSString *)imgURLStr Placeholder:(UIImage *)image Tag:(NSInteger)tag Rect:(CGRect)rect SuperView:(UIView *)superView Radius:(CGFloat)radius
{
    UIImageView * imageView = [self imageViewWeb:imgURLStr Placeholder:image Tag:tag Rect:rect SuperView:superView];
    imageView.aliCornerRadius = radius;
    return imageView;
}

/// 添加异步加载图片 有点击事件(默认鼠标抬起触发)
+ (UIImageView *)imageViewWeb:(NSString *)imgURLStr Placeholder:(UIImage *)image Tag:(NSInteger)tag Rect:(CGRect)rect SuperView:(UIView *)superView Target:(id)target Event:(SEL)event
{
    UIImageView *imageView = [self imageViewWeb:imgURLStr Placeholder:image Tag:tag Rect:rect SuperView:superView];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:target action:event];
    [imageView addGestureRecognizer:singleTap]; // 添加单击手势
    return imageView;
}

#pragma mark - UIImage 代码绘制纯色图片
+ (UIImage *)imageWithSize:(CGSize)size Color:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(size,0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *pressedColorImg =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pressedColorImg;
}

/// UIImage: color
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - 截取指定大小的图片
+ (UIImage*)imageByScalingAndCroppingForSize:(UIImage*)anImage toSize:(CGSize)targetSize
{
    UIImage* sourceImage = anImage;
    UIImage* newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor) {
            scaleFactor = widthFactor; // scale to fit height
        } else {
            scaleFactor = heightFactor; // scale to fit width
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if (newImage == nil) {
        NSLog(@"could not scale image");
    }
    
    // pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma makr - UILabel method
/// 基本label
+ (UILabel *)labelWithFrame:(CGRect)frame SuperView:(UIView *)superView Tag:(NSInteger)tag Text:(NSString *)text
{
    if (![superView viewWithTag:tag]) {
        UILabel * label = [[UILabel alloc] initWithFrame:frame];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setText:text];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTag:tag];
        [superView addSubview:label];
    }else{
        UILabel * label = (UILabel *)[superView viewWithTag:tag];
        [label setFrame:frame];
        [label setText:text];
    }
    return (UILabel *)[superView viewWithTag:tag];
}

/// Basic label & font & color text ailgnment
+ (UILabel *)labelWithFrame:(CGRect)frame SuperView:(UIView *)superView Tag:(NSInteger)tag Text:(NSString *)text Font:(UIFont*)font TextColor:(UIColor *)color TextAlignment:(NSTextAlignment)alignment
{
    UILabel * label =[self labelWithFrame:frame SuperView:superView Tag:tag Text:text];
    [label setFont:font];
    [label setTextColor:color];
    [label setTextAlignment:alignment];
    label.numberOfLines=0;
    return label;
}

/// 设置换行模式 font textcolor textalignment
+ (UILabel *)labelWithFrame:(CGRect)frame SuperView:(UIView *)superView Tag:(NSInteger)tag Text:(NSString *)text Font:(UIFont*)font TextColor:(UIColor *)color TextAlignment:(NSTextAlignment)alignment LineBreakMode:(NSLineBreakMode)lineBreakMode
{
    UILabel *label = [self labelWithFrame:frame SuperView:superView Tag:tag Text:text Font:font TextColor:color TextAlignment:alignment];
    [label setLineBreakMode:lineBreakMode];
    return label;
}

/// fontSize textcolor textalignment
+ (UILabel *)labelWithFrame:(CGRect)frame SuperView:(UIView *)superView Tag:(NSInteger)tag Text:(NSString *)text FontSize:(float)fontSize TextColor:(UIColor *)color TextAlignment:(NSTextAlignment)alignment
{
    return [self labelWithFrame:frame SuperView:superView Tag:tag Text:text Font:GET_FONT(fontSize) TextColor:color TextAlignment:alignment];
}

/// 设置换行模式 fontSize textcolor textalignment
+ (UILabel *)labelWithFrame:(CGRect)frame SuperView:(UIView *)superView Tag:(NSInteger)tag Text:(NSString *)text FontSize:(float)fontSize TextColor:(UIColor *)color TextAlignment:(NSTextAlignment)alignment BreakMode:(NSLineBreakMode)lineBreakMode
{
    return [self labelWithFrame:frame SuperView:superView Tag:tag Text:text Font:GET_FONT(fontSize) TextColor:color TextAlignment:alignment LineBreakMode:lineBreakMode];
}

/**
 *  Get the height of target label
 */
+ (CGFloat)getHeightOfLabel:(NSString *)text FontSize:(CGFloat)fontSize ContentWidth:(CGFloat)aMaxWidth;
{
    if (!text || text.length == 0) {
        return 0;
    }
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.text = text;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.font = GET_FONT(fontSize);
    CGSize size = [label sizeThatFits:CGSizeMake(aMaxWidth, 20000)];
    return size.height;
}


#pragma makr - UITextField method

/// frame & superView & tag & placeholder
+ (UITextField *)textFieldWithFrame:(CGRect)frame SuperView:(UIView *)superView Tag:(NSInteger)tag Placeholder:(NSString *)placeholder
{
    if (![superView viewWithTag:tag]) {
        UITextField * textField = [[UITextField alloc] initWithFrame:frame];
        textField.tag = tag;
        textField.placeholder = placeholder;
        [superView addSubview:textField];
    } else {
        UITextField * textField = (UITextField *)[superView viewWithTag:tag];
        textField.frame = frame;
        textField.placeholder = placeholder;
    }
    return (UITextField *)[superView viewWithTag:tag];
}

/// frame & superView & tag & placeholder & color
+ (UITextField *)textFieldWithFrame:(CGRect)frame SuperView:(UIView *)superView Tag:(NSInteger)tag Placeholder:(NSString *)placeholder Font:(UIFont *)font TextColor:(UIColor *)textColor
{
    UITextField *textField = [self textFieldWithFrame:frame SuperView:superView Tag:tag Placeholder:placeholder];
    textField.font = font;
    textField.textColor = textColor;
    return textField;
}

/// frame & superView & tag & placeholder & color & textalignment
+ (UITextField *)textFieldWithFrame:(CGRect)frame SuperView:(UIView *)superView Tag:(NSInteger)tag Placeholder:(NSString *)placeholder Font:(UIFont *)font TextColor:(UIColor *)textColor TextAlignment:(NSTextAlignment)alignment
{
    UITextField * textField = [self textFieldWithFrame:frame SuperView:superView Tag:tag Placeholder:placeholder Font:font TextColor:textColor];
    textField.textAlignment = alignment;
    return textField;
}

/// frame & superView & tag & placeholder & color & delegate
+ (UITextField *)textFieldWithFrame:(CGRect)frame SuperView:(UIView *)superView Tag:(NSInteger)tag Placeholder:(NSString *)placeholder Font:(UIFont *)font TextColor:(UIColor *)textColor Delegate:(id)delegate SecureText:(BOOL)isSecure
{
    UITextField *textField = [self textFieldWithFrame:frame SuperView:superView Tag:tag Placeholder:placeholder Font:font TextColor:textColor];
    textField.delegate = delegate;
    textField.secureTextEntry = isSecure;
    return textField;
}

/// Icon & frame & superView & tag & placeholder & color
+ (UITextField *)textFieldWithFrame:(CGRect)frame SuperView:(UIView *)superView Tag:(NSInteger)tag Icon:(NSString *)iconName Placeholder:(NSString *)placeholder Font:(UIFont *)font TextColor:(UIColor *)textColor {
    UIView *backView = [self viewRect:frame SuperView:superView Tag:99999 BackColor:[UIColor whiteColor] Radius:3.0];
    [self imageViewLoc:iconName Tag:99998 Rect:CGRectMake(20, 5, 30, 30) SuperView:backView];
    UITextField *textField = [self textFieldWithFrame:CGRectMake(40, frame.origin.y, frame.size.width -40, frame.size.height) SuperView:superView Tag:tag Placeholder:placeholder Font:font TextColor:textColor];
    return textField;
}


/// frame & superView & tag & placeholder & color & delegate & boderStyle
+ (UITextField *)textFieldWithFrame:(CGRect)frame SuperView:(UIView *)superView Tag:(NSInteger)tag Placeholder:(NSString *)placeholder Font:(UIFont *)font TextColor:(UIColor *)textColor Delegate:(id)delegate SecureText:(BOOL)isSecure BoderStyle:(UITextBorderStyle)boderStyle
{
    UITextField *textField = [self textFieldWithFrame:frame SuperView:superView Tag:tag Placeholder:placeholder Font:font TextColor:textColor];
    textField.delegate = delegate;
    textField.secureTextEntry = isSecure;
    textField.borderStyle = boderStyle;
    return textField;
}

#pragma mark - 创建颜色

/// 创建16进制颜色(不带透明度)
+ (UIColor *) colorWithHexString: (NSString *)colorStr
{
    NSString *cString = [[colorStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    //if ([cString length] < 6) return DEFAULT_VOID_COLOR;
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    //if ([cString length] != 6) return DEFAULT_VOID_COLOR;
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    //SL_Log(@"%f:::%f:::%f",((float) r / 255.0f),((float) g / 255.0f),((float) b / 255.0f));
    
    return K_COLOR_RGB((float) r, (float) g, (float) b, 1);
}

///比较2个时间的大小
+(int)compareDate:(NSDate *)date1 withDate:(NSDate *)date2
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    //第一个时间
    NSString * firstStr = [dateFormatter stringFromDate:date1];
    NSDate *firstDate = [dateFormatter dateFromString:firstStr];
    NSTimeInterval _fitstDate = [firstDate timeIntervalSince1970]*1;
    
    //第二个时间
    NSString * secondStr = [dateFormatter stringFromDate:date2];
    NSDate *secondDate = [dateFormatter dateFromString:secondStr];
    NSTimeInterval _secondDate = [secondDate timeIntervalSince1970]*1;
//    DB_Log(@"date1=%f-------date2=%f",_fitstDate,_secondDate);
     //第一个时间大
    if (_fitstDate - _secondDate > 0) {
        return 1;
    }else if (_fitstDate - _secondDate == 0) {
        return 0;
    }else {
        return -1;
    }
}
@end
