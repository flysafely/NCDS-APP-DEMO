//
//  LeftNavViewController.h
//  SideBarNavDemo
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//

#import <UIKit/UIKit.h>
#import "XYAlertView.h"
#import <QuartzCore/CALayer.h>
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourViewController.h"
#import "FiveViewController.h"

//#import "UIpassvaluedelegate.h"
@protocol SideBarSelectDelegate ;

@interface LeftSideBarViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
}

@property (strong,nonatomic)IBOutlet UITableView *mainTableView;
@property (assign,nonatomic)id<SideBarSelectDelegate>delegate;
@property (retain, nonatomic) IBOutlet UIToolbar *toolbar;
@property (retain, nonatomic) IBOutlet UIImageView *Userimage;

@end

