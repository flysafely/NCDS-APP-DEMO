//
//  CateViewController.h
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//

#import <UIKit/UIKit.h>
#import "UIFolderTableView.h"

@interface CateViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *cates;
@property (strong, nonatomic) IBOutlet UIFolderTableView *tableView;
@property (retain, nonatomic) IBOutlet UINavigationItem *navigationbaritem;

@end
