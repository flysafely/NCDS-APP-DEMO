//
//  ThirdSubViewController.m
//  NCDS-SJGO
//
//  Created by 徐子迈 on 13-1-6.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import "ThirdSubViewController.h"

@interface ThirdSubViewController ()

@end

@implementation ThirdSubViewController
@synthesize toolbar=_toolbar;
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_toolbar release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setToolbar:nil];
    [super viewDidUnload];
}
- (IBAction)popback:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
