//
//  ListItem.m
//  POHorizontalList
//  NCDS-SJGO
//
//  Created by Mofioso on 13-4-25.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import "ListItem.h"

@implementation ListItem

- (id)initWithFrame:(CGRect)frame image:(UIImage *)image text:(NSString *)imageTitle BrandID:(NSString *)brandid
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.isfocused=NO;
        self.brandid=brandid;//品牌ID编号
        
        [self setUserInteractionEnabled:YES];
        
        self.imageTitle = imageTitle;
        self.image = image;
        UIImageView *pin=[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shop-hook-back"]] autorelease];
        
        UIImageView *imageView = [[[UIImageView alloc] initWithImage:image] autorelease];
        UIImageView *bg=[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stickerPack-empty"]] autorelease];
        [imageView setFrame:CGRectMake(22, 32, 43, 43)];
        imageView.transform=CGAffineTransformRotate(imageView.transform, M_PI/5);
        CALayer *roundCorner = [imageView layer];
        [roundCorner setMasksToBounds:YES];
//        [roundCorner setCornerRadius:imageView.frame.size.width/2];
        [roundCorner setCornerRadius:8];
        [roundCorner setBorderColor:[UIColor whiteColor].CGColor];
        [roundCorner setBorderWidth:2.0];
        
        
        UILabel *title = [[[UILabel alloc] init] autorelease];
        [title setBackgroundColor:[UIColor clearColor]];
        [title setTextColor:[UIColor colorWithRed:159.0/255.0 green:143.0/255.0 blue:129.0/255.0 alpha:0.8]];
        [title setShadowOffset:CGSizeMake(0, -1)];
        [title setShadowColor:[UIColor whiteColor]];
        [title setFont:[UIFont boldSystemFontOfSize:11.0]];
        [title setOpaque: NO];
        [title setText:imageTitle];
        title.textAlignment=NSTextAlignmentCenter;
        
        
        imageRect = CGRectMake(0.0, 10.0, 85.0, 85.0);
        
        textRect = CGRectMake(3, imageRect.origin.y + imageRect.size.height-6, 80.0, 20.0);
        
        UIButton *focusbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *shopimage=[UIImage imageNamed:@"shop-pricetag"];
        shopimage=[shopimage resizableImageWithCapInsets:UIEdgeInsetsMake(12, 10, 12, 10)];
        [focusbtn setBackgroundImage:shopimage forState:UIControlStateNormal];
        [focusbtn setTitle:@"关注" forState:UIControlStateNormal];
        [focusbtn.titleLabel setTextColor:[UIColor darkGrayColor]];
//        [focusbtn setTintColor:[UIColor redColor]];
        [focusbtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [focusbtn setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
        focusbtn.titleLabel.font=[UIFont systemFontOfSize:10];
        focusbtn.titleLabel.textAlignment=NSTextAlignmentRight;
        focusbtn.titleLabel.shadowOffset=CGSizeMake(0, 1);
        [focusbtn setFrame:CGRectMake(11, imageRect.origin.y + imageRect.size.height+8, 65, 28)];
        [focusbtn addTarget:self action:@selector(focusonit) forControlEvents:UIControlEventTouchUpInside];
        self.focus=focusbtn;
        [title setFrame:textRect];
//        [imageView setFrame:CGRectMake(12, 12, 60, 60)];
        [pin setFrame:CGRectMake(37, 10, 12, 10)];
        [bg setFrame:CGRectMake(2,10, 83, 87)];
        
        [self addSubview:pin];
//        [self addSubview:bg];
        [self addSubview:title];
        [self addSubview:self.focus];
        [self addSubview:imageView];
        [self addSubview:bg];
    }
    
    return self;
}
-(void)focusonit{
    if (!self.isfocused) {
//        [self.focus setBackgroundImage:[UIImage imageNamed:@"feed-search-import-checkbox-selected"] forState:UIControlStateNormal];
        [self.focus setTitle:@"取消关注" forState:UIControlStateNormal];
        self.isfocused=!self.isfocused;
    }else{
//        [self.focus setBackgroundImage:[UIImage imageNamed:@"feed-search-import-checkbox"] forState:UIControlStateNormal];
        [self.focus setTitle:@"关注" forState:UIControlStateNormal];
        self.isfocused=!self.isfocused;
        
    }
    [self.delegate focusonthebrand:self];
    NSLog(@"%p",self.delegate);
}
@end
