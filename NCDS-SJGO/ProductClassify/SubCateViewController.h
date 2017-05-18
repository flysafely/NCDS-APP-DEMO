//
//  SubCateViewController.h
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//

#import <UIKit/UIKit.h>
#import "CateViewController.h"

@interface SubCateViewController : UIViewController

@property (strong, nonatomic) NSArray *subCates;
@property (strong, nonatomic) CateViewController *cateVC;

@end
