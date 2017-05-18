//
//  UITabBarController+CancelDoubleClick.h
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-14.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarController (CancelDoubleClick)

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController;
@end
