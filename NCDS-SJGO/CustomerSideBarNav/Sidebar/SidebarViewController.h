//
//  ViewController.h
//  SideBarNavDemo
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//

#import <UIKit/UIKit.h>
#import "SideBarSelectedDelegate.h"

//#import "UINavigationBar+CateNavigationBar.h"
@interface SidebarViewController : UIViewController<SideBarSelectDelegate,UINavigationControllerDelegate,UITabBarControllerDelegate>


//@property (retain, nonatomic) NSObject<UserRegisterDelegate> *delegate2;
@property (strong,nonatomic)IBOutlet UIView *contentView;
@property (strong,nonatomic)IBOutlet UIView *navBackView;

+ (id)share;

@end
