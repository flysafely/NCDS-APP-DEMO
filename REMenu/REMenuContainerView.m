//
// REMenuContainerView.m
// REMenu
//  NCDS-SJGO
//
//  Created by 徐子迈 on 13-1-2.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import "REMenuContainerView.h"
#import <QuartzCore/QuartzCore.h>

@implementation REMenuContainerView

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect frame = self.frame;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    frame.origin.y = _navigationBar.frame.origin.y + (UIDeviceOrientationIsPortrait(orientation) ? 44 : 32);
    self.frame = frame;
}

@end
