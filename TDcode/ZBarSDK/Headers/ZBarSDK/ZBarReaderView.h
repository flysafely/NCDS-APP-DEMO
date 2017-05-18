//------------------------------------------------------------------------
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//------------------------------------------------------------------------

#import <UIKit/UIKit.h>
#import "ZBarImageScanner.h"

@class AVCaptureSession, AVCaptureDevice;
@class CALayer;
@class ZBarImageScanner, ZBarCaptureReader, ZBarReaderView;

// delegate is notified of decode results.

@protocol ZBarReaderViewDelegate < NSObject >

- (void) readerView: (ZBarReaderView*) readerView
     didReadSymbols: (ZBarSymbolSet*) symbols
          fromImage: (UIImage*) image;

@end

// read barcodes from the displayed video preview.  the view maintains
// a complete video capture session feeding a ZBarCaptureReader and
// presents the associated preview with symbol tracking annotations.

@interface ZBarReaderView
    : UIView
{
    id<ZBarReaderViewDelegate> readerDelegate;
    ZBarCaptureReader *captureReader;
    CGRect scanCrop, effectiveCrop;
    CGAffineTransform previewTransform;
    CGFloat zoom, zoom0, maxZoom;
    UIColor *trackingColor;
    BOOL tracksSymbols, showsFPS;
    NSInteger torchMode;
    UIInterfaceOrientation interfaceOrientation;
    NSTimeInterval animationDuration;

    CALayer *preview, *overlay, *tracking, *cropLayer;
    UIView *fpsView;
    UILabel *fpsLabel;
    UIPinchGestureRecognizer *pinch;
    CGFloat imageScale;
    CGSize imageSize;
    BOOL started, running;
}

// supply a pre-configured image scanner.
- (id) initWithImageScanner: (ZBarImageScanner*) imageScanner;

// start the video stream and barcode reader.
- (void) start;

// stop the video stream and barcode reader.
- (void) stop;

// clear the internal result cache
- (void) flushCache;

// compensate for device/camera/interface orientation
- (void) willRotateToInterfaceOrientation: (UIInterfaceOrientation) orient
                                 duration: (NSTimeInterval) duration;

// delegate is notified of decode results.
@property (nonatomic, assign) id<ZBarReaderViewDelegate> readerDelegate;

// access to image scanner for configuration.
@property (nonatomic, readonly) ZBarImageScanner *scanner;

// whether to display the tracking annotation for uncertain barcodes
// (default YES).
@property (nonatomic) BOOL tracksSymbols;

// color of the tracking box (default green)
@property (nonatomic, retain) UIColor *trackingColor;

// enable pinch gesture recognition for zooming the preview/decode
// (default YES).
@property (nonatomic) BOOL allowsPinchZoom;

// torch mode to set automatically (default Auto).
@property (nonatomic) NSInteger torchMode;

// whether to display the frame rate for debug/configuration
// (default NO).
@property (nonatomic) BOOL showsFPS;

// zoom scale factor applied to video preview *and* scanCrop.
// also updated by pinch-zoom gesture.  clipped to range [1,maxZoom],
// defaults to 1.25
@property (nonatomic) CGFloat zoom;
- (void) setZoom: (CGFloat) zoom
        animated: (BOOL) animated;

// maximum settable zoom factor.
@property (nonatomic) CGFloat maxZoom;

// the region of the image that will be scanned.  normalized coordinates.
@property (nonatomic) CGRect scanCrop;

// additional transform applied to video preview.
// (NB *not* applied to scan crop)
@property (nonatomic) CGAffineTransform previewTransform;

// specify an alternate capture device.
@property (nonatomic, retain) AVCaptureDevice *device;

// direct access to the capture session.  warranty void if opened...
@property (nonatomic, readonly) AVCaptureSession *session;
@property (nonatomic, readonly) ZBarCaptureReader *captureReader;

// this flag still works, but its use is deprecated
@property (nonatomic) BOOL enableCache;

@end
