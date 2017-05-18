//
//  SearchViewController.m
//  NCDS-SJGO
//
//  Created by 徐子迈 on 12-12-28.
//  Copyright (c) 2012年 XcodeTest. All rights reserved.
//

#import "SearchViewController.h"
//#import "SearchSubViewController.h"
#import <QuartzCore/CALayer.h>
#import "UIToolbar+uitoolbarshadow.h"
#import "XYAlertView.h"
#import "FMDatabase.h"
#import "ProductdetailViewController.h"
#import "UIImageView+WebCache.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
@synthesize searchbar=_searchbar;
@synthesize keyword=_keyword;
@synthesize tablebview=_tablebview;
@synthesize item=_item;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *img = [[UIImage imageNamed:@"custom_popup_bg_part1"] stretchableImageWithLeftCapWidth:1 topCapHeight:0];
    [self.searchbar setBackgroundImage:img];
    self.searchbar.frame = CGRectMake(0, 0, 320, 44);
    self.searchbar.placeholder=@"请输入关键词";
    UIImage *image=[UIImage imageNamed:@"friends-button-pressed-bg"];
    image=[image resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [self.searchbar setSearchFieldBackgroundImage:image forState:UIControlStateNormal];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Default-PortraitBlank"]];
    [self.tablebview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
}

-(void)loadData{
    _item=[[NSMutableArray alloc] init];
    FMDatabase *db=[FMDatabase databaseWithPath:[[NSBundle mainBundle] pathForResource:@"SJGOData" ofType:@"sqlite"]];
    if ([db open]) {
        NSString *str=@"%";
        
        NSString *string=[NSString stringWithFormat:@"%@%@%@",str,self.keyword,str];
        FMResultSet *dbresult=[db executeQuery:[NSString stringWithFormat:@"SELECT * FROM ProductData WHERE ProductName like '%@'",string]];
        while ([dbresult next]) {
            NSMutableDictionary *dic=[NSMutableDictionary dictionary];
            
            NSString *proname=[NSString stringWithFormat:@"%@",[dbresult stringForColumn:@"ProductName"]];
            [dic setObject:proname forKey:@"ProductName"];
            [dic setObject:[dbresult stringForColumn:@"ProductPrice"] forKey:@"ProductPrice"];
            [dic setObject:[dbresult stringForColumn:@"ProductPraise"] forKey:@"ProductPraise"];
            [dic setObject:[dbresult stringForColumn:@"ProductSales"] forKey:@"ProductSales"];
            [dic setObject:[dbresult stringForColumn:@"ProductID"] forKey:@"ProductID"];
            [dic setObject:[dbresult stringForColumn:@"ProductImageID"] forKey:@"ProductImageID"];
            [_item addObject:dic];
            
        }[dbresult close];
    }[db close];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {

    [_searchbar release];
    [_tablebview release];
    [super dealloc];
    
}
- (void)viewDidUnload {

    [self setSearchbar:nil];
    [self setTablebview:nil];
    [super viewDidUnload];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 86.f;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_item count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SearchCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell==nil){
        cell=[[[NSBundle mainBundle] loadNibNamed:@"SearchCell" owner:nil options:nil] lastObject];
    }
    
    cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Gomall_bg_main"]];
    
    
    NSDictionary *DIC=[NSDictionary dictionary];
    DIC=[_item objectAtIndex:indexPath.row];
    [(UILabel *)[cell viewWithTag:2] setText:[DIC objectForKey:@"ProductName"]];
        CALayer *celllayer=[(UIImageView *)[cell viewWithTag:1] layer];
    celllayer.borderColor = [[UIColor whiteColor] CGColor];
    celllayer.borderWidth = 1.5f;
    celllayer.masksToBounds=YES;
    celllayer.cornerRadius=2;
    celllayer.shadowPath=[UIBezierPath bezierPathWithRect:cell.imageView.bounds].CGPath;
    celllayer.shadowOffset=CGSizeMake(0, 0);
    celllayer.shadowColor=[UIColor blackColor].CGColor;
    celllayer.shadowOpacity=1.0;
    
    UIImageView *Image=(UIImageView *)[cell viewWithTag:1];

    [Image setImageWithURL:[NSURL URLWithString:[DIC objectForKey:@"ProductImageID"]] placeholderImage:[UIImage imageNamed:@"nscd_bg"]];
    
    [(UILabel *)[cell viewWithTag:3] setText:[NSString stringWithFormat:@"￥%@",[DIC objectForKey:@"ProductPrice"]]];
    [(UILabel *)[cell viewWithTag:4] setText:[NSString stringWithFormat:@"好评:%@",[DIC objectForKey:@"ProductPraise"]]];
    [(UILabel *)[cell viewWithTag:5] setText:[NSString stringWithFormat:@"销量:%@",[DIC objectForKey:@"ProductSales"]]];
    [(UILabel *)[cell viewWithTag:6] setText:[DIC objectForKey:@"ProductID"]];
    UIImageView *cellselected=[[[UIImageView alloc] initWithFrame:cell.frame] autorelease];
    cellselected.image=[UIImage imageNamed:@"cellBackTouch"];
    //    [vie addSubview:cellselected];
    cell.selectedBackgroundView=cellselected;
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    NSDictionary *DIC=[NSDictionary dictionary];
    DIC=[_item objectAtIndex:indexPath.row];
    NSString *proid=[DIC objectForKey:@"ProductID"];
    NSString *proimageid=[DIC objectForKey:@"ProductImageID"];
    NSUserDefaults *ID=[NSUserDefaults standardUserDefaults];
    [ID setObject:proid forKey:@"passproductid"];
    [ID setObject:proimageid forKey:@"proimageurl"];
    ProductdetailViewController *pro=[[[ProductdetailViewController alloc] init] autorelease];
    pro.navigationItem.title=@"产品细节";
    [self.navigationController pushViewController:pro animated:YES];
}

- (BOOL)canBecomeFirstResponder{
    return YES;
}
-(void)viewWillAppear:(BOOL)animated{
//    [self pushsearchbar];
    [self.searchbar becomeFirstResponder];
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if ([self.searchbar.text isEqualToString:@""]) {
        XYAlertView *alertView = [XYAlertView alertViewWithTitle:@"抱歉！"
                                                         message:@"您还没有输入内容？"
                                                         buttons:[NSArray arrayWithObjects:@"确定", nil]
                                                    afterDismiss:^(int buttonIndex) {
                                                                    }];
        
        [alertView show];
    }
    self.keyword=self.searchbar.text;
    [self.searchbar resignFirstResponder];
    self.searchbar.showsCancelButton=NO;
    [self loadData];
    [self.tablebview reloadData];
    
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    self.searchbar.showsCancelButton=YES;
    
    for(id cc in [searchBar subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消"  forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"btn-prt-done"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"btn-prt-done-down"] forState:UIControlStateHighlighted];
            
        }
    }
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.searchbar resignFirstResponder];
    self.searchbar.showsCancelButton=NO;

}

-(void)pushsearchbar{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0];//动画时间长度，单位秒，浮点数
    self.searchbar.frame = CGRectMake(0, 0, 320, 44);
    
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.searchbar resignFirstResponder];
    self.searchbar.showsCancelButton=NO;
    
}
@end
