//
//  HomeViewController.m
//  NCDS-SJGO
//
//  Created by 徐子迈 on 12-12-28.
//  Copyright (c) 2012年 XcodeTest. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

@synthesize TabBar=_TabBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
 
        
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"当前文件为HomeViewController************");
    [super viewDidLoad];
    [_TabBar setShadowImage:nil];
    [_TabBar setBackgroundImage:[UIImage imageNamed:@"tabbar_background"]];
    UIImage *imagebg=[UIImage imageNamed:@"TabSelected"];
    imagebg=[imagebg resizableImageWithCapInsets:UIEdgeInsetsMake(15, 10,15, 10)];
    _TabBar.selectionIndicatorImage=imagebg;
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    UIViewController *vcSelected = tabBarController.selectedViewController;

    if ([vcSelected isEqual:viewController]) {
        return NO;
    }

    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [_TabBar release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTabBar:nil];
    [super viewDidUnload];
}
@end
