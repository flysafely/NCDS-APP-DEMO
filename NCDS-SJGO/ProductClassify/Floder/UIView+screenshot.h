//
//  UIView+screenshot.h
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//

#import <UIKit/UIKit.h>

@interface UIView (screenshot)

- (UIImage *)screenshotWithOffset:(CGFloat)deltaY;
- (UIImage *)screenshot;

@end
