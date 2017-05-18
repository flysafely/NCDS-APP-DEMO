//
//  iCodeBlogAnnotation.m
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//

#import "iCodeBlogAnnotation.h"


@implementation iCodeBlogAnnotation

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;
@synthesize annotationType;

-init
{
	return self;
}

-initWithCoordinate:(CLLocationCoordinate2D)inCoord
{
	coordinate = inCoord;
	return self;
}

@end
