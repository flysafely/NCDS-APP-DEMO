//
// REMenu.h
// REMenu
//  NCDS-SJGO
//
//  Created by 徐子迈 on 13-1-2.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "REMenuItem.h"
#import "REMenuContainerView.h"
#import "hiddebar.h"
@class REMenuItem;

@interface REMenu : NSObject {
    UIView *_menuView;
    UIView *_menuWrapperView;
    REMenuContainerView *_containerView;
    NSMutableArray *_itemViews;
    UIButton *_backgroundButton;
    NSObject<hiddebar> *_delegate;
}
@property (retain, nonatomic) NSObject<hiddebar> *delegate;
// Data
//
@property (strong, readwrite, nonatomic) NSArray *items;
@property (assign, readonly, nonatomic) BOOL isOpen;
@property (assign, readwrite, nonatomic) BOOL waitUntilAnimationIsComplete;

// Style
//
@property (assign, readwrite, nonatomic) CGFloat cornerRadius;
@property (strong, readwrite, nonatomic) UIColor *shadowColor;
@property (assign, readwrite, nonatomic) CGSize shadowOffset;
@property (assign, readwrite, nonatomic) CGFloat shadowOpacity;
@property (assign, readwrite, nonatomic) CGFloat shadowRadius;
@property (assign, readwrite, nonatomic) CGFloat itemHeight;
@property (strong, readwrite, nonatomic) UIColor *backgroundColor;
@property (strong, readwrite, nonatomic) UIColor *separatorColor;
@property (assign, readwrite, nonatomic) CGFloat separatorHeight;
@property (strong, readwrite, nonatomic) UIFont *font;
@property (strong, readwrite, nonatomic) UIColor *textColor;
@property (strong, readwrite, nonatomic) UIColor *textShadowColor;
@property (assign, readwrite, nonatomic) CGSize imageOffset;
@property (assign, readwrite, nonatomic) CGSize textOffset;
@property (assign, readwrite, nonatomic) CGSize textShadowOffset;
@property (strong, readwrite, nonatomic) UIColor *highlightedBackgroundColor;
@property (strong, readwrite, nonatomic) UIColor *highlightedSeparatorColor;
@property (strong, readwrite, nonatomic) UIColor *highlightedTextColor;
@property (strong, readwrite, nonatomic) UIColor *highlightedTextShadowColor;
@property (assign, readwrite, nonatomic) CGSize highlightedTextShadowOffset;
@property (assign, readwrite, nonatomic) CGFloat borderWidth;
@property (strong, readwrite, nonatomic) UIColor *borderColor;
@property (assign, readwrite, nonatomic) NSTextAlignment textAlignment;
@property (strong, readwrite, nonatomic) UIFont *subtitleFont;
@property (strong, readwrite, nonatomic) UIColor *subtitleTextColor;
@property (strong, readwrite, nonatomic) UIColor *subtitleTextShadowColor;
@property (assign, readwrite, nonatomic) CGSize subtitleTextOffset;
@property (assign, readwrite, nonatomic) CGSize subtitleTextShadowOffset;
@property (strong, readwrite, nonatomic) UIColor *subtitleHighlightedTextColor;
@property (strong, readwrite, nonatomic) UIColor *subtitleHighlightedTextShadowColor;
@property (assign, readwrite, nonatomic) CGSize subtitleHighlightedTextShadowOffset;
@property (assign, readwrite, nonatomic) NSTextAlignment subtitleTextAlignment;
@property (assign, readwrite, nonatomic) NSTimeInterval animationDuration;

- (id)initWithItems:(NSArray *)items;
- (void)showFromNavigationController:(UINavigationController *)navigationController;
- (void)closeWithCompletion:(void (^)(void))completion;
- (void)close;

@end
