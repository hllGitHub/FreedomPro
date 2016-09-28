//
//  UIView+GradientView.m
//  MyNews
//
//  Created by Apple on 16/7/13.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "UIView+GradientView.h"

@implementation UIView (GradientView)

- (void)drawGradientColor{
    UIColor *colorBegin = [UIColor colorWithWhite:1.0 alpha:1.0];
    UIColor *colorEnd = [UIColor colorWithWhite:1.0 alpha:0.0];
    NSArray *colorArr = [NSArray arrayWithObjects:(id)colorBegin.CGColor, (id)colorEnd.CGColor, nil];
    
    CGFloat gradientFactor = 0.3;   // 渐变因子

    // layer1
    CAGradientLayer *viewLayer1 = [CAGradientLayer layer];
    viewLayer1.colors = colorArr;
    viewLayer1.startPoint = CGPointMake(0, 0.5);
    viewLayer1.endPoint = CGPointMake(gradientFactor, 0.5);
    viewLayer1.frame = CGRectMake(0, 0, gradientFactor * CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    [self.layer insertSublayer:viewLayer1 atIndex:0];
    
    // layer2
    CAGradientLayer *viewLayer2 = [CAGradientLayer layer];
    viewLayer2.colors = colorArr;
    viewLayer2.startPoint = CGPointMake(1, 0.5);
    viewLayer2.endPoint = CGPointMake((1 - gradientFactor), 0.5);
    viewLayer2.frame = CGRectMake((1 - gradientFactor) * CGRectGetWidth(self.frame), 0, gradientFactor * CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    [self.layer insertSublayer:viewLayer2 atIndex:0];
}

- (void)test {
    UIColor *colorBegin = [UIColor colorWithWhite:1.0 alpha:1.0];
    UIColor *colorEnd = [UIColor colorWithWhite:1.0 alpha:0.0];
    NSArray *colorArr = [NSArray arrayWithObjects:(id)colorBegin.CGColor, (id)colorEnd.CGColor, nil];
    //    NSNumber *stopBegin = [NSNumber numberWithFloat:0.0];
    //    NSNumber *stopEnd = [NSNumber numberWithFloat:1.0];
    //
    CGPoint startPoint = CGPointMake(0, 0);
    CGPoint endPoint = CGPointMake(1, 0);
    
    //
    //    NSArray *locationArr = [NSArray arrayWithObjects:stopBegin, stopEnd, nil];
    //
    CAGradientLayer *viewLayer = [CAGradientLayer layer];
    viewLayer.colors = colorArr;
    //    viewLayer.locations = locationArr;
    viewLayer.startPoint = startPoint;
    viewLayer.endPoint = endPoint;
    viewLayer.frame = self.bounds;
    //    [self removeAllSubLayers];
    
    [self.layer insertSublayer:viewLayer atIndex:0];
}

- (void)removeAllSubLayers{
    for (CALayer *layer in self.layer.sublayers) {
        [layer removeFromSuperlayer];
    }
}

@end
