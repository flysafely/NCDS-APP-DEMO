//
//  RightNavViewController.m
//  SideBarNavDemo
//
//  Created by 徐子迈 on 12-12-11.
//  Copyright (c) 2012年 JianYe. All rights reserved.
//

#import "RightSideBarViewController.h"
#import "UIToolbar+uitoolbarshadow.h"
#import <QuartzCore/CALayer.h>
@interface RightSideBarViewController ()

@end

@implementation RightSideBarViewController
@synthesize toolbar=_toolbar;
@synthesize mainview=_mainview;
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
    // Do any additional setup after loading the view from its nib.
    UIImage *toolBarIMG = [UIImage imageNamed: @"navbar-first"];
//    toolBarIMG=[toolBarIMG resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    if ([self.toolbar respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)]) {
        [self.toolbar setBackgroundImage:toolBarIMG forToolbarPosition:0 barMetrics:0];
    }//设置toolbar的背景图片
    [self.view bringSubviewToFront:self.toolbar];//因为toolbar view 的层级跟 tableview 的层级一样  所以要显示出 toolbar的阴影 要把 toolbar放在最上层
    self.view.backgroundColor=[UIColor blackColor];
    
    [self.toolbar dropShadowWithOffset:CGSizeMake(0, 0) radius:5.0 color:[UIColor blackColor] opacity:0.6];//重写toolebar 阴影绘制函数！！FirstViewcontroller中由于其toolbar本来就放置再最前面 即使不用重写的方法 也能直接shadowoffset 设置
    self.mainview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"feed-paper-texture"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_toolbar release];
    [_mainview release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setToolbar:nil];
    [self setMainview:nil];
    [super viewDidUnload];
}
@end
