//
//  POHorizontalList.h
//  POHorizontalList
//  NCDS-SJGO
//
//  Created by Mofioso on 13-4-25.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "POHorizontalListDelegate.h"

#define DISTANCE_BETWEEN_ITEMS  15.0
#define LEFT_PADDING            15.0
#define ITEM_WIDTH              72.0
#define TITLE_HEIGHT            20.0

@interface POHorizontalList : UIView <UIScrollViewDelegate> {
    CGFloat scale;
}

@property (nonatomic, retain) UIScrollView *scrollView;

@property (nonatomic, assign) id<POHorizontalListDelegate> delegate;

- (id)initWithFrame:(CGRect)frame title:(NSString *)title items:(NSMutableArray *)items;

@end
