//
//  FirstViewController.h
//  SideBarNavDemo
//
//  Created by 徐子迈 on 12-12-11.
//  Copyright (c) 2012年 XcodeTest.All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserClass.h"
#import "UserRegisterDelegate.h"
#import "FDTakeController.h"
#import "ChatViewController.h"
#import "SKBounceAnimation.h"

@interface FirstViewController : UIViewController<UIScrollViewDelegate,UserRegisterDelegate,FDTakeDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate>{
    
    IBOutlet UIButton *_NewUser;
    IBOutlet UIButton *_Register;
}
- (IBAction)showRightSideBar:(UIButton *)sender;

- (IBAction)showLeftSidebar:(UIButton *)sender;
@property (retain,nonatomic) ChatViewController *chatView;
@property (retain,nonatomic) FDTakeController *takeController;
@property (retain, nonatomic) IBOutlet UIPageControl *pagecontrol;
@property (retain, nonatomic) IBOutlet UIScrollView *BannerScroll;
@property (retain, nonatomic) IBOutlet UIButton *Create;
@property (strong,nonatomic)IBOutlet UILabel *titleLabel;
@property (retain,nonatomic) NSString *money;

@property (assign,nonatomic) int index;
@property (retain, nonatomic) IBOutlet UIButton *UserRegister;
//@property (retain, nonatomic) IBOutlet UIImageView *catimageview;
- (IBAction)GotoUserCart:(UIButton *)sender;

- (IBAction)GetInToUserRegisterVC:(UIButton *)sender;
- (IBAction)GetInToCreateNewUserVC:(UIButton *)sender;
- (IBAction)TDcode:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UIToolbar *toolBar;
@property (retain, nonatomic) IBOutlet UIButton *Usercart;
- (IBAction)docharge:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UILabel *nickname;
@property (retain, nonatomic) IBOutlet UILabel *usermoney;
//- (IBAction)refresh:(UIButton *)sender;
//@property (retain, nonatomic) IBOutlet UIButton *refreshbutton;
@property (retain, nonatomic) IBOutlet UIImageView *Userimage;
@property (retain, nonatomic) UserClass *passuserdata;
@property (retain, nonatomic) IBOutlet UILabel *points;
@property (retain, nonatomic) IBOutlet UIImageView *Levelimge;
@property (retain, nonatomic) IBOutlet UIImageView *Userbgimage;
@property (retain, nonatomic) IBOutlet UIImageView *shadowline;
- (IBAction)Getimage:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UIButton *chooseimage;
@property (retain, nonatomic) IBOutlet UIImageView *cutline;
@property (retain, nonatomic) IBOutlet UILabel *moneylabel;
@property (retain, nonatomic) IBOutlet UILabel *pointlabel;
@property (retain, nonatomic) IBOutlet UIImageView *cutimage;
@property (retain,nonatomic) UIButton *quitchat;
@property (retain, nonatomic) UIButton *showkeyboard;
- (IBAction)chatonline:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UIButton *AttentionBrand;
- (IBAction)GotoAttentionBrand:(UIButton *)sender;


@end
