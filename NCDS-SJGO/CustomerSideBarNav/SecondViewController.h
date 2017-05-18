//
//  SeconViewController.h
//  SideBarNavDemo
//  购物车
//  Created by JianYe on 12-12-12.
//  Copyright (c) 2012年 JianYe. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class QBPopupMenu;
@interface SecondViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
- (IBAction)back:(id)sender;
@property (retain,nonatomic) NSMutableArray *item;
@property (retain,nonatomic) NSMutableArray *proid;
@property (retain,nonatomic) NSMutableArray *proname;
@property (retain, nonatomic) IBOutlet UITableView *carttable;
@property (retain, nonatomic) IBOutlet UILabel *totalvolume;
@property (retain, nonatomic) IBOutlet UILabel *totalmoney;
@property (retain,nonatomic) NSString *address;
@property (retain,nonatomic) UIImageView *addimage;
@property (retain,nonatomic) UITextField *addtext;
- (IBAction)CheckOut:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UIToolbar *toolBar;
@property (retain, nonatomic) IBOutlet UIButton *checkoutbtn;
@property (retain, nonatomic) IBOutlet UIButton *back;


@end
