//
//  UserClass.h
//  NCDS-SJGO
//
//  Created by Mofioso on 13-4-10.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserClass : NSObject{
    NSString *UserName;
    NSString *UserAccount;
    NSString *UserPassword;
    NSString *UserID;
    NSString *Money;
    NSString *UserPoints;
    NSString *Level;
}

@property (retain,nonatomic) NSString *_UserName;
@property (retain,nonatomic) NSString *_UserAccount;
@property (retain,nonatomic) NSString *_UserPassword;
@property (retain,nonatomic) NSString *_UserID;
@property (retain,nonatomic) NSString *_Money;
@property (retain,nonatomic) NSString *_UserPoints;
@property (retain,nonatomic) NSString *_Level;

-(UserClass *)getUserClass:(UserClass *)user;
@end
