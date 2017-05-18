//------------------------------------------------------------------------
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "zbar.h"
#import "ZBarImage.h"

#ifdef __cplusplus
using namespace zbar;
#endif

// Obj-C wrapper for ZBar image scanner

@interface ZBarImageScanner : NSObject
{
    zbar_image_scanner_t *scanner;
}

@property (nonatomic) BOOL enableCache;
@property (readonly, nonatomic) ZBarSymbolSet *results;

// decoder configuration
- (void) parseConfig: (NSString*) configStr;
- (void) setSymbology: (zbar_symbol_type_t) symbology
               config: (zbar_config_t) config
                   to: (int) value;

// image scanning interface
- (NSInteger) scanImage: (ZBarImage*) image;

@end
