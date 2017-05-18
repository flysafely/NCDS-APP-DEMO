//
//  FVImageSequenceDemoViewController.m
//  FVImageSequenceDemo
//
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//

#import "FVImageSequenceDemoViewController.h"

@implementation FVImageSequenceDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	//Set slides extension
	[imageSquence setExtension:@"jpg"];
	
	//Set slide prefix prefix
	[imageSquence setPrefix:@"Seq_v04_640x378_"];
	
	//Set number of slides
	[imageSquence setNumberOfImages:72];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight)
		return YES;
	return NO;
}


- (IBAction)dismiss:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
