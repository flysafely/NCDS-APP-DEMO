//
//  FolderCoverView.h
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//

#import <UIKit/UIKit.h>

@interface FolderCoverView : UIControl

@property (strong, nonatomic) UIView *cover;
@property (nonatomic) CGPoint position;
@property (nonatomic, strong) CALayer *highlight;

- (void)setIsTopView:(BOOL)isTop;
- (void)createHighlightWithFrame:(CGRect)aFrame;
- (id)initWithFrame:(CGRect)frame offset:(CGFloat)delta;

@end
