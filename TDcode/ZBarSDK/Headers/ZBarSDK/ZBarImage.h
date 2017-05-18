//------------------------------------------------------------------------
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//------------------------------------------------------------------------

#import <UIKit/UIKit.h>
#import "zbar.h"
#import "ZBarSymbol.h"

#ifdef __cplusplus
using namespace zbar;
#endif

// Obj-C wrapper for ZBar image

@interface ZBarImage : NSObject
{
    zbar_image_t *zimg;
    double t_convert;
}

@property (nonatomic) unsigned long format;
@property (nonatomic) unsigned sequence;
@property (nonatomic) CGSize size;
@property (nonatomic) CGRect crop;
@property (readonly, nonatomic) const void *data;
@property (readonly, nonatomic) unsigned long dataLength;
@property (copy, nonatomic) ZBarSymbolSet *symbols;
@property (readonly, nonatomic) zbar_image_t *zbarImage;
@property (readonly, nonatomic) UIImage *UIImage;

- (id) initWithImage: (zbar_image_t*) image;
- (id) initWithCGImage: (CGImageRef) image;
- (id) initWithCGImage: (CGImageRef) image
                  size: (CGSize) size;
- (id) initWithCGImage: (CGImageRef) image
                  crop: (CGRect) crop
                  size: (CGSize) size;

- (void) setData: (const void*) data
      withLength: (unsigned long) length;
- (UIImage*) UIImageWithOrientation: (UIImageOrientation) imageOrientation;
- (void) cleanup;

+ (unsigned long) fourcc: (NSString*) format;

#if 0
- convertToFormat: (unsigned long) format;
#endif

@end
