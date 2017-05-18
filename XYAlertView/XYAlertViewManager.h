//
//  XYAlertViewManager.h
//  DDMates
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//

#import <Foundation/Foundation.h>
typedef enum
{
    XYButtonStyleGray = 1,
    XYButtonStyleGreen = 2,
    XYButtonStyleDefault = XYButtonStyleGreen,
} XYButtonStyle;

CGRect XYScreenBounds();

@class XYAlertView;
@class XYLoadingView;
@class XYInputView;
@class GCPlaceholderTextView;

@interface XYAlertViewManager : NSObject <UITextViewDelegate>
{
    NSMutableArray *_alertViewQueue;
    id _currentAlertView;

    UIImageView *_alertView;
    UIView *_blackBG;
    UILabel *_loadingLabel;
    GCPlaceholderTextView *_textView;

    NSTimer *_loadingTimer;
    
    Boolean _isDismissing;
}

+(XYAlertViewManager*)sharedAlertViewManager;

-(XYAlertView*)showAlertView:(NSString*)message;
-(XYLoadingView*)showLoadingView:(NSString*)message;

-(void)show:(id)entity;
-(void)dismiss:(id)entity;
-(void)dismiss:(id)entity button:(int)buttonIndex;
-(void)dismissLoadingView:(id)entity withFailedMessage:(NSString*)message;
-(void)cleanupAllViews;

@end
