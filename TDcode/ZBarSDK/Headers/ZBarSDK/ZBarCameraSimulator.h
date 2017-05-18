//------------------------------------------------------------------------
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//------------------------------------------------------------------------

@class ZBarReaderView;

// hack around missing simulator support for AVCapture interfaces

@interface ZBarCameraSimulator
    : NSObject
    < UINavigationControllerDelegate,
      UIImagePickerControllerDelegate,
      UIPopoverControllerDelegate >
{
    UIViewController *viewController;
    ZBarReaderView *readerView;
    UIImagePickerController *picker;
    UIPopoverController *pickerPopover;
}

- (id) initWithViewController: (UIViewController*) viewController;
- (void) takePicture;

@property (nonatomic, assign) ZBarReaderView *readerView;

@end
