//------------------------------------------------------------------------
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//------------------------------------------------------------------------

#import <UIKit/UIKit.h>
#import "ZBarReaderController.h"

// orientation set support
#define ZBarOrientationMask(orient) (1 << orient)
#define ZBarOrientationMaskAll \
    (ZBarOrientationMask(UIInterfaceOrientationPortrait) | \
     ZBarOrientationMask(UIInterfaceOrientationPortraitUpsideDown) | \
     ZBarOrientationMask(UIInterfaceOrientationLandscapeLeft) | \
     ZBarOrientationMask(UIInterfaceOrientationLandscapeRight))

@class ZBarReaderView, ZBarCameraSimulator,ZBarHelpController;


@interface ZBarReaderViewController
    : UIViewController
{
    ZBarImageScanner *scanner;
    id <ZBarReaderDelegate> readerDelegate;
    ZBarReaderView *readerView;
    UIView *cameraOverlayView;
    CGAffineTransform cameraViewTransform;
    CGRect scanCrop;
    NSUInteger supportedOrientationsMask;
    UIImagePickerControllerCameraDevice cameraDevice;
    UIImagePickerControllerCameraFlashMode cameraFlashMode;
    UIImagePickerControllerQualityType videoQuality;
    BOOL showsZBarControls, tracksSymbols, enableCache;

    ZBarHelpController *helpController;
    UIView *controls;
    BOOL didHideStatusBar, rotating;
    ZBarCameraSimulator *cameraSim;
}

// access to configure image scanner
@property (nonatomic, readonly) ZBarImageScanner *scanner;

// barcode result recipient
@property (nonatomic, assign) id <ZBarReaderDelegate> readerDelegate;

// whether to use alternate control set
@property (nonatomic) BOOL showsZBarControls;

// whether to show the green tracking box.  note that, even when
// enabled, the box will only be visible when scanning EAN and I2/5.
@property (nonatomic) BOOL tracksSymbols;

// interface orientation support.  bit-mask of accepted orientations.
// see eg ZBarOrientationMask() and ZBarOrientationMaskAll
@property (nonatomic) NSUInteger supportedOrientationsMask;

// crop images for scanning.  the image will be cropped to this
// rectangle before scanning.  the rectangle is normalized to the
// image size and aspect ratio; useful values will place the rectangle
// between 0 and 1 on each axis, where the x-axis corresponds to the
// image major axis.  defaults to the full image (0, 0, 1, 1).
@property (nonatomic) CGRect scanCrop;

// provide a custom overlay.  note that this can be used with
// showsZBarControls enabled (but not if you want backward compatibility)
@property (nonatomic, retain) UIView *cameraOverlayView;

// transform applied to the preview image.
@property (nonatomic) CGAffineTransform cameraViewTransform;

// display the built-in help browser.  the argument will be passed to
// the onZBarHelp() javascript function.
- (void) showHelpWithReason: (NSString*) reason;

// capture the next frame and send it over the usual delegate path.
- (void) takePicture;

// these attempt to emulate UIImagePickerController
+ (BOOL) isCameraDeviceAvailable: (UIImagePickerControllerCameraDevice) cameraDevice;
+ (BOOL) isFlashAvailableForCameraDevice: (UIImagePickerControllerCameraDevice) cameraDevice;
+ (NSArray*) availableCaptureModesForCameraDevice: (UIImagePickerControllerCameraDevice) cameraDevice;
@property(nonatomic) UIImagePickerControllerCameraDevice cameraDevice;
@property(nonatomic) UIImagePickerControllerCameraFlashMode cameraFlashMode;
@property(nonatomic) UIImagePickerControllerCameraCaptureMode cameraCaptureMode;
@property(nonatomic) UIImagePickerControllerQualityType videoQuality;

// direct access to the ZBarReaderView
@property (nonatomic, readonly) ZBarReaderView *readerView;

// this flag still works, but its use is deprecated
@property (nonatomic) BOOL enableCache;
//@property (retain,nonatomic) ZBarHelpController *helpController;
// these are present only for backward compatibility.
// they will error if inappropriate/unsupported values are set
@property (nonatomic) UIImagePickerControllerSourceType sourceType; // Camera
@property (nonatomic) BOOL allowsEditing; // NO
@property (nonatomic) BOOL allowsImageEditing; // NO
@property (nonatomic) BOOL showsCameraControls; // NO
@property (nonatomic) BOOL showsHelpOnFail; // ignored
@property (nonatomic) ZBarReaderControllerCameraMode cameraMode; // Sampling
@property (nonatomic) BOOL takesPicture; // NO
@property (nonatomic) NSInteger maxScanDimension; // ignored

+ (BOOL) isSourceTypeAvailable: (UIImagePickerControllerSourceType) sourceType;

@end
