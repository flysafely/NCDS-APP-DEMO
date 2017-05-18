//
//  UIImage+Catagroyimagenamed.m
//  NCDS-SJGO
//
//  Created by 徐子迈 on 13-1-3.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import "UIImage+Catagroyimagenamed.h"

@implementation UIImage (Catagroyimagenamed)
+ (UIImage *)imageNamed:(NSString *)name {
    
    
    return [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] bundlePath],name ] ];
}
- (id)initWithContentsOfResolutionIndependentFile:(NSString *)path {
    if ( [UIScreen instancesRespondToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0 ) {
        NSString *path2x = [[path stringByDeletingLastPathComponent]
                            stringByAppendingPathComponent:[NSString stringWithFormat:@"%@@2x.%@",
                                                            [[path lastPathComponent] stringByDeletingPathExtension],
                                                            [path pathExtension]]];
        
        if ( [[NSFileManager defaultManager] fileExistsAtPath:path2x] ) {
            return [self initWithContentsOfFile:path2x];
        }
    }
    
    return [self initWithContentsOfFile:path];
}

+ (UIImage*)imageWithContentsOfResolutionIndependentFile:(NSString *)path {
    return [[[UIImage alloc] initWithContentsOfResolutionIndependentFile:path] autorelease];
}
@end
