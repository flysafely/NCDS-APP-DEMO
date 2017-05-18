//
//  UINavigationBar+CateNavigationBar.m
//  NCDS-SJGO
//
//  Created by 徐子迈 on 13-1-1.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//  所有Navigationbar 的输出效果 重载！

#import "UINavigationBar+CateNavigationBar.h"
#import <QuartzCore/CALayer.h>
@implementation UINavigationBar (CateNavigationBar)
- (void)layoutSubviews {
    CGRect barFrame = self.frame;
    barFrame.size.height = 44.0; //新的高度
    self.frame = barFrame;
}

//其实只需要覆盖该方法就行，把self.frame.size.height改成100.0就OK
- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed:@"nvbg"];
    [image drawInRect:CGRectMake(0, 0, 320, 44)];
}
- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity
{
    // Creating shadow path for better performance
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    self.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = opacity;
    
    // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
    self.clipsToBounds = NO;
    
}
@end
