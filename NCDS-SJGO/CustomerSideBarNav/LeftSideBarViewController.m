//
//  LeftNavViewController.m
//  SideBarNavDemo
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//


#import "CreateNewUserViewController.h"
#import "LeftSideBarViewController.h"
#import "FirstViewController.h"
#import "SideBarSelectedDelegate.h"
#import "UserRegisterViewController.h"
#import "UIToolbar+uitoolbarshadow.h"
#import <QuartzCore/CALayer.h>
#import "FourNavigationViewController.h"
#import "ThirdNavigationViewController.h"
#import "SecondNavigationViewController.h"

@interface LeftSideBarViewController ()
{
    NSArray *_dataList;
    NSArray *Imagearray;
    int _selectIdnex;

}
@end

@implementation LeftSideBarViewController
@synthesize mainTableView,delegate;
@synthesize toolbar=_toolbar;
@synthesize Userimage=_Userimage;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _dataList = @[@" 我的购物车",@" 未完成的订单",@" 已完成的订单",@" 系统设置"];
    [_dataList retain];
    Imagearray =@[[UIImage imageNamed:@"tmall_icon_profile_cart"],[UIImage imageNamed:@"tmall_icon_profile_inprogress"],[UIImage imageNamed:@"tmall_icon_profile_finished"],[UIImage imageNamed:@"setting_press.png"]];
    [Imagearray retain];
    if ([delegate respondsToSelector:@selector(leftSideBarSelectWithController:)]) {
        [delegate leftSideBarSelectWithController:[self subConWithIndex:0]];
        _selectIdnex = 0;
    }

    UIImage *toolBarIMG = [UIImage imageNamed: @"navbar-first"];

    if ([self.toolbar respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)]) {
        [self.toolbar setBackgroundImage:toolBarIMG forToolbarPosition:0 barMetrics:0];
    }//设置toolbar的背景图片
    [self.view bringSubviewToFront:self.toolbar];//因为toolbar view 的层级跟 tableview 的层级一样  所以要显示出 toolbar的阴影 要把 toolbar放在最上层
    self.view.backgroundColor=[UIColor clearColor];
    
    [self.toolbar dropShadowWithOffset:CGSizeMake(0, 0) radius:5.0 color:[UIColor blackColor] opacity:0.6];//重写toolebar 阴影绘制函数！！FirstViewcontroller中由于其toolbar本来就放置再最前面 即使不用重写的方法 也能直接shadowoffset 设置
    UIView *tablebgview=[[[UIView alloc] init] autorelease];
    tablebgview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"feed-cover-background"]];
    self.mainTableView.backgroundView=tablebgview;
    [self.mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    CALayer *celllayer=[self.Userimage layer];
    celllayer.borderColor = [[UIColor whiteColor] CGColor];
    celllayer.borderWidth = 1.5f;
    self.Userimage.layer.masksToBounds=YES;
    self.Userimage.layer.cornerRadius=self.Userimage.frame.size.width/2;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LeftSideBarViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell==nil){
        cell=[[[NSBundle mainBundle] loadNibNamed:@"LeftSideBarViewControllerCell" owner:nil options:nil] lastObject];
    }
    [(UILabel *)[cell viewWithTag:2] setText:[_dataList objectAtIndex:indexPath.row]];
    [(UILabel *)[cell viewWithTag:2] setFont:[UIFont systemFontOfSize:15]];
    [(UIImageView *)[cell viewWithTag:1] setImage:[Imagearray objectAtIndex:indexPath.row]];
//    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor=[UIColor clearColor];
    cell.contentView.opaque=NO;

    UIImageView *cellselected=[[[UIImageView alloc] initWithFrame:cell.frame] autorelease];
    cellselected.image=[UIImage imageNamed:@"cellBackTouch"];
    //    [vie addSubview:cellselected];
    cell.selectedBackgroundView=cellselected;

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
        {
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"CheckStatus"] isEqualToString:@"未登录"]) {
                XYAlertView *alertView = [XYAlertView alertViewWithTitle:@"抱歉！"
                                                                 message:@"您还没有登录？"
                                                                 buttons:[NSArray arrayWithObjects:@"确定", @"取消", nil]
                                                            afterDismiss:^(int buttonIndex) {
//                                                                if (buttonIndex==0) {
//                                                                    UserRegisterViewController *user=[[[UserRegisterViewController alloc] init] autorelease];
//                                                                    [self presentViewController:user animated:YES completion:nil];
//                                                                }
                                                            }];
                
                [alertView setButtonStyle:XYButtonStyleGray atIndex:1];
                
                [alertView show];
                //                [alertView release];
                
            }else{
                
                SecondViewController *pushview=[[[SecondViewController alloc] init] autorelease];
                
                SecondNavigationViewController *nav=[[[SecondNavigationViewController alloc] initWithRootViewController:pushview] autorelease];
                [self presentViewController:nav animated:YES completion:nil];
                
            }
        }
            break;
        case 2:
        {
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"CheckStatus"] isEqualToString:@"未登录"]) {
                XYAlertView *alertView = [XYAlertView alertViewWithTitle:@"抱歉！"
                                                                 message:@"您还没有登录？"
                                                                 buttons:[NSArray arrayWithObjects:@"确定", @"取消", nil]
                                                            afterDismiss:^(int buttonIndex) {
//                                                                if (buttonIndex==0) {
//                                                                    UserRegisterViewController *user=[[[UserRegisterViewController alloc] init] autorelease];
//                                                                    [self presentViewController:user animated:YES completion:nil];
//                                                                }
                                                            }];
                
                [alertView setButtonStyle:XYButtonStyleGray atIndex:1];
                
                [alertView show];
                //                [alertView release];
                
            }else{
                
                ThirdViewController *third=[[[ThirdViewController alloc] init] autorelease];
                ThirdNavigationViewController *pushview=[[[ThirdNavigationViewController alloc] initWithRootViewController:third] autorelease];
                [self presentViewController:pushview animated:YES completion:nil];
                
            }
        }
            break;
        case 1:
        {
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"CheckStatus"] isEqualToString:@"未登录"]) {
                XYAlertView *alertView = [XYAlertView alertViewWithTitle:@"抱歉！"
                                                                 message:@"您还没有登录？"
                                                                 buttons:[NSArray arrayWithObjects:@"确定", @"取消", nil]
                                                            afterDismiss:^(int buttonIndex) {
//                                                                if (buttonIndex==0) {
//                                                                    UserRegisterViewController *user=[[[UserRegisterViewController alloc] init] autorelease];
//                                                                    [self presentViewController:user animated:YES completion:nil];
//                                                                }
                                                            }];
                
                [alertView setButtonStyle:XYButtonStyleGray atIndex:1];
                
                [alertView show];
                //                [alertView release];
                
            }else{
                
                FourViewController *four=[[[FourViewController alloc] init] autorelease];
                FourNavigationViewController *pushview=[[[FourNavigationViewController alloc] initWithRootViewController:four] autorelease];
                [self presentViewController:pushview animated:YES completion:nil];
                
            }
        }
            break;
        case 3:
        {
            //            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"CheckStatus"] isEqualToString:@"未登录"]) {
            XYAlertView *alertView = [XYAlertView alertViewWithTitle:@"抱歉！"
                                                             message:@"功能尚未开放！"
                                                             buttons:[NSArray arrayWithObjects:@"确定", nil]
                                                        afterDismiss:^(int buttonIndex) {
                                                            //                                                                if (buttonIndex==0) {
                                                            //                                                                    UserRegisterViewController *user=[[[UserRegisterViewController alloc] init] autorelease];
                                                            //                                                                    [self presentViewController:user animated:YES completion:nil];
                                                            //                                                                }
                                                        }];
            
            [alertView setButtonStyle:XYButtonStyleGray atIndex:1];
            
            [alertView show];
            //                [alertView release];
            
            //            }else{
            //            XYAlertView *alertView = [XYAlertView alertViewWithTitle:@"稍后请确定！"
            //                                                             message:@"马上进入‘设置’"
            //                                                             buttons:[NSArray arrayWithObjects:@"确定", @"取消", nil]
            //                                                        afterDismiss:^(int buttonIndex) {
            //                                                            if (buttonIndex==0) {
            //                                                                FiveViewController *pushview=[[[FiveViewController alloc] init] autorelease];
            //                                                                [self presentViewController:pushview animated:YES completion:nil];
            
            //        }
        }
            break;
        default:
            break;
    }
    
    
    
    NSUserDefaults *select=[NSUserDefaults standardUserDefaults];
    [select setInteger:indexPath.row forKey:@"Select"];
}

- (UINavigationController *)subConWithIndex:(int)index
{
    FirstViewController *con = [[[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil] autorelease];
    con.index = index+1;
    UINavigationController *nav= [[[UINavigationController alloc] initWithRootViewController:con] autorelease];
    nav.navigationBar.hidden = YES;
    
    return nav ;
}


- (void)dealloc {
    [_toolbar release];
    [_Userimage release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setToolbar:nil];
    [self setUserimage:nil];
    [super viewDidUnload];
}
@end
