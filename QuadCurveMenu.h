//
//  QuadCurveMenu.h
//  NCDS-SJGO
//
//  Created by 徐子迈 on 13-1-2.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuadCurveMenuItem.h"
#import "SocialDelegate.h"

@protocol QuadCurveMenuDelegate;

@interface QuadCurveMenu : UIView <QuadCurveMenuItemDelegate>
{
    NSArray *_menusArray;
    int _flag;
    NSTimer *_timer;
    QuadCurveMenuItem *_addButton;
    
    id<QuadCurveMenuDelegate> _delegate;
    NSObject<SocialDelegate> *_social;
}
@property (nonatomic, copy) NSArray *menusArray;
@property (nonatomic, getter = isExpanding)     BOOL expanding;
@property (retain, nonatomic) NSObject<SocialDelegate> *social;
@property (nonatomic, assign) id<QuadCurveMenuDelegate> delegate;
- (id)initWithFrame:(CGRect)frame menus:(NSArray *)aMenusArray;
@end

@protocol QuadCurveMenuDelegate <NSObject>
- (void)quadCurveMenu:(QuadCurveMenu *)menu didSelectIndex:(NSInteger)idx;
@end