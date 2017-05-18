//------------------------------------------------------------------------
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//------------------------------------------------------------------------

#import <UIKit/UIKit.h>

@class ZBarHelpController;

@protocol ZBarHelpDelegate
@optional

- (void) helpControllerDidFinish: (ZBarHelpController*) help;

@end


// failure dialog w/a few useful tips

@interface ZBarHelpController : UIViewController
                              < UIWebViewDelegate,
                                UIAlertViewDelegate >
{
    NSString *reason;
    id delegate;
    UIWebView *webView;
    UIToolbar *toolbar;
    UIBarButtonItem *doneBtn, *backBtn, *space;
    NSURL *linkURL;
    NSUInteger orientations;
}

@property (nonatomic, assign) id<ZBarHelpDelegate> delegate;
@property(nonatomic,retain) UIBarButtonItem *doneBtn;
// designated initializer
- (id) initWithReason: (NSString*) reason;

- (BOOL) isInterfaceOrientationSupported: (UIInterfaceOrientation) orientation;
- (void) setInterfaceOrientation: (UIInterfaceOrientation) orientation
                       supported: (BOOL) supported;

@end
