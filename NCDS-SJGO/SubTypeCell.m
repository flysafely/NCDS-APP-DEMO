//
//  SubTypeCell.m
//  NCDS-SJGO
//
//  Created by 徐子迈 on 13-1-5.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import "SubTypeCell.h"
#import <QuartzCore/CALayer.h>
@implementation SubTypeCell
@synthesize cellimage=_cellimage;
- (void)dealloc {
    [_cellimage release];
    [super dealloc];
}
@end
