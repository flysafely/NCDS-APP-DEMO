//
//  VirtualMallNavigationViewController.m
//  NCDS-SJGO
//
//  Created by 徐子迈 on 13-1-4.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import "VirtualMallNavigationViewController.h"

@interface VirtualMallNavigationViewController ()

@end

@implementation VirtualMallNavigationViewController
@synthesize navigationbar=_navigationbar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"精选类目";
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIImage *toolBarIMG = [UIImage imageNamed: @"navbar-first"];
    toolBarIMG=[toolBarIMG resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [self.navigationbar setBackgroundImage:toolBarIMG forBarMetrics:0];
    self.view.backgroundColor=[UIColor blackColor];
    [self.navigationBar dropShadowWithOffset:CGSizeMake(0, 0) radius:5 color:[UIColor blackColor] opacity:0.7];//uinavgationbar catagroy重写阴影函数！

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    [_navigationbar release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setNavigationbar:nil];
    [super viewDidUnload];
}
@end
