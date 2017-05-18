//
//  UIToolbar+uitoolbarshadow.h
//  NCDS-SJGO
//
//  Created by 徐子迈 on 13-1-4.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIToolbar (uitoolbarshadow)
- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity;
@end
