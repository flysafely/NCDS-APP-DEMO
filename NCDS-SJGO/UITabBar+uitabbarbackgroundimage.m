//
//  UITabBar+uitabbarbackgroundimage.m
//  NCDS-SJGO
//
//  Created by 徐子迈 on 13-1-3.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import "UITabBar+uitabbarbackgroundimage.h"

@implementation UITabBar (uitabbarbackgroundimage)
- (void)drawRect:(CGRect)rect{
    // Drawing code.
    CGRect bounds=[self bounds];
    
    NSLog(@"%@",[NSValue valueWithCGRect:bounds]);
    
    // [[UIColor redColor] set];
    
    [[UIColor colorWithPatternImage:[UIImage imageNamed:@"tablebar.png"]] set];
    
    UIRectFill (bounds);
}
@end
