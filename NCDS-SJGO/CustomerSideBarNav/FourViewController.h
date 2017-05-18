//
//  FourViewController.h
//  NCDS-SJGO
//  已经完成的订单
//  Created by 徐子迈 on 13-1-2.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingView.h"
@interface FourViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,RatingViewDelegate,NSURLConnectionDelegate>{
    RatingView *starView;
}
@property (nonatomic, retain) RatingView *starView;

@property (retain, nonatomic) IBOutlet UIToolbar *toolBar;
@property (retain, nonatomic) IBOutlet UIButton *back;
- (IBAction)dismiss:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UITableView *maintable;
@property (retain, nonatomic) NSMutableArray *item;
@property (retain, nonatomic) NSString *praise;
@property (retain, nonatomic) NSIndexPath *index;

@property (retain, nonatomic) UIButton *ratebtn;
@property (retain, nonatomic) UIButton *bgbtn;
@property (retain, nonatomic) UIImageView *rateview;
@property (retain, nonatomic) UILabel *ratetitle;
@property (retain, nonatomic) NSString *ratepoints;
@property (retain, nonatomic) NSMutableData *datas;
-(void)ratingChanged:(float)newRating;
@end
