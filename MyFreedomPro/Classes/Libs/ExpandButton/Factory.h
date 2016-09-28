//
//  Factory.h
//  UtilityPro
//
//  Created by Think on 15/6/23.
//  Copyright (c) 2015年 Think. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Utility.h"
#import "ExpandButton.h"

#define ERROR_IMG                   @"load_image_error.png"             // 加载失败显示的默认图片
#define GET_IMAGE(imageStr)         [UIImage imageNamed:imageStr]       // 根据图片名取得图片
#define DEFAULT_LINE_COLOR          @"#e0e0e0"                          // 默认间隔线颜色
#define DEFAULT_LINE_WIDTH          0.5                                 // 默认线宽

#define FIELD_TEXT(tag) ((UITextField *)[self.view viewWithTag:tag]).text   // 获取指定tag值textField的text值

@interface Factory : NSObject

#pragma mark - 创建按钮
/// 空白button
+ (UIButton *)buttonWithRect:(CGRect)rect
                         Tag:(NSInteger)tag
                   SuperView:(UIView *)superView
                      Target:(id)target
                      Action:(SEL)action
                      events:(UIControlEvents)event;

/// 默认button点击事件是 UIControlEventTouchDown
+ (UIButton *)buttonWithRect:(CGRect)rect Tag:(NSInteger)tag SuperView:(UIView *)superView Target:(id)target Action:(SEL)action;

/// 带文字button
+(UIButton *)buttonWithRect:(CGRect)rect Text:(NSString *)text Font:(UIFont *)font NormalTextColor:(UIColor *)normalColor HighLightTextColor:(UIColor *)highLightColor  Tag:(NSInteger)tag SuperView:(UIView *)superView Target:(id)target Action:(SEL)action;

/// 带图片button
+(UIButton *)buttonWithRect:(CGRect)rect NormalBgImageStr:(NSString *)normalimage HighLightBgImageStr:(NSString *)hightLightImage  Tag:(NSInteger)tag SuperView:(UIView *)superView Target:(id)target Action:(SEL)action;

/// 带文字button 带背景颜色的
+(UIButton *)buttonWithRect:(CGRect)rect Text:(NSString *)text Font:(UIFont *)font NormalTextColor:(UIColor *)normalColor HighLightTextColor:(UIColor *)highLightColor  NormalBgColor:(UIColor *)normalBgColor HighLightBgColor:(UIColor *)highLightBgColor Tag:(NSInteger)tag SuperView:(UIView *)superView Target:(id)target Action:(SEL)action;

/// 带文字button 带背景颜色的 带圆角
+(UIButton *)buttonWithRect:(CGRect)rect Text:(NSString *)text Font:(UIFont *)font NormalTextColor:(UIColor *)normalColor HighLightTextColor:(UIColor *)highLightColor  NormalBgColor:(UIColor *)normalBgColor HighLightBgColor:(UIColor *)highLightBgColor Tag:(NSInteger)tag SuperView:(UIView *)superView Target:(id)target Action:(SEL)action Radius:(CGFloat)radius;

/// 带文字button 带背景颜色的 带边界颜色都button
+(UIButton *)buttonWithRect:(CGRect)rect Text:(NSString *)text Font:(UIFont *)font NormalTextColor:(UIColor *)normalColor HighLightTextColor:(UIColor *)highLightColor NormalBgColor:(UIColor *)normalBgColor HighLightBgColor:(UIColor *)highLightBgColor BorderColor:(UIColor *)borderColor Tag:(NSInteger)tag SuperView:(UIView *)superView Target:(id)target Action:(SEL)action;

/// 带图片button

/// 文字图片button  默认文字居左 UILineBreakModeTailTruncation  //这个不是很好用 换成自定义的以后
+ (UIButton *)buttonWithRect:(CGRect)buttonRect ImageEdgeInsets:(UIEdgeInsets)imageEdgeInsets TitleEdgeInsets:(UIEdgeInsets)titleEdgeInsets NormalImageName:(NSString *)normal SelectedImageName:(NSString *)selected Tag:(NSInteger)tag SuperView:(UIView *)superView Text:(NSString *)text Font:(UIFont *)font TitleNormalColor:(UIColor *)titleNormalColor TitleHighLightColor:(UIColor *)titleHighLightColor Target:(id)target Action:(SEL)action;

/// 带文字button 带背景颜色的 带边界颜色的button Radius
+(UIButton *)buttonWithRect:(CGRect)rect Text:(NSString *)text Font:(UIFont *)font NormalTextColor:(UIColor *)normalColor HighLightTextColor:(UIColor *)highLightColor NormalBgColor:(UIColor *)normalBgColor HighLightBgColor:(UIColor *)highLightBgColor BorderColor:(UIColor *)borderColor Tag:(NSInteger)tag SuperView:(UIView *)superView Radius:(float)radius Target:(id)target Action:(SEL)action;

#pragma mark - 创建UIView

/// 基本UIView 分割线
+ (UIView *)lineViewRect:(CGRect)rect SuperView:(UIView *)superView Tag:(NSInteger)tag LineColor:(UIColor *)color;

/// 默认线颜色是 #d2d2d2
+ (UIView *)lineViewRect:(CGRect)rect SuperView:(UIView *)superView Tag:(NSInteger)tag;

/// 默认线是颜色 #d2d2d2 线宽是0.5  左右空缺相同
+ (UIView *)lineViewOriginPoint:(CGPoint)point SuperView:(UIView *)superView Tag:(NSInteger)tag;

/// 默认线是颜色 #d2d2d2 线宽是0.5  宽度为屏幕宽度
+ (UIView *)lineView:(CGFloat)line SuperView:(UIView *)superView Tag:(NSInteger)tag;
/// 画虚线
+(UIView *)shapeLineWithFrame:(CGRect)frame withSuperView:(UIView *)superView withSpace:(float)space withWidth:(float)width withColor:(UIColor *)color;

/// 创建View: rect & superview & tag & backcolor
+ (UIView *)viewRect:(CGRect)rect SuperView:(UIView *)superView Tag:(NSInteger)tag BackColor:(UIColor *)color;

/// 创建View: rect & superview & tag & backcolor & radiu
+ (UIView *)viewRect:(CGRect)rect SuperView:(UIView *)superView Tag:(NSInteger)tag BackColor:(UIColor *)color Radius:(float)radius;

#pragma mark - UIImageView method
/// 添加本地图片
+ (UIImageView *)imageViewLoc:(NSString *)imageName Tag:(NSInteger)tag Rect:(CGRect)rect SuperView:(UIView *)superView;

/// 添加本地图片 圆角
+ (UIImageView *)imageViewLoc:(NSString *)imageName Tag:(NSInteger)tag Rect:(CGRect)rect SuperView:(UIView *)superView Radius:(CGFloat)radius;

/// 添加本地图片 圆形 单击事件
+ (UIImageView *)imageViewRoundingRectLoc:(NSString *)imageName Tag:(NSInteger)tag Rect:(CGRect)rect SuperView:(UIView *)superView Target:(id)target Action:(SEL)action;

/// 添加本地图片 圆角 单击事件
+ (UIImageView *)imageViewLoc:(NSString *)imageName Tag:(NSInteger)tag Rect:(CGRect)rect SuperView:(UIView *)superView Radius:(CGFloat)radius Target:(id)target Action:(SEL)action;

/// 添加异步加载图片 没点击事件
+ (UIImageView *)imageViewWeb:(NSString *)imgURLStr Placeholder:(UIImage *)image Tag:(NSInteger)tag Rect:(CGRect)rect SuperView:(UIView *)superView;

/// 添加异步加载图片  圆形 无点击
+(UIImageView *)imageViewRoundingRectWeb:(NSString *)imgURLStr Placeholder:(UIImage *)image Tag:(NSInteger)tag Rect:(CGRect)rect SuperView:(UIView *)superView;

/// 添加异步加载图片  圆角 无点击
+(UIImageView *)imageViewWeb:(NSString *)imgURLStr Placeholder:(UIImage *)image Tag:(NSInteger)tag Rect:(CGRect)rect SuperView:(UIView *)superView Radius:(CGFloat)radius;


/// 添加异步加载图片 有点击事件(默认鼠标抬起触发)
+ (UIImageView *)imageViewWeb:(NSString *)imgURLStr Placeholder:(UIImage *)image Tag:(NSInteger)tag Rect:(CGRect)rect SuperView:(UIView *)superView Target:(id)target Event:(SEL)event;

///// 将图片描边
//+ (UIImageView *)addGrayBorderImgViewWithRect:(CGRect)rect andImgURLString:(NSString *)imgURLString andTag:(NSInteger)tag SuperView:(UIView *)superView delegateObject:(id)delegate;
//
///// 将图片处理成圆角
//+ (UIImageView *)addArcImgViewWithRect:(CGRect)rect  andImgURLString:(NSString *)imgURLString andTag:(NSInteger)tag SuperView:(UIView *)superView;
//
///// 添加异步图片 有点击事件
//+ (UIImageView *)addImgViewWithRect:(CGRect)rect andImgURLString:(NSString *)imgURLString andTag:(NSInteger)tag SuperView:(UIView *)superView delegateObject:(id)delegate;
///// 添加异步图片 有点击事件  传入默认图
//+ (UIImageView *)addImgViewWithRect:(CGRect)rect andImgURLString:(NSString *)imgURLString andTag:(NSInteger)tag SuperView:(UIView *)superView delegateObject:(id)delegate withDefaultImage:(NSString *)deImageName FailLoadImageName:(NSString *)loadFailImageName;
///// 添加异步加载的图片 刚开始模型
//+ (UIImageView *)addImgViewWithRect:(CGRect)rect andImgURLString:(NSString *)imgURLString andTag:(NSInteger)tag SuperView:(UIView *)superView DefaultImageName:(NSString *)deImageName FailLoadImageName:(NSString *)loadFailImageName;

#pragma mark - UIImage 代码绘制纯色图片
+ (UIImage *)imageWithSize:(CGSize)size Color:(UIColor *)color;

/// UIImage: color
+ (UIImage *)imageWithColor:(UIColor *)color;

#pragma mark - 截取指定大小的图片
+ (UIImage*)imageByScalingAndCroppingForSize:(UIImage*)anImage toSize:(CGSize)targetSize;

#pragma makr - UILabel method
/// 基本label
+ (UILabel *)labelWithFrame:(CGRect)frame SuperView:(UIView *)superView Tag:(NSInteger)tag Text:(NSString *)text;

/// font & textcolor & textalignment
+ (UILabel *)labelWithFrame:(CGRect)frame SuperView:(UIView *)superView Tag:(NSInteger)tag Text:(NSString *)text Font:(UIFont*)font TextColor:(UIColor *)color TextAlignment:(NSTextAlignment)alignment;

/// 设置换行模式 font textcolor textalignment
+ (UILabel *)labelWithFrame:(CGRect)frame SuperView:(UIView *)superView Tag:(NSInteger)tag Text:(NSString *)text Font:(UIFont*)font TextColor:(UIColor *)color TextAlignment:(NSTextAlignment)alignment LineBreakMode:(NSLineBreakMode)lineBreakMode;

/// fontSize textcolor textalignment
+ (UILabel *)labelWithFrame:(CGRect)frame SuperView:(UIView *)superView Tag:(NSInteger)tag Text:(NSString *)text FontSize:(float)fontSize TextColor:(UIColor *)color TextAlignment:(NSTextAlignment)alignment;

/// 设置换行模式 fontSize textcolor textalignment
+ (UILabel *)labelWithFrame:(CGRect)frame SuperView:(UIView *)superView Tag:(NSInteger)tag Text:(NSString *)text FontSize:(float)fontSize TextColor:(UIColor *)color TextAlignment:(NSTextAlignment)alignment BreakMode:(NSLineBreakMode)lineBreakMode;

/**
 *  Get the height of target label
 */
+ (CGFloat)getHeightOfLabel:(NSString *)text FontSize:(CGFloat)fontSize ContentWidth:(CGFloat)aMaxWidth;

#pragma makr - UITextField method

/// frame & superView & tag & placeholder
+ (UITextField *)textFieldWithFrame:(CGRect)frame SuperView:(UIView *)superView Tag:(NSInteger)tag Placeholder:(NSString *)placeholder;

/// frame & superView & tag & placeholder & color
+ (UITextField *)textFieldWithFrame:(CGRect)frame SuperView:(UIView *)superView Tag:(NSInteger)tag Placeholder:(NSString *)placeholder Font:(UIFont *)font TextColor:(UIColor *)textColor;

/// frame & superView & tag & placeholder & color & delegate & boderStyle
+ (UITextField *)textFieldWithFrame:(CGRect)frame SuperView:(UIView *)superView Tag:(NSInteger)tag Placeholder:(NSString *)placeholder Font:(UIFont *)font TextColor:(UIColor *)textColor Delegate:(id)delegate SecureText:(BOOL)isSecure BoderStyle:(UITextBorderStyle)boderStyle;

/// frame & superView & tag & placeholder & color & delegate
+ (UITextField *)textFieldWithFrame:(CGRect)frame SuperView:(UIView *)superView Tag:(NSInteger)tag Placeholder:(NSString *)placeholder Font:(UIFont *)font TextColor:(UIColor *)textColor Delegate:(id)delegate SecureText:(BOOL)isSecure;

/// frame & superView & tag & placeholder & color & textalignment
+ (UITextField *)textFieldWithFrame:(CGRect)frame SuperView:(UIView *)superView Tag:(NSInteger)tag Placeholder:(NSString *)placeholder Font:(UIFont *)font TextColor:(UIColor *)textColor TextAlignment:(NSTextAlignment)alignment;

/// Icon & frame & superView & tag & placeholder & color
+ (UITextField *)textFieldWithFrame:(CGRect)frame SuperView:(UIView *)superView Tag:(NSInteger)tag Icon:(NSString *)iconName Placeholder:(NSString *)placeholder Font:(UIFont *)font TextColor:(UIColor *)textColor;

#pragma mark - 创建颜色

/// 创建16进制颜色(透明度1)
+ (UIColor *)colorWithHexString:(NSString *)colorStr;
/// 以日为单位比较2个时间的大小(返回1 1>2  0 1=2  -1 1<2)
+(int)compareDate:(NSDate *)date1 withDate:(NSDate *)date2;
@end
