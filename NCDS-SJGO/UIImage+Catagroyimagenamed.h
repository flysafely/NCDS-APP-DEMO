//
//  UIImage+Catagroyimagenamed.h
//  NCDS-SJGO
//
//  Created by 徐子迈 on 13-1-3.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Catagroyimagenamed)
- (id)initWithContentsOfResolutionIndependentFile:(NSString *)path;
+ (UIImage*)imageWithContentsOfResolutionIndependentFile:(NSString *)path;
@end
