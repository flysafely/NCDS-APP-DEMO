//
//  POHorizontalList.m
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//

#import "POHorizontalList.h"

@implementation POHorizontalList

- (id)initWithFrame:(CGRect)frame title:(NSString *)title items:(NSMutableArray *)items
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, TITLE_HEIGHT, self.frame.size.width, self.frame.size.height)];

        CGSize pageSize = CGSizeMake(ITEM_WIDTH, self.scrollView.frame.size.height);
        NSUInteger page = 0;
        
        for(ListItem *item in items) {
            [item setFrame:CGRectMake(LEFT_PADDING + (pageSize.width + DISTANCE_BETWEEN_ITEMS) * page++, 0, pageSize.width, pageSize.height)];
            
            UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemTapped:)];
            [item addGestureRecognizer:singleFingerTap];
        
            [self.scrollView addSubview:item];
        }
        
        self.scrollView.contentSize = CGSizeMake(LEFT_PADDING + (pageSize.width + DISTANCE_BETWEEN_ITEMS) * [items count], pageSize.height);
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
        
//        [self addSubview:self.scrollView];
        
        // Title Label
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(4, 5.0, self.frame.size.width, 18)];
        [titleLabel setText:title];
        [titleLabel setFont:[UIFont boldSystemFontOfSize:10.0]];
//        [titleLabel setTextColor:[UIColor colorWithWhite:116.0/256.0 alpha:1.0]];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setShadowColor:[UIColor darkGrayColor]];
        [titleLabel setShadowOffset:CGSizeMake(0, 1.0)];
        [titleLabel setOpaque:YES];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        
//        [self addSubview:titleLabel];
        
        UIImageView *CellBackGround=[[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320, 155)];
        [CellBackGround setImage:[UIImage imageNamed:@"shop-lights-111"]];
        UIImageView *CellAltBar=[[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 140.f, 320, 15)];
        [CellAltBar setImage:[UIImage imageNamed:@"shop-shelf-alt"]];
        UIImageView *label=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DetailNormalPrice"]];
        label.frame=CGRectMake(0, 6, 66, 22);
        [self addSubview:CellBackGround];
        [self addSubview:CellAltBar];
        [self addSubview:label];
        [self addSubview:titleLabel];
        [self addSubview:self.scrollView];
        
        
//         UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_PADDING, 120, self.frame.size.width, 30)];
//        [titleLabel2 setText:@"123"];
//        [titleLabel2 setBackgroundColor:[UIColor blackColor]];
//        [titleLabel2 setOpaque:YES];
//        [self addSubview:titleLabel2];
        // Background shadow
//        CAGradientLayer *dropshadowLayer = [CAGradientLayer layer];
//        dropshadowLayer.contentsScale = scale;
//        dropshadowLayer.startPoint = CGPointMake(0.0f, 0.0f);
//        dropshadowLayer.endPoint = CGPointMake(0.0f, 1.0f);
//        dropshadowLayer.opacity = 1.0;
//        dropshadowLayer.frame = CGRectMake(1.0f, 1.0f, self.frame.size.width - 2.0, self.frame.size.height - 2.0);
//        dropshadowLayer.locations = [NSArray arrayWithObjects:
//                                     [NSNumber numberWithFloat:0.0f],
//                                     [NSNumber numberWithFloat:1.0f], nil];
//         dropshadowLayer.colors = [NSArray arrayWithObjects:
//                                   (id)[[UIColor colorWithWhite:224.0/256.0 alpha:1.0] CGColor],
//                                   (id)[[UIColor colorWithWhite:235.0/256.0 alpha:1.0] CGColor], nil];
//         
//         [self.layer insertSublayer:dropshadowLayer below:self.scrollView.layer];

    }

    return self;
}

- (void)itemTapped:(UITapGestureRecognizer *)recognizer {
    ListItem *item = (ListItem *)recognizer.view;

    if (item != nil) {
        [self.delegate didSelectItem:item];
    }
}

@end
