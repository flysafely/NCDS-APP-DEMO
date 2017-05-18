//
// REMenuItemView.h
// REMenu
//  NCDS-SJGO
//
//  Created by 徐子迈 on 13-1-2.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REMenuItem.h"
#import "REMenu.h"
#import "hiddebar.h"
@interface REMenuItemView : UIView
    

@property (strong, nonatomic) REMenu *menu;
@property (strong, nonatomic) UIView *separatorView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subtitleLabel;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) REMenuItem *item;

- (id)initWithFrame:(CGRect)frame menu:(REMenu *)menu hasSubtitle:(BOOL)hasSubtitle;

@end
