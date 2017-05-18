//------------------------------------------------------------------------
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//------------------------------------------------------------------------

#import <CoreGraphics/CoreGraphics.h>
#import "ZBarImageScanner.h"

@class AVCaptureVideoDataOutput, AVCaptureOutput;
@class ZBarCaptureReader, ZBarCVImage;

@protocol ZBarCaptureDelegate <NSObject>

// called when a new barcode is detected.  the image refers to the
// video buffer and must not be retained for long
- (void)       captureReader: (ZBarCaptureReader*) captureReader
  didReadNewSymbolsFromImage: (ZBarImage*) image;

@optional
// called when a potential/uncertain barcode is detected.  will also
// be called *after* captureReader:didReadNewSymbolsFromImage:
// when good barcodes are detected
- (void) captureReader: (ZBarCaptureReader*) captureReader
       didTrackSymbols: (ZBarSymbolSet*) symbols;

@end

@interface ZBarCaptureReader
    : NSObject
{
#if !TARGET_IPHONE_SIMULATOR
    AVCaptureVideoDataOutput *captureOutput;
    id<ZBarCaptureDelegate> captureDelegate;
    ZBarImageScanner *scanner;
    CGRect scanCrop;
    CGSize size;
    CGFloat framesPerSecond;
    BOOL enableCache;

    dispatch_queue_t queue;
    ZBarImage *image;
    ZBarCVImage *result;
    volatile uint32_t state;
    int framecnt;
    unsigned width, height;
    uint64_t t_frame, t_fps, t_scan;
    CGFloat dt_frame;
#endif
}

// supply a pre-configured image scanner
- (id) initWithImageScanner: (ZBarImageScanner*) imageScanner;

// this must be called before the session is started
- (void) willStartRunning;

// this must be called *before* the session is stopped
- (void) willStopRunning;

// clear the internal result cache
- (void) flushCache;

// capture the next frame after processing.  the captured image will
// follow the same delegate path as an image with decoded symbols.
- (void) captureFrame;

// the capture output.  add this to an instance of AVCaptureSession
@property (nonatomic, readonly) AVCaptureOutput *captureOutput;

// delegate is notified of decode results and symbol tracking.
@property (nonatomic, assign) id<ZBarCaptureDelegate> captureDelegate;

// access to image scanner for configuration.
@property (nonatomic, readonly) ZBarImageScanner *scanner;

// region of image to scan in normalized coordinates.
// NB horizontal crop currently ignored...
@property (nonatomic, assign) CGRect scanCrop;

// size of video frames.
@property (nonatomic, readonly) CGSize size;

// (quickly) gate the reader function without interrupting the video
// stream.  also flushes the cache when enabled.  defaults to *NO*
@property (nonatomic) BOOL enableReader;

// current frame rate (for debug/optimization).
// only valid when running
@property (nonatomic, readonly) CGFloat framesPerSecond;

@property (nonatomic) BOOL enableCache;

@end
