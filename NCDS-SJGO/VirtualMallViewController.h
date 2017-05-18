//
//  VirtualMallViewController.h
//  NCDS-SJGO
//
//  Created by 徐子迈 on 12-12-28.
//  Copyright (c) 2012年 XcodeTest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "hiddebar.h"
#import "REMenu.h"
#import "SKBounceAnimation.h"

@interface VirtualMallViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITabBarControllerDelegate,hiddebar>
- (IBAction)pop:(id)sender forEvent:(UIEvent*)event;
@property (retain, nonatomic) IBOutlet UIToolbar *toolbar;
@property (retain, nonatomic) IBOutlet UITableView *a;

//- (IBAction)pushtosub:(UIBarButtonItem *)sender;
@property(retain,nonatomic) NSMutableArray *item;
@property (strong, nonatomic) REMenu *menu;
@property (retain,nonatomic) UIButton *btn;
@end
