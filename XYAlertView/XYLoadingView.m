//
//  XYLoadingView.m
//
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//

#import "XYLoadingView.h"

@implementation XYLoadingView

@synthesize message = _message;

+(id)loadingViewWithMessage:(NSString *)message
{
    return [[[XYLoadingView alloc] initWithMessaege:message] autorelease];
}

-(id)initWithMessaege:(NSString *)message
{
    self = [self init];
    if(self)
    {
        self.message = message;
    }
    return self;
}

-(void)show
{
    [[XYAlertViewManager sharedAlertViewManager] show:self];
}

-(void)dismiss
{
    [[XYAlertViewManager sharedAlertViewManager] dismiss:self];
}

-(void)dismissWithMessage:(NSString*)message
{
    [[XYAlertViewManager sharedAlertViewManager] dismissLoadingView:self withFailedMessage:message];
}

@end
