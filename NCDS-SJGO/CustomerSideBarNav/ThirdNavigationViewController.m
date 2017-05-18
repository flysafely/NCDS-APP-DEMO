//
//  ThirdNavigationViewController.m
//  NCDS-SJGO
//
//  Created by 徐子迈 on 13-1-6.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import "ThirdNavigationViewController.h"

@interface ThirdNavigationViewController ()

@end

@implementation ThirdNavigationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
  self.navigationBarHidden=YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
