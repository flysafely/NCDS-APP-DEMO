//
//  UITabBarController+CancelDoubleClick.m
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-14.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import "UITabBarController+CancelDoubleClick.h"

@implementation UITabBarController (CancelDoubleClick)
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    UIViewController *vcSelected = tabBarController.selectedViewController;
    
    if ([vcSelected isEqual:viewController]) {
        return NO;
    }
    
    return YES;
}
@end
