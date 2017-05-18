//
//  AttentionViewController.h
//  NCDS-SJGO
//
//  Created by Mofioso on 13-4-25.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "POHorizontalList.h"
#import "itemdelegate.h"
#import "MCSoundBoard.h"
@interface AttentionViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, POHorizontalListDelegate,itemdelegate> {
    
    NSMutableArray *List1;
    NSMutableArray *List2;
    NSMutableArray *List3;
    NSMutableArray *List4;
    NSMutableArray *List5;
    NSMutableArray *List6;
    
    NSMutableArray *DataList1;
    NSMutableArray *DataList2;
    NSMutableArray *DataList3;
    NSMutableArray *DataList4;
    NSMutableArray *DataList5;
    NSMutableArray *DataList6;
    
    NSMutableArray *Datalist;
    
}
@property BOOL isonline;

@property (retain, nonatomic) IBOutlet UIImageView *topimage;
@property (retain, nonatomic) IBOutlet UIToolbar *toolBar;

@property (nonatomic, retain) IBOutlet UITableView *tableView;
- (IBAction)Back:(UIButton *)sender;
@end
