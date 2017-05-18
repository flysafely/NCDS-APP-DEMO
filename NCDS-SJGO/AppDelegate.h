//
//  AppDelegate.h
//  NCDS-SJGO
//
//  Created by 徐子迈 on 12-12-28.
//  Copyright (c) 2012年 XcodeTest. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SidebarViewController;
#import "HomeViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
    UIImageView *zView;//Z图片ImageView
    UIImageView *fView;//F图片ImageView
    
    
    UIView *rView;//图片的UIView

}

@property (strong, nonatomic) UIWindow *window;
//@property (strong, nonatomic) SidebarViewController *viewController;
@end
