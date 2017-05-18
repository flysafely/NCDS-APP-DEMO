//
//  ThirdViewController.h
//  NCDS-SJGO
//  已经买到的物品
//  Created by 徐子迈 on 13-1-2.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *maintable;
@property (retain, nonatomic) NSMutableArray *item;
@property (retain, nonatomic) IBOutlet UIToolbar *toolBar;
- (IBAction)back:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UIButton *back;
@end
