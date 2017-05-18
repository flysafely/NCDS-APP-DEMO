//
//  VirtualMallViewController.m
//  NCDS-SJGO
//
//  Created by 徐子迈 on 12-12-28.
//  Copyright (c) 2012年 XcodeTest. All rights reserved.
//

#import "VirtualMallViewController.h"
#import "TSActionSheet.h"
#import <QuartzCore/CALayer.h>
#import "UIToolbar+uitoolbarshadow.h"
#import "VirtualMallSubView2Controller.h"
#import "SubType2ViewController.h"
#import "FMDatabase.h"
#import "XYAlertView.h"
#import "MCSoundBoard.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <netdb.h>

@interface VirtualMallViewController ()
@property BOOL istop;
@end

@implementation VirtualMallViewController
@synthesize toolbar=_toolbar;
@synthesize a=_a;
@synthesize item=_item;
@synthesize btn=_btn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (![self checkNetWorkIsOk]) {//注意  模拟器上不能识别 wifi是否打开...
                XYAlertView *alertView = [XYAlertView alertViewWithTitle:@"请检查你的互联网连接"
                                                         message:@"您的设备还没有连入互联网！"
                                                         buttons:[NSArray arrayWithObjects:@"离线运行", nil]
                                                    afterDismiss:^(int buttonIndex) {
                                                        if (buttonIndex==0) {
                                                            
                                                            
                                                        }
                                                    }];
        
        [alertView setButtonStyle:XYButtonStyleGray atIndex:1];
        
        [alertView show];
        
    }
    _istop=YES;
    //声音加载
    self.tabBarController.delegate=self;
    [self AddSound];
    
    UIImage *toolBarIMG = [UIImage imageNamed: @"bg_red_top1"];
    toolBarIMG=[toolBarIMG resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    if ([self.toolbar respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)]) {
        [self.toolbar setBackgroundImage:toolBarIMG forToolbarPosition:0 barMetrics:0];
    }//设置toolbar的背景图片

    [self.toolbar dropShadowWithOffset:CGSizeMake(0, 0) radius:5.0 color:[UIColor blackColor] opacity:0];//重写toolebar 阴影绘制函数！！FirstViewcontroller中由于其toolbar本来就放置再最前面 即使不用重写的方法 也能直接shadowoffset 设置
    [self.a setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.a.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg03"]];
    NSUserDefaults *floor=[NSUserDefaults standardUserDefaults];
    [floor setObject:@"1" forKey:@"floor"];
    self.btn.hidden=NO;
    
    UIButton *Timebtn=[UIButton buttonWithType:UIButtonTypeCustom];
    Timebtn.backgroundColor=[UIColor clearColor];
    Timebtn.frame=CGRectMake(50, 0, 220, 20);
    [Timebtn addTarget:self action:@selector(GetTime) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBarController.view addSubview:Timebtn];
    [self.tabBarController.view bringSubviewToFront:Timebtn];
   [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(addanimation) userInfo:nil repeats:YES];
    
    [self Tabaddcat];
//加载数据
    [self loadData];
}
-(void)addanimation{
    if (!_menu.isOpen) {
      
    [self addBounceAnimation2:self.btn from:6];
    }
}
-(void)removeanimation{
    [self.btn.layer removeAnimationForKey:@"someKey"];
}
- (void) addBounceAnimation2:(UIButton *)btn from:(float)x{
	
	SKBounceAnimation *bounceAnimation = [SKBounceAnimation animationWithKeyPath:@"position.y"];
	bounceAnimation.fromValue = [NSNumber numberWithFloat:btn.center.y-x];
	bounceAnimation.toValue = [NSNumber numberWithFloat:btn.center.y];
	bounceAnimation.duration = 2.0f;
	bounceAnimation.delegate = self;
	bounceAnimation.numberOfBounces = 10;
	bounceAnimation.shouldOvershoot = YES;
	bounceAnimation.removedOnCompletion = NO;
	bounceAnimation.fillMode = kCAFillModeForwards;
	[btn.layer addAnimation:bounceAnimation forKey:@"someKey"];
    
}
-(void)AddSound{
    [MCSoundBoard addSoundAtPath:[[NSBundle mainBundle] pathForResource:@"DownloadComplete.aif" ofType:nil] forKey:@"virmusic"];
    [MCSoundBoard addSoundAtPath:[[NSBundle mainBundle] pathForResource:@"Top_tabs.aif" ofType:nil] forKey:@"topclick"];
    [MCSoundBoard addSoundAtPath:[[NSBundle mainBundle] pathForResource:@"Basket+2.aif" ofType:nil] forKey:@"deleteclick"];
    [MCSoundBoard addSoundAtPath:[[NSBundle mainBundle] pathForResource:@"DoneClear.aif" ofType:nil] forKey:@"checkout"];
    [MCSoundBoard addSoundAtPath:[[NSBundle mainBundle] pathForResource:@"Buy_ShopBell.aif" ofType:nil] forKey:@"addtouserchart"];
    [MCSoundBoard addSoundAtPath:[[NSBundle mainBundle] pathForResource:@"DeleteSingleItem.aif" ofType:nil] forKey:@"pickerup"];
    [MCSoundBoard addSoundAtPath:[[NSBundle mainBundle] pathForResource:@"pull_refresh.aif" ofType:nil] forKey:@"socialplus"];
    [MCSoundBoard addSoundAtPath:[[NSBundle mainBundle] pathForResource:@"r.aif" ofType:nil] forKey:@"socialitem"];
    [MCSoundBoard addSoundAtPath:[[NSBundle mainBundle] pathForResource:@"weico_newmessage.wav" ofType:nil] forKey:@"message"];
    [MCSoundBoard addSoundAtPath:[[NSBundle mainBundle] pathForResource:@"Favorite1.aif" ofType:nil] forKey:@"favorite"];
    [MCSoundBoard addSoundAtPath:[[NSBundle mainBundle] pathForResource:@"Awards1.aif" ofType:nil] forKey:@"Awards"];
    [MCSoundBoard addSoundAtPath:[[NSBundle mainBundle] pathForResource:@"shopBell.aif" ofType:nil] forKey:@"attention"];
}

- (BOOL) checkNetWorkIsOk{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags) {
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    // = flags & kSCNetworkReachabilityFlagsIsWWAN;
    BOOL nonWifi = flags & kSCNetworkReachabilityFlagsTransientConnection;
    BOOL moveNet = flags & kSCNetworkReachabilityFlagsIsWWAN;
    return ((isReachable && !needsConnection) || nonWifi || moveNet) ? YES : NO;
}
-(void)GetTime{
    NSDate * newDate = [NSDate date];
    
    NSDateFormatter *dateformat=[[[NSDateFormatter alloc] init] autorelease];
    
    [dateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString * newDateOne =[NSString stringWithFormat:@"现在时间:%@",[dateformat stringFromDate:newDate]];
    
    [dateformat setFormatterBehavior:NSDateFormatterFullStyle];
    
    [dateformat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    XYAlertView *aler=[[XYAlertView alloc] initWithTitle:@"世纪购提示您" message:newDateOne buttons:[NSArray       arrayWithObjects:@"确定",nil] afterDismiss:^(int buttonIndex){
    }];
    [aler show];
    [aler release];
    
}
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    [MCSoundBoard playSoundForKey:@"topclick"];

}

-(UIImageView *)AddCatImages{
    //小猫动画
    UIImageView *catimageview=[[UIImageView alloc] initWithFrame:CGRectMake(251, 496, 61, 21)];
    UIImage *cat1=[UIImage imageNamed:@"cat_01.png"];
    UIImage *cat2=[UIImage imageNamed:@"cat_02.png"];
    UIImage *cat3=[UIImage imageNamed:@"cat_03.png"];
    UIImage *cat4=[UIImage imageNamed:@"cat_02.png"];
    UIImage *cat5=[UIImage imageNamed:@"cat_01.png"];
    UIImage *cat6=[UIImage imageNamed:@"cat_02.png"];
    UIImage *cat7=[UIImage imageNamed:@"cat_03.png"];
    UIImage *cat8=[UIImage imageNamed:@"cat_02.png"];
    UIImage *cat9=[UIImage imageNamed:@"cat_01.png"];
    UIImage *cat10=[UIImage imageNamed:@"cat_01.png"];
    NSMutableArray *images=[[NSMutableArray alloc] initWithObjects:cat1,cat2,cat3,cat4,cat5,cat6,cat7,cat8,cat9, nil];
    for (int i=0; i<25; i++) {
        
        [images addObject:cat10];
    }
    [catimageview.animationImages arrayByAddingObjectsFromArray:images];
    catimageview.animationImages=images;
    catimageview.animationDuration=2.5;
    [catimageview startAnimating];
    return catimageview;
}

-(UIButton *)AddSearchPicture{
    UIButton *searchbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    searchbtn.frame=CGRectMake(247, 517, 69, 48);
    [searchbtn setBackgroundImage:[UIImage imageNamed:@"tmall_logo_menu_search_nor"] forState:UIControlStateNormal];
    [searchbtn setBackgroundImage:[UIImage imageNamed:@"tmall_logo_menu_search_nor"] forState:UIControlStateHighlighted];
    [searchbtn addTarget:self action:@selector(changetabitem) forControlEvents:UIControlEventTouchUpInside];
    return searchbtn;
}

-(UIButton *)AddPulldown{
    UIButton *pull=[UIButton buttonWithType:UIButtonTypeCustom];
    pull.frame=CGRectMake(7, -3, 42, 55);
    pull.tag=100;
    [pull setBackgroundImage:[UIImage imageNamed:@"contacts_infobar_btn_1"] forState:UIControlStateNormal];
    [pull addTarget:self action:@selector(pop:forEvent:) forControlEvents:UIControlEventTouchUpInside];
    return pull;
}

-(void)Tabaddcat{
    self.btn=[self AddPulldown];
    [self.tabBarController.view addSubview:[self AddSearchPicture]];
    [self.tabBarController.view addSubview:[self AddCatImages]];
    [self.view addSubview:self.btn];
//    [self.tabBarController.view addSubview:self.btn];
    [self.tabBarController.view bringSubviewToFront:[self AddCatImages]];
    [self.tabBarController.view bringSubviewToFront:[self AddSearchPicture]];
    [self.view bringSubviewToFront:self.btn];
//    [self.tabBarController.view bringSubviewToFront:self.btn];
    
}
-(void)changetabitem{
//    self.btn.hidden=YES;
    [self.tabBarController setSelectedIndex:3];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [_menu close];
    
}

-(void)loadData{
    _item=[[NSMutableArray alloc] init];
    FMDatabase *db=[FMDatabase databaseWithPath:[[NSBundle mainBundle] pathForResource:@"SJGOData" ofType:@"sqlite"]];
    if ([db open]) {
        FMResultSet *dbresult=[db executeQuery:[NSString stringWithFormat:@"SELECT * FROM ProductPopularize WHERE ProductFloor='%@'",[[NSUserDefaults standardUserDefaults] objectForKey:@"floor"]]];
        while ([dbresult next]) {
            NSMutableDictionary *dic=[NSMutableDictionary dictionary];
            
            NSString *ProductADID=[NSString stringWithFormat:@"%@",[dbresult stringForColumn:@"ProductADID"]];
            [dic setObject:ProductADID forKey:@"ProductADID"];
            [dic setObject:[dbresult stringForColumn:@"ProductImageID"] forKey:@"ProductImageID"];
            [dic setObject:[dbresult stringForColumn:@"ProductFloor"] forKey:@"ProductFloor"];
            [dic setObject:[dbresult stringForColumn:@"ProductADName"] forKey:@"ProductADName"];
            [dic setObject:[dbresult stringForColumn:@"ProductADDetail"] forKey:@"ProductADDetail"];
            [dic setObject:[dbresult stringForColumn:@"ProductQuantity"] forKey:@"ProductQuantity"];
            [_item addObject:dic];
            
        }[dbresult close];
    }[db close];
    if ([_item count]==0) {
        self.a.hidden=YES;
    }else{
        self.a.hidden=NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showMenu
{
    if (_menu.isOpen)
        return [_menu close];
    //
    
    REMenuItem *floor1 = [[[REMenuItem alloc] initWithTitle:@"化妆品"
                                                    subtitle:@"各大品牌化妆品专栏"
                                                       image:[UIImage imageNamed:@"tmall_icon_radio_perfume"]
                                            highlightedImage:nil
                                                      action:^(REMenuItem *item) {
                                                                  NSUserDefaults *floor=[NSUserDefaults standardUserDefaults];
                                                                  [floor setObject:@"1" forKey:@"floor"];
                                                                 [self loadData];
                                                          [self.a reloadData];

                                                      }] autorelease];
    
    REMenuItem *floor2 = [[[REMenuItem alloc] initWithTitle:@"女装"
                                                       subtitle:@"精品女装专栏"
                                                          image:[UIImage imageNamed:@"tmall_icon_radio_women"]
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             NSUserDefaults *floor=[NSUserDefaults standardUserDefaults];
                                                             [floor setObject:@"2" forKey:@"floor"];
                                                             [self loadData];
                                                             [self.a reloadData];

                                                         }] autorelease];
    
    REMenuItem *floor3 = [[[REMenuItem alloc] initWithTitle:@"男装"
                                                        subtitle:@"精品男装专栏"
                                                           image:[UIImage imageNamed:@"tmall_icon_radio_man"]
                                                highlightedImage:nil
                                                          action:^(REMenuItem *item) {
                                                              NSUserDefaults *floor=[NSUserDefaults standardUserDefaults];
                                                              [floor setObject:@"3" forKey:@"floor"];
                                                              [self loadData];
                                                              [self.a reloadData];

                                                          }] autorelease];
    
    REMenuItem *floor4 = [[[REMenuItem alloc] initWithTitle:@"家居用品"
                                                          image:[UIImage imageNamed:@"tmall_icon_radio_home"]
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             NSUserDefaults *floor=[NSUserDefaults standardUserDefaults];
                                                             [floor setObject:@"4" forKey:@"floor"];
                                                             [self loadData];
                                                             [self.a reloadData];

                                                         }] autorelease];
    REMenuItem *floor5 = [[[REMenuItem alloc] initWithTitle:@"运动品牌"
                                                          image:[UIImage imageNamed:@"tmall_icon_radio_sports"]
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             NSUserDefaults *floor=[NSUserDefaults standardUserDefaults];
                                                             [floor setObject:@"5" forKey:@"floor"];
                                                             [self loadData];
                                                             [self.a reloadData];

                                                         }] autorelease];
    REMenuItem *floor6 = [[[REMenuItem alloc] initWithTitle:@"取消"
                                                     image:nil
                                          highlightedImage:nil
                                                    action:^(REMenuItem *item) {

                                                    }] autorelease];

    floor1.tag = 0;
    floor2.tag = 1;
    floor3.tag = 2;
    floor4.tag = 3;
    floor5.tag = 4;
    floor6.tag = 5;
    
    _menu = [[REMenu alloc] initWithItems:@[floor1, floor2, floor3, floor4 , floor5 , floor6]];
    _menu.cornerRadius = 7;
    _menu.shadowColor = [UIColor blackColor];
    _menu.shadowOffset = CGSizeMake(0, 1);
    _menu.shadowOpacity = 1;
    _menu.imageOffset = CGSizeMake(5, -1);
    _menu.delegate=self;
    [_menu showFromNavigationController:self.navigationController];
}
-(void)movepull1{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //动画时间长度，单位秒，浮点数
    
        [UIView setAnimationDuration:0.3];
        self.btn.frame=CGRectMake(7, 298, 42, 55);
        [self.btn setBackgroundImage:[UIImage imageNamed:@"contacts_infobar_btn_1"] forState:UIControlStateNormal];
        [self.btn setUserInteractionEnabled:NO];
        
       [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
    [self.btn.layer removeAnimationForKey:@"someKey"];
    
}
-(void)movepull2{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //动画时间长度，单位秒，浮点数
    [UIView setAnimationDuration:0.2];
    self.btn.frame=CGRectMake(7, 323, 42, 55);
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
    [self performSelector:@selector(movepull3) withObject:nil afterDelay:0.2];

}
-(void)movepull3{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //动画时间长度，单位秒，浮点数
    [UIView setAnimationDuration:0.35];
    self.btn.frame=CGRectMake(7, -3, 42, 55);
    [self.btn setBackgroundImage:[UIImage imageNamed:@"contacts_infobar_btn_1"] forState:UIControlStateNormal];
    [self.btn setUserInteractionEnabled:YES];
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
    [self performSelector:@selector(removeanimation) withObject:nil afterDelay:0.4];
}
- (IBAction)pop:(id)sender forEvent:(UIEvent*)event
{
    if (_istop) {
        [self movepull1];
    }
        [self showMenu];
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 267.f;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [_item count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"VirtualMallCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if(!cell){
        cell=[[[NSBundle mainBundle] loadNibNamed:@"VirtualMallCell" owner:nil options:nil]lastObject];
        
    }

        UIImageView *Image=(UIImageView *)[cell viewWithTag:1];
        Image.image=[UIImage imageNamed:[[_item objectAtIndex:indexPath.row] objectForKey:@"ProductImageID"]];
        [(UILabel *)[cell viewWithTag:2] setText:[NSString stringWithFormat:@"  %@",[[_item objectAtIndex:indexPath.row] objectForKey:@"ProductADName"]]];
        [(UITextView *)[cell viewWithTag:3] setText:[[_item objectAtIndex:indexPath.row] objectForKey:@"ProductADDetail"]];
        [(UITextView *)[cell viewWithTag:3] setTextColor:[UIColor whiteColor] ];
        [(UILabel *)[cell viewWithTag:4] setText:[[_item objectAtIndex:indexPath.row] objectForKey:@"ProductQuantity"]];
        cell.contentView.backgroundColor=[UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectedBackgroundView.backgroundColor=[UIColor clearColor];

    if (indexPath.row==6) {
        NSLog(@"*************%@",@"这是第7行");
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    [def setObject:[[_item objectAtIndex:indexPath.row] objectForKey:@"ProductADID"] forKey:@"ProductADID"];
    [def setObject:@"Vir" forKey:@"FromVirORCata"];
    
    SubType2ViewController *sub=[[[SubType2ViewController alloc] init] autorelease];
    sub.title=[[_item objectAtIndex:indexPath.row] objectForKey:@"ProductADName"];
//    sub.delegate=self;
    [self.navigationController pushViewController:sub animated:YES];
//    self.btn.hidden=YES;
}
-(void)hiddebar{
//    self.btn.hidden=NO;
}

- (void)dealloc {
    [_toolbar release];
    [_a release];
    [MCSoundBoard release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setToolbar:nil];
    [self setA:nil];
    [super viewDidUnload];
}

@end
