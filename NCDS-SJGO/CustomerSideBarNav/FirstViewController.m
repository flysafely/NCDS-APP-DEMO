//
//  FirstViewController.m
//  SideBarNavDemo
//
//  Created by 徐子迈 on 12-12-11.
//  Copyright (c) 2012年 XcodeTest.All rights reserved.
//

#import "FirstViewController.h"
#import "SidebarViewController.h"
#import "SecondViewController.h"
#import "UserRegisterViewController.h"
#import "CreateNewUserViewController.h"
#import "LeftSideBarViewController.h"
#import "ThirdViewController.h"
#import <QuartzCore/CALayer.h>
#import "TDScanViewController.h"
#import "TDScanNavigationViewController.h"
#import "SecondNavigationViewController.h"
#import "XYInputView.h"
#import "FMDatabase.h"
#import "UserRegisterViewController.h"
#import "UIImageView+LBBlurredImage.h"
#import "AttentionViewController.h"
#import "PayMentViewController.h"
@interface FirstViewController (){
    int m;
    ChatViewController *chatview;
    int n;
    
}
@property BOOL offline;
@property  BOOL FirstTime;
@end

@implementation FirstViewController
@synthesize titleLabel,index;
@synthesize Create=_Create;
@synthesize toolBar=_toolBar;
@synthesize BannerScroll=_BannerScroll;
@synthesize pagecontrol=_pagecontrol;
@synthesize UserRegister=_UserRegister;
@synthesize Usercart=_Usercart;
@synthesize money=_money;
@synthesize nickname=_nickname;
@synthesize usermoney=_usermoney;
@synthesize passuserdata=_passuserdata;
@synthesize points=_points;
@synthesize Levelimge=_Levelimge;
@synthesize Userbgimage=_Userbgimage;
@synthesize shadowline=_shadowline;
@synthesize chooseimage=_chooseimage;
@synthesize cutline=_cutline;
@synthesize moneylabel=_moneylabel;
@synthesize pointlabel=_pointlabel;
@synthesize cutimage=_cutimage;
@synthesize chatView=_chatView;
@synthesize quitchat=_quitchat;
@synthesize FirstTime=_FirstTime;
@synthesize AttentionBrand=_AttentionBrand;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        m=0;
    }
    
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"当前文件为FirstViewController************");
    [super viewDidLoad];
    self.FirstTime=YES;
    self.offline=YES;
//    self.tabBarController.delegate=self;
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(12, 6,33, 33)];
    UIImage *btnimage=[UIImage imageNamed:@"nux-red-button.png"];
    btnimage=[btnimage resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [btn setBackgroundImage:btnimage forState:UIControlStateNormal];
    [btn setTintColor:[UIColor blackColor]];
    btn.titleLabel.font=[UIFont systemFontOfSize:10];
    [btn setTitle:@"返 回" forState:UIControlStateNormal];
    [btn setTitle:@"返 回" forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(moveoutchatview) forControlEvents:UIControlEventTouchUpInside];
    self.quitchat=btn;
    self.quitchat.hidden=YES;
    [btn release];
    
    UIButton *btn2=[[UIButton alloc] initWithFrame:CGRectMake(2,460,44, 45)];
    UIImage *btn2image=[UIImage imageNamed:@"Mode_listtotext"];
    UIImage *btn2imagehl=[UIImage imageNamed:@"Mode_listtotextHL"];
    [btn2 setImage:btn2imagehl forState:UIControlStateHighlighted];
    [btn2 setImage:btn2image forState:UIControlStateNormal];
    [btn2 setTintColor:[UIColor blackColor]];
    [btn2 addTarget:self action:@selector(movekeyboard) forControlEvents:UIControlEventTouchUpInside];
    self.showkeyboard=btn2;
    self.showkeyboard.hidden=YES;
    [btn2 release];
    
//    ChatViewController *chat=[[ChatViewController alloc] initWithNibName:@"ChatViewController" bundle:nil];
//    self.chatView=chat;
//    self.chatView.view.frame=CGRectMake(0, 1136, 320, 1136);

//    [self.view addSubview:self.chatView.view];
//    [self.view addSubview:self.quitchat];
//    [self.view addSubview:self.showkeyboard];
//    [self.view bringSubviewToFront:self.chatView.view];
//    [self.view bringSubviewToFront:self.quitchat];
//    [self.view bringSubviewToFront:self.showkeyboard];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Getimage:)];
    singleTap.delegate=self;
    singleTap.numberOfTapsRequired=1;
    [self.Userimage addGestureRecognizer:singleTap];
    self.Userimage.userInteractionEnabled=YES;
    [singleTap release];
    
    UIImage *toolBarIMG = [UIImage imageNamed: @"navbar-first"];
    if ([self.toolBar respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)]) {
        [self.toolBar setBackgroundImage:toolBarIMG forToolbarPosition:0 barMetrics:0];
    }//设置toolbar的背景图片
    
    self.takeController = [[[FDTakeController alloc] init] autorelease];
   self.takeController.delegate = self;
    CALayer *celllayer=[self.Userimage layer];
    celllayer.borderColor = [[UIColor whiteColor] CGColor];
    celllayer.borderWidth = 1.5f;
    self.Userimage.layer.masksToBounds=YES;
    self.Userimage.layer.cornerRadius=self.Userimage.frame.size.width/2;
    
    [self.UserRegister setTitle:@"用户登录" forState:UIControlStateNormal];
    [self.UserRegister setTitle:@"用户登录" forState:UIControlStateHighlighted];
    self.toolBar.layer.shadowPath=[UIBezierPath bezierPathWithRect:self.toolBar.bounds].CGPath;
    self.toolBar.layer.shadowOffset = CGSizeMake(0, 0);
    self.toolBar.layer.shadowColor = [UIColor blackColor].CGColor;
    self.toolBar.layer.shadowOpacity = 0.8;
//    self.view.backgroundColor=[UIColor whiteColor];

    self.Create.frame=CGRectMake(8, 244, 304, 50);
    self.Create.alpha=1;
    self.usermoney.alpha=0;
    self.nickname.alpha=0;
//    self.refreshbutton.hidden=YES;
    self.Userimage.alpha=0;
    self.points.alpha=0;
    self.Levelimge.alpha=0;
    self.shadowline.alpha=0;
    self.cutline.alpha=0;
    self.moneylabel.alpha=0;
    self.pointlabel.alpha=0;
    self.cutimage.alpha=0;
    self.Levelimge.frame=CGRectMake(230, 211, ([self.passuserdata._UserPoints intValue]/1000+1)*12, 12);
    self.Userbgimage.alpha=0;
    self.chooseimage.hidden=YES;
    self.chooseimage.alpha=0;
    self.Create.layer.borderWidth=0;
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"feed-paper-texture"]];
//    设View置背景颜色 不用再重新添加ImageView
    self.view.layer.masksToBounds=YES;
    self.view.layer.cornerRadius=5.0;
    //设置 快速注册 按钮的背景图片
    UIImage *Createbg=[[UIImage imageNamed:@"cbg"] autorelease];
    Createbg=[Createbg resizableImageWithCapInsets:UIEdgeInsetsMake(25, 15, 25,40)];
    [self.Create setBackgroundImage:Createbg forState:UIControlStateNormal];
    UIImage *presscreatebg=[[UIImage imageNamed:@"cbg_press"] autorelease];
    presscreatebg=[presscreatebg resizableImageWithCapInsets:UIEdgeInsetsMake(25, 15, 25, 40)];
    [self.Create setBackgroundImage:presscreatebg forState:UIControlStateHighlighted];
    
    //设置 用户登录 按钮的背景图片
    UIImage *UserRegisterbg=[[UIImage imageNamed:@"urbg"] autorelease];
    UserRegisterbg=[UserRegisterbg resizableImageWithCapInsets:UIEdgeInsetsMake(25, 15, 25,40)];
    [self.UserRegister setBackgroundImage:UserRegisterbg forState:UIControlStateNormal];
    UIImage *pressUserRegisterbg=[[UIImage imageNamed:@"urbg_press"] autorelease];
    pressUserRegisterbg=[pressUserRegisterbg resizableImageWithCapInsets:UIEdgeInsetsMake(25, 15, 25, 40)];
    [self.UserRegister setBackgroundImage:pressUserRegisterbg forState:UIControlStateHighlighted];
 
    UIImage *UserCartbg=[[UIImage imageNamed:@"usercartbottun_bg"] autorelease];
    UserCartbg=[UserCartbg resizableImageWithCapInsets:UIEdgeInsetsMake(25,15,25,40)];
    [self.Usercart setBackgroundImage:UserCartbg forState:UIControlStateNormal];
    UIImage *pressUserCartbg=[[UIImage imageNamed:@"urcbg_press"] autorelease];
    pressUserCartbg=[pressUserCartbg resizableImageWithCapInsets:UIEdgeInsetsMake(25, 15, 25, 40)];
    [self.Usercart setBackgroundImage:pressUserCartbg forState:UIControlStateHighlighted];
    
    UIImage *attentionbg=[[UIImage imageNamed:@"tmall_btn_channel_btn_red_nor"] autorelease];
    attentionbg=[attentionbg resizableImageWithCapInsets:UIEdgeInsetsMake(25, 15, 25,40)];
    [self.AttentionBrand setBackgroundImage:attentionbg forState:UIControlStateNormal];
    UIImage *pressattention=[[UIImage imageNamed:@"tmall_btn_channel_btn_red_press"] autorelease];
    pressattention=[pressattention resizableImageWithCapInsets:UIEdgeInsetsMake(25, 15, 25, 40)];
    [self.AttentionBrand setBackgroundImage:pressattention forState:UIControlStateHighlighted];
    
    self.BannerScroll.layer.masksToBounds=YES;
    self.BannerScroll.layer.cornerRadius=5.0;
    self.BannerScroll.contentSize=CGSizeMake(5*300.,116.);
    for (int i=1; i<=5; i++) {
        UIImageView *imageview=[[[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"banner%d.png",i]]] autorelease];
        imageview.frame=CGRectMake((i-1)*300., 0., 300., 116.);
        [self.BannerScroll addSubview:imageview];
    }
    //广告自动滚动
    
   [NSTimer scheduledTimerWithTimeInterval:3. target:self selector:@selector(movebanner) userInfo:nil repeats:YES];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addbragevalue) name:@"additembragevalue" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearbrage) name:@"clearbragevalue" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deletebrage) name:@"deletebragevalue" object:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addbragevalue{
    n=[[[NSUserDefaults standardUserDefaults] objectForKey:@"cartnum"] intValue];
    [[self.tabBarController.tabBar.items objectAtIndex:2] setBadgeValue:[NSString stringWithFormat:@"%d",n]];
}
-(void)clearbrage{
    [[self.tabBarController.tabBar.items objectAtIndex:2] setBadgeValue:nil];

}
-(void)deletebrage{
    
    [[self.tabBarController.tabBar.items objectAtIndex:2] setBadgeValue:[NSString stringWithFormat:@"%d",[[[NSUserDefaults standardUserDefaults] objectForKey:@"cartnum"] intValue]]];

}
-(void)viewDidAppear:(BOOL)animated{
//    self.tabBarController.delegate=self;
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"CheckStatus"] isEqualToString:@"登录"]) {
        [self moveoutbutton];
        [self refresh:nil];
        [self addBounceAnimation2:self.UserRegister from:8];
        [self addBounceAnimation2:self.Usercart from:-8];
        [self addBounceAnimation2:self.AttentionBrand from:8];
    }else{
        [self addBounceAnimation2:self.UserRegister from:8];
    [self addBounceAnimation2:self.Usercart from:-8];
    [self addBounceAnimation2:self.AttentionBrand from:8];
        [self addBounceAnimation2:self.Create from:-8];
    }
}

#pragma mark - ibaction
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if ([self.tabBarController selectedIndex]!=2) {
        self.quitchat.hidden=YES;
        self.showkeyboard.hidden=YES;
    }else{
        self.quitchat.hidden=NO;
        self.showkeyboard.hidden=NO;
    }
}


- (void)pushAction:(id)sender
{
    SecondViewController *secondCon = [[[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil] autorelease];
    [self  presentViewController:secondCon animated:YES completion:nil];
}

- (void)dealloc {
    [_Register release];
    [_NewUser release];
    [_UserRegister release];
    [_Create release];
    [_toolBar release];
    [_BannerScroll release];
    [_pagecontrol release];
    [_Usercart release];
    [_nickname release];
    [_money release];

    [_Userimage release];
    [_Levelimge release];
    [_points release];
    [_Userbgimage release];
    [_shadowline release];
    [_chooseimage release];
    [_cutline release];
    [_moneylabel release];
    [_pointlabel release];
    [_cutimage release];
    [_AttentionBrand release];
    [super dealloc];
}
- (IBAction)GotoUserCart:(UIButton *)sender {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"CheckStatus"] isEqualToString:@"未登录"]) {
        XYAlertView *alertView = [XYAlertView alertViewWithTitle:@"抱歉！"
                                                         message:@"您还没有登录？"
                                                         buttons:[NSArray arrayWithObjects:@"立即登录", @"取消", nil]
                                                    afterDismiss:^(int buttonIndex) {
                                                        if (buttonIndex==0) {
                                                            UserRegisterViewController *user=[[[UserRegisterViewController alloc] init] autorelease];
                                                            user.delegate=self;
                                                            [self presentViewController:user animated:YES completion:nil];
                                                        }
                                                    }];
        
        [alertView setButtonStyle:XYButtonStyleGray atIndex:1];
        
        [alertView show];
        
    }else{        
        SecondViewController *pushview=[[[SecondViewController alloc] init] autorelease];        
        SecondNavigationViewController *nav=[[[SecondNavigationViewController alloc] initWithRootViewController:pushview] autorelease];
        [self presentViewController:nav animated:YES completion:nil];        
    }

}

- (IBAction)GetInToUserRegisterVC:(UIButton *)sender {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"CheckStatus"] isEqualToString:@"登录"]) {
        XYAlertView *alertView = [XYAlertView alertViewWithTitle:@"提示！"
                                                         message:@"想要退出登录吗？"
                                                         buttons:[NSArray arrayWithObjects:@"立即注销", @"取消", nil]
                                                    afterDismiss:^(int buttonIndex) {
                                                        if (buttonIndex==0) {
                                                            NSString *Status=@"未登录";
                                                            NSUserDefaults *status=[NSUserDefaults standardUserDefaults];
                                                            [status setObject:Status forKey:@"CheckStatus"];
                                                            UserRegisterViewController *user=[[UserRegisterViewController alloc] init];
                                                            user.delegate=self;
                                                            [self.chatView.udpSocket close];
                                                            self.FirstTime=YES;
                                                            [self moveinbutton];
                                                            [[NSNotificationCenter defaultCenter] postNotificationName:@"clearbragevalue" object:nil];

                                                        }else{
                                                            self.UserRegister.titleLabel.text=@"注销登录";
                                                        }
                                                    }];
        
        [alertView setButtonStyle:XYButtonStyleGray atIndex:1];
        
        [alertView show];
        
    }else{
    UserRegisterViewController *User=[[[UserRegisterViewController alloc] init] autorelease];
        User.delegate=self;
    [self presentViewController:User animated:YES completion:nil];
    }
}

- (IBAction)GetInToCreateNewUserVC:(UIButton *)sender {
    CreateNewUserViewController *CUser=[[[CreateNewUserViewController alloc] init] autorelease];
    [self presentViewController:CUser animated:YES completion:nil];
    
}

-(void)dorecharge{
    NSString *key=@"151600";
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"CheckStatus"] isEqualToString:@"未登录"]) {
        XYAlertView *alertView = [XYAlertView alertViewWithTitle:@"抱歉！"
                                                         message:@"您还没有登录？"
                                                         buttons:[NSArray arrayWithObjects:@"立即登录", @"取消", nil]
                                                    afterDismiss:^(int buttonIndex) {
                                                        if (buttonIndex==0) {
//                                                            [self GetInToUserRegisterVC:nil];
                                                            UserRegisterViewController *User=[[[UserRegisterViewController alloc] init] autorelease];
                                                            User.delegate=self;
                                                            [self presentViewController:User animated:YES completion:nil];
                                                        }
                                                    }];
        
        [alertView setButtonStyle:XYButtonStyleGray atIndex:1];
        
        [alertView show];
        
    }else{
        XYInputView *inputView2 = [XYInputView inputViewWithPlaceholder:@"请输入充值测试密码."
                                                           initialText:nil buttons:[NSArray arrayWithObjects:@"取消", @"确定", nil]
                                                          afterDismiss:^(int buttonIndex, NSString *text) {
                                                              if(buttonIndex == 1){
                                                                  if ([text isEqualToString:key]) {
                                                                      XYInputView *inputView = [XYInputView inputViewWithPlaceholder:@"请输入你要充值的金额。"
                                                                                                                         initialText:nil buttons:[NSArray arrayWithObjects:@"取消", @"测试",@"充值", nil]
                                                                                                                        afterDismiss:^(int buttonIndex, NSString *text) {
                                                                                                                            if(buttonIndex == 1){
                                                                                                                                if ([text intValue]>=0) {
                                                                                                                                    self.money=text;
                                                                                                                                    [self recharge];
                                                                                                                                    [self refresh:nil];
                                                                                                                                }else{
                                                                                                                                    XYAlertView *alertView = [XYAlertView alertViewWithTitle:@"抱歉！"
                                                                                                                                                                                     message:@"您的输入有误."
                                                                                                                                                                                     buttons:[NSArray arrayWithObjects:@"确认", nil]
                                                                                                                                                                                afterDismiss:^(int buttonIndex) {
                                                                                                                                                                                    
                                                                                                                                                                                }];
                                                                                                                                    
                                                                                                                                    [alertView setButtonStyle:XYButtonStyleGray atIndex:1];
                                                                                                                                    
                                                                                                                                    [alertView show];
                                                                                                                                }
                                                                                                                                
                                                                                                                            }else if (buttonIndex==2){
                                                                                                                                PayMentViewController *pay=[[[PayMentViewController alloc] init] autorelease];
                                                                                                                                pay.price=[NSString stringWithFormat:@"￥  %@",text];
                                                                                                                                [self presentViewController:pay animated:YES completion:nil];
                                                                                                                            }
                                                                                                                            }
                                                                                                                        ];
                                                                      [inputView setButtonStyle:XYButtonStyleGreen atIndex:1];
                                                                      [inputView show];
                                                                  }else{
                                                                      XYAlertView *alertView = [XYAlertView alertViewWithTitle:@"抱歉！"
                                                                                                                       message:@"密码错误."
                                                                                                                       buttons:[NSArray arrayWithObjects:@"确认", nil]
                                                                                                                  afterDismiss:^(int buttonIndex) {
                                                                                                                      
                                                                                                                  }];
                                                                      
                                                                      [alertView setButtonStyle:XYButtonStyleGray atIndex:1];
                                                                      
                                                                      [alertView show];
                                                                  }
                                                                  
                                                              }
                                                          }];
        [inputView2 setButtonStyle:XYButtonStyleGreen atIndex:1];
        [inputView2 show];
        //

        
    }

    
}

-(void)recharge{

    FMDatabase *urdb=[FMDatabase databaseWithPath:[self getdbpath]];
    if ([urdb open]) {
        FMResultSet *urresult=[urdb executeQuery:[NSString stringWithFormat:@"select * from CustomerData where CustomerID='%@'",[[NSUserDefaults standardUserDefaults] objectForKey:@"CustomerID"]]];
        if ([urresult next]) {
            NSString *money=[urresult stringForColumn:@"UserMoney"];

                
                NSString *updatemoney=[NSString stringWithFormat:@"%d",([money intValue]+[self.money intValue])];
                [urdb executeUpdate:[NSString stringWithFormat:@"UPDATE CustomerData SET UserMoney='%@' where CustomerID='%@'",updatemoney,[[NSUserDefaults standardUserDefaults] objectForKey:@"CustomerID"]]];
                XYAlertView *aler=[[XYAlertView alloc] initWithTitle:@"提示!" message:@"充值成功" buttons:[NSArray arrayWithObjects:@"确认", nil] afterDismiss:^(int buttonIndex) {
                    if (buttonIndex==0) {
                    }
                }];
                [aler show];
            [aler release];
        }[urresult close];
    }[urdb close];

}

- (IBAction)TDcode:(UIButton *)sender {

XYAlertView *aler=[XYAlertView alertViewWithTitle:@"提醒！" message:@"照相机和补光灯即将开启！" buttons:[NSArray arrayWithObjects:@"确定", @"取消", nil] afterDismiss:^(int buttonIndex) {
    if (buttonIndex==0) {
        TDScanViewController *td=[[[TDScanViewController alloc] init] autorelease];
        TDScanNavigationViewController *nav=[[[TDScanNavigationViewController alloc] initWithRootViewController:td] autorelease];
        td.title=@"二维码扫描";
        [self presentViewController:nav animated:YES completion:nil];//让Firstviewcontroller 和 TDScanNavigationViewcontroll进行模态切换。。。TDScanNavigationViewController里面的其他viewcontroller进行push pop切换

          }
    }];
    [aler setButtonStyle:XYButtonStyleGray atIndex:1];
    [aler show];
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    [def setObject:@"打开" forKey:@"Camera"];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_BannerScroll.contentOffset.x >0 &&_BannerScroll.contentOffset.x<=300) {
        _pagecontrol.currentPage=1;
    }else if (_BannerScroll.contentOffset.x >300 &&_BannerScroll.contentOffset.x<=600){
        _pagecontrol.currentPage=2;
    }else if (_BannerScroll.contentOffset.x >600 &&_BannerScroll.contentOffset.x<=900){
        _pagecontrol.currentPage=3;
    }else if (_BannerScroll.contentOffset.x >900 &&_BannerScroll.contentOffset.x<=1200){
        _pagecontrol.currentPage=4;
    }else if (_BannerScroll.contentOffset.x >1200 &&_BannerScroll.contentOffset.x<=1500){
        _pagecontrol.currentPage=5;
    }else if (_BannerScroll.contentOffset.x >=0){
        _pagecontrol.currentPage=0;
    }

}

-(void)movebanner{
    m=m+1;
    if (m>5) {
        m=0;
        m=m+1;
        [_BannerScroll setContentOffset:CGPointMake((m-1)*300, 0) animated:NO];
    }else{
        [_BannerScroll setContentOffset:CGPointMake((m-1)*300, 0) animated:YES];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (_BannerScroll.contentOffset.x > 1500) {
        [_BannerScroll setContentOffset:CGPointMake(0, 0) animated:YES];
    }

}

- (void)viewDidUnload {
    [self setUsercart:nil];
    [self setNickname:nil];
    [self setMoney:nil];
    [self setUserimage:nil];
    [self setLevelimge:nil];
    [self setPoints:nil];
    [self setUserbgimage:nil];
    [self setShadowline:nil];
    [self setChooseimage:nil];
    [self setCutline:nil];
    [self setMoneylabel:nil];
    [self setPointlabel:nil];
    [self setCutimage:nil];
    [self setAttentionBrand:nil];
    [super viewDidUnload];
}

- (IBAction)showRightSideBar:(UIButton *)sender {
    
    if ([[SidebarViewController share] respondsToSelector:@selector(showSideBarControllerWithDirection:)]) {
        [[SidebarViewController share] showSideBarControllerWithDirection:SideBarShowDirectionNone];
    }

}

- (IBAction)showLeftSidebar:(UIButton *)sender {

    if ([[SidebarViewController share] respondsToSelector:@selector(showSideBarControllerWithDirection:)]) {
        [[SidebarViewController share] showSideBarControllerWithDirection:SideBarShowDirectionLeft];
    }
        

}

-(NSString *)getdbpath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *sqlitePath = [documentDirectory stringByAppendingPathComponent:@"DataCache.sqlite"];
    return sqlitePath;
}

- (IBAction)docharge:(UIButton *)sender {
    [self dorecharge];
}

-(void)getimage:(NSString *)uuid{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
    NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",uuid]];
     NSData *data=[NSData dataWithContentsOfFile:uniquePath];
    if (data==nil) {
        self.Userimage.image=[UIImage imageNamed:@"tmcontact_blank"];
    }else{
    self.Userimage.image=[UIImage imageWithData:data];
    }
}
-(void)moveoutbutton{

    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0];//动画时间长度，单位秒，浮点数
self.Create.transform=CGAffineTransformMakeTranslation(304, 0);
    self.Create.frame=CGRectMake(320, 244, 304, 50);
    self.Create.alpha=0;
    self.nickname.alpha=1;
    self.usermoney.alpha=1;
    self.Userimage.alpha=1;
    self.Levelimge.alpha=1;
    self.points.alpha=1;
    self.Userbgimage.alpha=1;
    self.shadowline.alpha=1;
    self.chooseimage.hidden=NO;
    self.chooseimage.alpha=1;
    self.cutline.alpha=0.2;
    self.moneylabel.alpha=1;
    self.pointlabel.alpha=1;
    self.cutimage.alpha=1;
    if (self.Userimage.image!=[UIImage imageNamed:@"tmcontact_blank"]) {
    UIImage *image=self.Userimage.image;
        [self.Userbgimage setImageToBlur:image blurRadius:kLBBlurredImageDefaultBlurRadius completionBlock:nil];
    }else{
        [self.Userbgimage setImageToBlur:[UIImage imageNamed:@"bg_default"] blurRadius:kLBBlurredImageDefaultBlurRadius completionBlock:nil];
    }
    self.points.text=[NSString stringWithFormat:@"%@",self.passuserdata._UserPoints];
    self.nickname.text=[NSString stringWithFormat:@"%@",self.passuserdata._UserName];
    self.usermoney.text=[NSString stringWithFormat:@"¥%@",self.passuserdata._Money];
    
            self.Levelimge.frame=CGRectMake(230, 211, ([self.passuserdata._UserPoints intValue]/1000+1)*12, 12);
            self.Levelimge.image=[UIImage imageNamed:[NSString stringWithFormat:@"buyer-3-%d",[self.passuserdata._UserPoints intValue]/1000+1]];
    
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
    [self.UserRegister setTitle:@"注销登录" forState:UIControlStateNormal];
    [self.UserRegister setTitle:@"注销登录" forState:UIControlStateHighlighted];
    self.offline=NO;
}

-(void)moveinbutton{

    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];//动画时间长度，单位秒，浮点数
    self.Create.frame=CGRectMake(8, 244, 304, 50);
    self.Create.alpha=1;
    self.nickname.alpha=0;
    self.usermoney.alpha=0;
    self.Userimage.alpha=0;
    self.Levelimge.alpha=0;
    self.points.alpha=0;
    self.Userbgimage.alpha=0;
    self.shadowline.alpha=0;
    self.chooseimage.hidden=YES;
    self.chooseimage.alpha=0;
    self.cutline.alpha=0;
    self.moneylabel.alpha=0;
    self.pointlabel.alpha=0;
    self.cutimage.alpha=0;
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
    [self.UserRegister setTitle:@"用户登录" forState:UIControlStateNormal];
    [self.UserRegister setTitle:@"用户登录" forState:UIControlStateHighlighted];
    [self performSelector:@selector(addBounceAnimation:) withObject:self.Create afterDelay:0.5];
}
- (void) addBounceAnimation:(UIButton *)btn {
	
	SKBounceAnimation *bounceAnimation = [SKBounceAnimation animationWithKeyPath:@"position.x"];
	bounceAnimation.fromValue = [NSNumber numberWithFloat:btn.center.x-5];
	bounceAnimation.toValue = [NSNumber numberWithFloat:btn.center.x];
	bounceAnimation.duration = 1.2f;
	bounceAnimation.delegate = self;
	bounceAnimation.numberOfBounces = 10;
	bounceAnimation.shouldOvershoot = NO;
	bounceAnimation.removedOnCompletion = NO;
	bounceAnimation.fillMode = kCAFillModeForwards;
	[btn.layer addAnimation:bounceAnimation forKey:@"someKey"];
}
- (void) addBounceAnimation2:(UIButton *)btn from:(float)x{
	
	SKBounceAnimation *bounceAnimation = [SKBounceAnimation animationWithKeyPath:@"position.x"];
	bounceAnimation.fromValue = [NSNumber numberWithFloat:btn.center.x-x];
	bounceAnimation.toValue = [NSNumber numberWithFloat:btn.center.x];
	bounceAnimation.duration = 1.2f;
	bounceAnimation.delegate = self;
	bounceAnimation.numberOfBounces = 10;
	bounceAnimation.shouldOvershoot = NO;
	bounceAnimation.removedOnCompletion = NO;
	bounceAnimation.fillMode = kCAFillModeForwards;
	[btn.layer addAnimation:bounceAnimation forKey:@"someKey"];
}

-(void)CreataChatView{
    if (self.FirstTime) {
    ChatViewController *chat=[[ChatViewController alloc] initWithNibName:@"ChatViewController" bundle:nil];
    self.chatView=chat;
    self.chatView.view.frame=CGRectMake(0, 1136, 320, 1136);
        [chat release];
    [self.view addSubview:self.chatView.view];
    [self.view addSubview:self.quitchat];
    [self.view addSubview:self.showkeyboard];
    [self.view bringSubviewToFront:self.chatView.view];
    [self.view bringSubviewToFront:self.quitchat];
    [self.view bringSubviewToFront:self.showkeyboard];
        self.FirstTime=NO;
    }
    [self moveintchatview];
    
}
-(void)moveintchatview{

    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.6];//动画时间长度，单位秒，浮点数
    self.chatView.view.frame=CGRectMake(0, 44, 320, 1136);
    self.quitchat.hidden=NO;
    self.showkeyboard.hidden=NO;
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
}
-(void)moveoutchatview{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.6];//动画时间长度，单位秒，浮点数
    self.chatView.view.frame=CGRectMake(0, 1136, 320, 1136);
    self.quitchat.hidden=YES;
    self.showkeyboard.hidden=YES;
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
    [self.chatView.messageTextField resignFirstResponder];
}
-(BOOL)canBecomeFirstResponder{
    return YES;
}
-(void)movekeyboard{
    [self.chatView.messageTextField becomeFirstResponder];
}
- (void)refresh:(UIButton *)sender {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *sqlitePath = [documentDirectory stringByAppendingPathComponent:@"DataCache.sqlite"];
    NSLog(@"%@",sqlitePath);
    
    FMDatabase *urdb=[FMDatabase databaseWithPath:sqlitePath];
    if ([urdb open]) {
        FMResultSet *urresult=[urdb executeQuery:[NSString stringWithFormat:@"select * from CustomerData where CustomerID='%@'",[[NSUserDefaults standardUserDefaults] objectForKey:@"CustomerID"]]];
        if ([urresult next]) {
            
            NSString *money=[urresult stringForColumn:@"UserMoney"];
            NSString *point=[urresult stringForColumn:@"TotalPoint"];
            
            self.Levelimge.frame=CGRectMake(230, 211, ([point intValue]/1000+1)*12, 12);
            self.Levelimge.image=[UIImage imageNamed:[NSString stringWithFormat:@"buyer-3-%d",[point intValue]/1000+1]];
            
            self.usermoney.text=[NSString stringWithFormat:@"%@",money];
            self.points.text=[NSString stringWithFormat:@"%@",[urresult stringForColumn:@"TotalPoint"]];
        }[urresult close];
    }[urdb close];
}
-(void)getuserdata:(UserClass *)userdata{
    self.passuserdata=userdata;
}
- (IBAction)Getimage:(UIButton *)sender {
    
    [self passviewcontroller];
    [self.takeController takePhotoOrChooseFromLibrary];
}
-(void)passviewcontroller{
    [self.takeController getviewcontroller:self];
}
- (void)takeController:(FDTakeController *)controller didCancelAfterAttempting:(BOOL)madeAttempt
{
    XYAlertView *alertView = [XYAlertView alertViewWithTitle:@"注意!"
                                                     message:@"已经取消选择。"
                                                     buttons:[NSArray arrayWithObjects:@"确定", nil]
                                                afterDismiss:^(int buttonIndex) {
                                                    
                                                }];
    
    
    [alertView setButtonStyle:XYButtonStyleGray atIndex:1];
    [alertView show];
}

- (void)takeController:(FDTakeController *)controller gotPhoto:(UIImage *)photo withInfo:(NSDictionary *)info
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
    NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",self.self.passuserdata._UserID]];
    [UIImagePNGRepresentation(photo)writeToFile: uniquePath    atomically:YES];
    [self.Userimage setImage:photo];
}

- (NSString *)createUUID//UUID生成....
{
    CFUUIDRef uuidObject = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuidStr = (NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuidObject);
    CFRelease(uuidObject);
    return [uuidStr autorelease];
}

- (IBAction)chatonline:(UIButton *)sender {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"CheckStatus"] isEqualToString:@"未登录"]) {
        XYAlertView *alertView = [XYAlertView alertViewWithTitle:@"抱歉！"
                                                         message:@"您还没有登录？"
                                                         buttons:[NSArray arrayWithObjects:@"立即登录", @"取消", nil]
                                                    afterDismiss:^(int buttonIndex) {
                                                        if (buttonIndex==0) {
                                                            //                                                            [self GetInToUserRegisterVC:nil];
                                                            UserRegisterViewController *User=[[[UserRegisterViewController alloc] init] autorelease];
                                                            User.delegate=self;
                                                            [self presentViewController:User animated:YES completion:nil];
                                                        }
                                                    }];
        
        [alertView setButtonStyle:XYButtonStyleGray atIndex:1];
        
        [alertView show];
        
    }else{
        [self CreataChatView];
//    ChatViewController *chat=[[ChatViewController alloc] initWithNibName:@"ChatViewController" bundle:nil];
//    [self presentViewController:chat animated:YES completion:nil];
    }
//    [self showRightSideBar:nil];
}
- (IBAction)GotoAttentionBrand:(UIButton *)sender {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"CheckStatus"] isEqualToString:@"未登录"]) {
        XYAlertView *alertView = [XYAlertView alertViewWithTitle:@"提示！"
                                                         message:@"您还没有登录？"
                                                         buttons:[NSArray arrayWithObjects:@"先登录", @"先看看", nil]
                                                    afterDismiss:^(int buttonIndex) {
                                                        if (buttonIndex==1) {
                                                            AttentionViewController *attention=[[[AttentionViewController alloc] init] autorelease];
                                                            attention.isonline=NO;
                                                            [self presentViewController:attention animated:YES completion:nil];
                                                        }else{
                                                            UserRegisterViewController *User=[[[UserRegisterViewController alloc] init] autorelease];
                                                            User.delegate=self;
                                                            [self presentViewController:User animated:YES completion:nil];
                                                        }
                                                    }];
        
        [alertView setButtonStyle:XYButtonStyleGray atIndex:1];
        
        [alertView show];
    }else{
        AttentionViewController *attention=[[[AttentionViewController alloc] init] autorelease];
        attention.isonline=YES;
        [self presentViewController:attention animated:YES completion:nil];
    }

}


@end
