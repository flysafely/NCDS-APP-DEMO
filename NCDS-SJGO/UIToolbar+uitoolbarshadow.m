//
//  UIToolbar+uitoolbarshadow.m
//  NCDS-SJGO
//
//  Created by 徐子迈 on 13-1-4.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import "UIToolbar+uitoolbarshadow.h"
#import <QuartzCore/CALayer.h>
@implementation UIToolbar (uitoolbarshadow)
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
