//
//  FVImageSequenceDemoViewController.h
//  FVImageSequenceDemo
//
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//

#import <UIKit/UIKit.h>
#import "FVImageSequence.h"

@interface FVImageSequenceDemoViewController : UIViewController {
	IBOutlet FVImageSequence *imageSquence;
}
- (IBAction)dismiss:(UIButton *)sender;

@end

