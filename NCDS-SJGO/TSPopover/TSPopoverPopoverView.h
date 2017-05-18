//
//  TSPopoverPopoverView.h
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//

#import <UIKit/UIKit.h>
#import "TSPopoverController.h"

@interface TSPopoverPopoverView : UIView

@property (nonatomic) int cornerRadius;
@property (nonatomic) CGPoint arrowPoint;
@property (nonatomic) BOOL isGradient;
@property (nonatomic, strong) UIColor *baseColor;
@property (nonatomic, readwrite) TSPopoverArrowDirection arrowDirection;
@property (nonatomic, readwrite) TSPopoverArrowPosition arrowPosition;



@end
