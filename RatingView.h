//
//  RatingViewController.h
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//

#import <UIKit/UIKit.h>

@protocol RatingViewDelegate
-(void)ratingChanged:(float)newRating;
@end


@interface RatingView : UIView {
	UIImageView *s1, *s2, *s3, *s4, *s5;
	UIImage *unselectedImage, *partlySelectedImage, *fullySelectedImage;
	id<RatingViewDelegate> viewDelegate;

	float starRating, lastRating;
	float height, width; // of each image of the star!
}

@property (nonatomic, retain) UIImageView *s1;
@property (nonatomic, retain) UIImageView *s2;
@property (nonatomic, retain) UIImageView *s3;
@property (nonatomic, retain) UIImageView *s4;
@property (nonatomic, retain) UIImageView *s5;

-(void)setImagesDeselected:(NSString *)unselectedImage partlySelected:(NSString *)partlySelectedImage 
			  fullSelected:(NSString *)fullSelectedImage andDelegate:(id<RatingViewDelegate>)d;
-(void)displayRating:(float)rating;
-(float)rating;

@end
