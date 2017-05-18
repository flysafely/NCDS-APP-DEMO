//
//  SearchViewController.h
//  NCDS-SJGO
//
//  Created by 徐子迈 on 12-12-28.
//  Copyright (c) 2012年 XcodeTest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UITextFieldDelegate,UIScrollViewDelegate>
//@property (retain, nonatomic) IBOutlet UIToolbar *toolbar;
//- (IBAction)pushtosub:(UIBarButtonItem *)sender;
@property (retain, nonatomic) IBOutlet UISearchBar *searchbar;
@property (retain, nonatomic) NSMutableArray *item;
@property (retain, nonatomic) NSString *keyword;
@property (retain, nonatomic) IBOutlet UITableView *tablebview;
@end
