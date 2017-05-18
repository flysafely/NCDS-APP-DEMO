//
//  UserRegisterDelegate.h
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-12.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserClass.h"
#import "ChatViewController.h"
@protocol UserRegisterDelegate <NSObject>
-(void)moveoutbutton;
-(void)moveinbutton;
-(void)getimage:(NSString *)uuid;
-(void)getuserdata:(UserClass *)userdata;
//-(ChatViewController *)ReturnTheChatView:(ChatViewController *)chatview;
@end
