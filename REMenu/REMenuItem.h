//
// REMenuItem.h
// REMenu
//  NCDS-SJGO
//
//  Created by 徐子迈 on 13-1-2.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface REMenuItem : NSObject

@property (copy, readwrite, nonatomic) NSString *title;
@property (copy, readwrite, nonatomic) NSString *subtitle;
@property (strong, readwrite, nonatomic) UIImage *image;
@property (strong, readwrite, nonatomic) UIImage *higlightedImage;
@property (copy, readwrite, nonatomic) void (^action)(REMenuItem *item);
@property (assign, readwrite, nonatomic) NSInteger tag;

- (id)initWithTitle:(NSString *)title image:(UIImage *)image highlightedImage:(UIImage *)higlightedImage action:(void (^)(REMenuItem *item))action;
- (id)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle image:(UIImage *)image highlightedImage:(UIImage *)higlightedImage action:(void (^)(REMenuItem *item))action;

@end
