//
//  CateNavigationViewController.m
//  NCDS-SJGO
//
//  Created by 徐子迈 on 12-12-28.
//  Copyright (c) 2012年 XcodeTest. All rights reserved.
//

#import "CateNavigationViewController.h"
#import <QuartzCore/CALayer.h>
#import "UINavigationBar+CateNavigationBar.h"

@interface CateNavigationViewController ()

@end

@implementation CateNavigationViewController
@synthesize navigationbar=_navigationbar;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Show" style:UIBarButtonItemStylePlain
//                                                                                 target:self action:@selector(refreshPropertyList:)];
//        self.navigationItem.rightBarButtonItem = anotherButton;
 
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
//    self.navigationItem.leftBarButtonItem.image=[UIImage imageNamed:@"btnBack"];
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
