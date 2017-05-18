//
//  ListItem.h
//  POHorizontalList
//  NCDS-SJGO
//
//  Created by Mofioso on 13-4-25.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "itemdelegate.h"

@interface ListItem : UIView {
    CGRect textRect;
    CGRect imageRect;
}
@property (nonatomic, assign) id<itemdelegate> delegate;
@property (nonatomic, retain) NSObject *objectTag;

@property (nonatomic, retain) NSString *imageTitle;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic,retain) UIButton *focus;
@property (nonatomic,retain) NSString *brandid;
@property BOOL isfocused;
- (id)initWithFrame:(CGRect)frame image:(UIImage *)image text:(NSString *)imageTitle BrandID:(NSString *)brandid;
-(void)focusonit:(id)sender;
@end
