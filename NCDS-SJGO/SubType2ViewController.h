//
//  SubType2ViewController.h
//  NCDS-SJGO
//
//  Created by 徐子迈 on 13-1-3.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"
#import "EGORefreshTableHeaderView.h"
#import "hiddebar.h"
@interface SubType2ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,EGORefreshTableHeaderDelegate>{
    EGORefreshTableHeaderView *_refreshHeaderView;
    IBOutlet UITableView *a;
    BOOL _reloading;
//    NSObject<hiddebar> *_delegate;
}
//@property (retain, nonatomic) IBOutlet UIToolbar *_toolbar;
//- (IBAction)back:(id)sender;
//@property (retain, nonatomic) NSObject<hiddebar> *delegate;
@property (retain, nonatomic) IBOutlet UITableView *a;
@property(retain,nonatomic) NSMutableArray *item;

@property(retain,nonatomic) NSMutableArray *groupby;
@property (retain, nonatomic) IBOutlet UIImageView *three3;
@property (retain, nonatomic) IBOutlet UIButton *Pricebutton;
@property (retain, nonatomic) IBOutlet UIButton *Salesbutton;
@property (retain, nonatomic) IBOutlet UIButton *Praisebutton;
@property (retain, nonatomic) IBOutlet UIImageView *topimage;


- (void)doneLoadingTableViewData;
- (IBAction)Pricedownorder:(UIButton *)sender;
- (IBAction)Salesup:(UIButton *)sender;
- (IBAction)Praiseup:(UIButton *)sender;
@end
