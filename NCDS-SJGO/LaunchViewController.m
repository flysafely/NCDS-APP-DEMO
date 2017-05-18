//
//  LaunchViewController.m
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import "LaunchViewController.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <netdb.h>
#import "XYAlertView.h"
#import "MCSoundBoard.h"
@interface LaunchViewController ()

@end

@implementation LaunchViewController
@synthesize scrollview=_scrollview;

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
    [MCSoundBoard addSoundAtPath:[[NSBundle mainBundle] pathForResource:@"DownloadComplete.aif" ofType:nil] forKey:@"virmusic"];
    // Do any additional setup after loading the view from its nib.
    self.scrollview.contentSize=CGSizeMake(2*320.,568.);
    for (int i=1; i<=2; i++) {
        UIImageView *imageview=[[[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"featureOne%d.png",i]]] autorelease];
        imageview.frame=CGRectMake((i-1)*320., 0., 320., 568.);
        [self.scrollview addSubview:imageview];
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(405., 480., 150, 40)];
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn setTitle:@"" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(getinside)  forControlEvents:UIControlEventTouchUpInside];
        [self.scrollview addSubview:btn];
        [self.scrollview bringSubviewToFront:btn];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getinside{
    if ([self checkNetWorkIsOk]) {//注意  模拟器上不能识别 wifi是否打开...
UIStoryboard *stryBoard=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        self.view.window.rootViewController=[stryBoard instantiateInitialViewController];
//        NSUserDefaults *key=[NSUserDefaults standardUserDefaults];
//        [key setObject:@"1" forKey:@"ifload"];
    }else{
        XYAlertView *alertView = [XYAlertView alertViewWithTitle:@"请检查你的互联网连接"
                                                         message:@"您的设备还没有连入互联网！"
                                                         buttons:[NSArray arrayWithObjects:@"离线运行", nil]
                                                    afterDismiss:^(int buttonIndex) {
                                                        if (buttonIndex==0) {
                                                            UIStoryboard *stryBoard=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
                                                            self.view.window.rootViewController=[stryBoard instantiateInitialViewController];
                                                            
                                                        }
                                                    }];
        
        [alertView setButtonStyle:XYButtonStyleGray atIndex:1];
        
        [alertView show];

    }
      [MCSoundBoard playSoundForKey:@"virmusic"];  
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

- (void)dealloc {
    [_scrollview release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setScrollview:nil];
    [super viewDidUnload];
}
@end
