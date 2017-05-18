//
//  SocialDelegate.h
//  NCDS-SJGO
//
//  Created by Mofioso on 13-4-5.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SocialDelegate <NSObject>
-(void)sendtotwitter;
-(void)sendtoWeibo;
-(void)sendtoFacebook;
-(void)CheckIn;
@end
