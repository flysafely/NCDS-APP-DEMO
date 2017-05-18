//
//  FVImageSequence.m
//  Untitled
//
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//

#import "FVImageSequence.h"


@implementation FVImageSequence
@synthesize prefix, numberOfImages, extension, increment;

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	if(increment == 0)
		increment = 1;
	[super touchesBegan:touches withEvent:event];
	
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self];
	
	previous = touchLocation.x;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesMoved:touches withEvent:event];
	
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self];
	
	int location = touchLocation.x;
	
	if(location < previous)
		current += increment;
	else
		current -= increment;
	
	previous = location;
	
	if(current > numberOfImages)
		current = 0;
	if(current < 0)
		current = numberOfImages;
	
	NSString *path = [NSString stringWithFormat:@"%@%d", prefix, current];
	NSLog(@"%@", path);
	
	path = [[NSBundle mainBundle] pathForResource:path ofType:extension];
	
	
	UIImage *img =  [[UIImage alloc] initWithContentsOfFile:path];
	
	[self setImage:img];
	
	[img release];
}

-(void)dealloc{
	[extension release];
	[prefix release];
	[super dealloc];
}

@end
