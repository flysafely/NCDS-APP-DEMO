//
//  FVImageSequence.h
//  Untitled
//
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//

#import <Foundation/Foundation.h>


@interface FVImageSequence : UIImageView {
	NSString *prefix;
	int numberOfImages;
	int current;
	int previous;
	NSString *extension;
	int increment;
}

@property (readwrite) int increment;
@property (readwrite, copy) NSString *extension;
@property (readwrite, copy) NSString *prefix;
@property (readwrite) int numberOfImages;

@end
