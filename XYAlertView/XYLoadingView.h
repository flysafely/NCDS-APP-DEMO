//
//  XYLoadingView.h
//
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//

#import <UIKit/UIKit.h>
#import "XYAlertViewManager.h"

@interface XYLoadingView : NSObject

@property (copy, nonatomic) NSString *message;

+(id)loadingViewWithMessage:(NSString *)message;
-(id)initWithMessaege:(NSString *)message;

-(void)show;
-(void)dismiss;
-(void)dismissWithMessage:(NSString*)message;

@end
