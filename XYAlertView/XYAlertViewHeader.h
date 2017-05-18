//
//  XYAlertViewHeader.h
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//

#ifndef XYAlertViewDemo_XYAlertViewHeader_h
#define XYAlertViewDemo_XYAlertViewHeader_h

#import "XYAlertView.h"
#import "XYLoadingView.h"
#import "XYInputView.h"
#import "XYAlertViewManager.h"

#define XYShowAlert(_MSG_) [[XYAlertViewManager sharedAlertViewManager] showAlertView:_MSG_]
#define XYShowLoading(_MSG_) [[XYAlertViewManager sharedAlertViewManager] showLoadingView:_MSG_]

#endif
