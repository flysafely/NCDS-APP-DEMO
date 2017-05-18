/*
 *  UIBarButtonItem+WEPopover.m
 *  WEPopover
 //  NCDS-SJGO
 //
 //  Created by Mofioso on 13-3-9.
 //  Copyright (c) 2013年 XcodeTest. All rights reserved.
 //
 */

#import "UIBarButtonItem+WEPopover.h" 

@implementation UIBarButtonItem(WEPopover)

- (CGRect)frameInView:(UIView *)v {
	
	BOOL hasCustomView = (self.customView != nil);
	
	if (!hasCustomView) {
		UIView *tempView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
		self.customView = tempView;
	}
	
	UIView *parentView = self.customView.superview;
	NSUInteger indexOfView = [parentView.subviews indexOfObject:self.customView];
	
	if (!hasCustomView) {
		self.customView = nil;
	}
	UIView *button = [parentView.subviews objectAtIndex:indexOfView];
	return [parentView convertRect:button.frame toView:v];
}

- (UIView *)superview {
	
	BOOL hasCustomView = (self.customView != nil);
	
	if (!hasCustomView) {
		UIView *tempView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
		self.customView = tempView;
	}
	
	UIView *parentView = self.customView.superview;
	
	if (!hasCustomView) {
		self.customView = nil;
	}
	return parentView;
}

@end
