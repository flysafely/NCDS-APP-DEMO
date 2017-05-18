//
//  UserClass.m
//  NCDS-SJGO
//
//  Created by Mofioso on 13-4-10.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import "UserClass.h"

@implementation UserClass
@synthesize _UserName=UserName;
@synthesize _UserAccount=UserAccount;
@synthesize _UserPassword=UserPassword;
@synthesize _UserPoints=UserPoints;
@synthesize _UserID=UserID;
@synthesize _Level=Level;
@synthesize _Money=Money;

-(UserClass *)getUserClass:(UserClass *)user{
    
    return user;
}


@end
