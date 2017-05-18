//
//  iCodeBlogAnnotationView.h
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

#import "iCodeBlogAnnotation.h"

@interface iCodeBlogAnnotationView : MKAnnotationView 
{
	UIImageView *imageView;
}

@property (nonatomic, retain) UIImageView *imageView;

@end
