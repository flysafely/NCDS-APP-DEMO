//
//  HomeViewController.h
//  NCDS-SJGO
//
//  Created by 徐子迈 on 12-12-28.
//  Copyright (c) 2012年 XcodeTest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UITabBarController<UITabBarDelegate,UITabBarControllerDelegate>
@property (retain, nonatomic) IBOutlet UITabBar *TabBar;
@end
