//
//  itemdelegate.h
//  POHorizontalList
//
//  Created by Mofioso on 13-4-25.
//  Copyright (c) 2013年 Polat Olu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ListItem;

@protocol itemdelegate <NSObject>
-(void)focusonthebrand:(ListItem *)item;
@end
