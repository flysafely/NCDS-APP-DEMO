//
//  AppDelegate.m
//  NCDS-SJGO
//
//  Created by 徐子迈 on 12-12-28.
//  Copyright (c) 2012年 XcodeTest. All rights reserved.
//

#import "AppDelegate.h"
#import "SidebarViewController.h"
#import "LaunchViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MCSoundBoard.h"
#import "XYAlertView.h"
@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
//SidebarViewController *side = [[SidebarViewController alloc] initWithNibName:@"SidebarViewController" bundle:nil];
    
    [self.window makeKeyAndVisible];
    
//    UIStoryboard *stryBoard=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
//    self.window.rootViewController=[stryBoard instantiateInitialViewController];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstload"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstload"];
    
    LaunchViewController *loginViewController=[[[LaunchViewController alloc] initWithNibName:@"LaunchViewController" bundle:nil] autorelease];
    
    self.window.rootViewController=loginViewController;//[stryBoard instantiateInitialViewController];
    }else{
         UIStoryboard *stryBoard=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        
        self.window.rootViewController=[stryBoard instantiateInitialViewController];
        fView =[[UIImageView alloc]initWithFrame:self.window.frame];//初始化fView
        fView.image=[UIImage imageNamed:@"Default-568h@2x.png"];//图片f.png 到fView
        
        zView=[[UIImageView alloc]initWithFrame:self.window.frame];//初始化zView
        zView.image=[UIImage imageNamed:@"Default-568h@2x.png"];//图片z.png 到zView
        
        rView=[[UIView alloc]initWithFrame:self.window.frame];//初始化rView
        
        [rView addSubview:fView];//add 到rView
        [rView addSubview:zView];//add 到rView
        
        [self.window addSubview:rView];//add 到window
        
        [self performSelector:@selector(ToUpSide) withObject:nil afterDelay:1];


         //可以切换
    }
    NSUserDefaults *key=[NSUserDefaults standardUserDefaults];
    [key setObject:@"未登录" forKey:@"CheckStatus"];
    [key removeObjectForKey:@"CustomerID"];
    [key setValue:@"正常" forKey:@"groupby"];
    [key setObject:@"" forKey:@"FromVirORCata"];
    [key setObject:@"" forKey:@"passproductid"];
    [key setObject:@"" forKey:@"FromVirORCata"];
    [key setObject:@"" forKey:@"PassAddress"];
    [key setObject:@"1" forKey:@"floor"];
    [key setObject:@"" forKey:@"from"];
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"DataCache.sqlite"];
    NSFileManager *copysqlite=[NSFileManager defaultManager];
    [copysqlite copyItemAtPath:[[NSBundle mainBundle] pathForResource:@"DataCache" ofType:@"sqlite"] toPath:dbPath error:nil];
    //下面代码是实现navigationbar背景图片的切换...
//    UIImage *toolBarIMG = [UIImage imageNamed: @"CustomerToolbarbg.png"];
//    toolBarIMG=[toolBarIMG resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
//  [[UINavigationBar appearance] setBackgroundImage:toolBarIMG forBarMetrics:UIBarMetricsDefault];
    
//    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"urbg.png"] forBarMetrics:UIBarMetricsDefault];
   
    //一下是带测试的代码....
//    fView =[[UIImageView alloc]initWithFrame:self.window.frame];//初始化fView
//    fView.image=[UIImage imageNamed:@"Default-568h@2x.png"];//图片f.png 到fView
//    
//    zView=[[UIImageView alloc]initWithFrame:self.window.frame];//初始化zView
//    zView.image=[UIImage imageNamed:@"Default-568h@2x.png"];//图片z.png 到zView
//    
//    rView=[[UIView alloc]initWithFrame:self.window.frame];//初始化rView
//    
//    [rView addSubview:fView];//add 到rView
//    [rView addSubview:zView];//add 到rView
//    
//    [self.window addSubview:rView];//add 到window
//    
//    [self performSelector:@selector(ToUpSide) withObject:nil afterDelay:1];//可以切换
    return YES;
}

- (void)TheAnimation{
    
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.7 ;  // 动画持续时间(秒)
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionFade;//淡入淡出效果
    
    NSUInteger f = [[rView subviews] indexOfObject:fView];
    NSUInteger z = [[rView subviews] indexOfObject:zView];
    [rView exchangeSubviewAtIndex:z withSubviewAtIndex:f];
    
    [[rView layer] addAnimation:animation forKey:@"animation"];
    
    [self performSelector:@selector(ToUpSide) withObject:nil afterDelay:2];//2秒后执行TheAnimation
}

#pragma mark - 上升效果
- (void)ToUpSide {
    
    [self moveToUpSide];//向上拉界面
    
}

- (void)moveToUpSide {
    [UIView animateWithDuration:0.7 //速度0.7秒
                     animations:^{//修改rView坐标
                         rView.frame = CGRectMake(self.window.frame.origin.x,
                                                  -self.window.frame.size.height,
                                                  self.window.frame.size.width,
                                                  self.window.frame.size.height);
                     }
                     completion:^(BOOL finished){
                     }];
    [MCSoundBoard playSoundForKey:@"virmusic"];
}





- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
