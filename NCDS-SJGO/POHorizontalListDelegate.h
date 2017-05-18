//
//  POHorizontalListDelegate.h
//  POHorizontalList
//  NCDS-SJGO
//
//  Created by Mofioso on 13-4-25.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListItem.h"

@protocol POHorizontalListDelegate <NSObject>

- (void) didSelectItem:(ListItem *)item;
//-(void)didselectitem:(ListItem *)item;
@end
