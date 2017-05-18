//
//  UINavigationBar+CateNavigationBar.h
//  NCDS-SJGO
//
//  Created by 徐子迈 on 13-1-1.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import <UIKit/UIKit.h>
//重写navigationbar的输出效果....
@interface UINavigationBar (CateNavigationBar)
- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity;
@end
