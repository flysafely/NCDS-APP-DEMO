//
//  SubType2ViewController.m
//  NCDS-SJGO
//
//  Created by 徐子迈 on 13-1-3.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import "SubType2ViewController.h"
#import "ProductdetailViewController.h"
#import <QuartzCore/CALayer.h>
#import "UIImageView+WebCache.h"
#import "MCSoundBoard.h"

@interface SubType2ViewController ()

@end

@implementation SubType2ViewController
//@synthesize _toolbar=toolbar;
@synthesize a;
@synthesize item=_item;
@synthesize three3=_three3;
@synthesize groupby=_groupby;
@synthesize Pricebutton=_Pricebutton;
@synthesize Praisebutton=_Praisebutton;
@synthesize Salesbutton=_Salesbutton;
@synthesize topimage=_topimage;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.Pricebutton.frame=CGRectMake(-1, -7, 107, 50);
    self.Salesbutton.frame=CGRectMake(106, -7, 107, 50);
    self.Praisebutton.frame=CGRectMake(213, -7, 107, 50);
    self.topimage.frame=CGRectMake(0, -9, 320, 66);
    
    //自定义leftbarbuttonitem
    UIButton *leftbutton=[[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 52, 32)] autorelease];
    UIImage *image=[[UIImage imageNamed:@"navi_back_btn"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 15, 5, 10)];
    [leftbutton setBackgroundImage:image forState:UIControlStateNormal];
    UIImage *imageh=[[UIImage imageNamed:@"navi_back_btn_h"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 15, 5, 10)];
    [leftbutton setBackgroundImage:imageh forState:UIControlStateHighlighted];
    leftbutton.titleLabel.font=[UIFont systemFontOfSize:11];
    [leftbutton setTitle:@"  返   回" forState:UIControlStateNormal];
    [leftbutton setTitle:@"  返   回" forState:UIControlStateHighlighted];
    [leftbutton addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftitem=[[[UIBarButtonItem alloc] initWithCustomView:leftbutton] autorelease];
    self.navigationItem.leftBarButtonItem=leftitem;
    
    self.three3.frame = CGRectMake(320, 28, 5, 5);
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Default-PortraitBlank"]];
    
    [self.a setSeparatorStyle:UITableViewCellSeparatorStyleNone];    
    [self loadData];
    if(_refreshHeaderView == nil)
    {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.a.bounds.size.height, self.view.frame.size.width, self.a.bounds.size.height)];
        view.delegate = self;
        [self.a addSubview:view];
        
        _refreshHeaderView = view;
    }
    [_refreshHeaderView refreshLastUpdatedDate];
    
    self.navigationController.navigationBarHidden=NO;
}
-(void)refreshView:(UIRefreshControl *)refresh
{
    if (refresh.refreshing) {
        refresh.attributedTitle = [[[NSAttributedString alloc]initWithString:@"Refreshing data..."] autorelease];
        [self performSelector:@selector(handleData) withObject:nil afterDelay:2];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    self.topimage.frame=CGRectMake(0, -9, 320, 66);
    [self performSelector:@selector(movetopimage) withObject:nil afterDelay:0.5];
    
}

-(void)pop{
//    [self.delegate hiddebar];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)movetopimage{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.8];//动画时间长度，单位秒，浮点数
    self.topimage.frame=CGRectMake(0, -31, 320, 66);

    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
//    [self.a setContentOffset:CGPointMake(0, -20) animated:YES];
[MCSoundBoard playSoundForKey:@"attention"];
}
-(void)movethree3:(int)integer{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];//动画时间长度，单位秒，浮点数
    if (integer==0) {
    
        self.Pricebutton.frame=CGRectMake(-1, 0, 107, 50);
        self.Praisebutton.frame=CGRectMake(213, -7, 107, 50);
        self.Salesbutton.frame=CGRectMake(106, -7, 107, 50);
        [self.Pricebutton setBackgroundImage:[UIImage imageNamed:@"recipe_tab_1_active"] forState:UIControlStateNormal];
        [self.Praisebutton setBackgroundImage:[UIImage imageNamed:@"recipe_tab_3"] forState:UIControlStateNormal];
        [self.Salesbutton setBackgroundImage:[UIImage imageNamed:@"recipe_tab_2"] forState:UIControlStateNormal];
    }else if (integer==1){
        self.Pricebutton.frame=CGRectMake(-1, -7, 107, 50);
        self.Praisebutton.frame=CGRectMake(213, -7, 107, 50);
        self.Salesbutton.frame=CGRectMake(106, 0, 107, 50);
        [self.Pricebutton setBackgroundImage:[UIImage imageNamed:@"recipe_tab_1"] forState:UIControlStateNormal];
        [self.Praisebutton setBackgroundImage:[UIImage imageNamed:@"recipe_tab_3"] forState:UIControlStateNormal];
        [self.Salesbutton setBackgroundImage:[UIImage imageNamed:@"recipe_tab_2_active"] forState:UIControlStateNormal];
    }else if(integer==2){
        self.Pricebutton.frame=CGRectMake(-1, -7, 107, 50);
        self.Praisebutton.frame=CGRectMake(213, 0, 107, 50);
        self.Salesbutton.frame=CGRectMake(106, -7, 107, 50);
        [self.Pricebutton setBackgroundImage:[UIImage imageNamed:@"recipe_tab_1"] forState:UIControlStateNormal];
        [self.Praisebutton setBackgroundImage:[UIImage imageNamed:@"recipe_tab_3_active"] forState:UIControlStateNormal];
        [self.Salesbutton setBackgroundImage:[UIImage imageNamed:@"recipe_tab_2"] forState:UIControlStateNormal];
    }else if (integer==3){
        self.topimage.frame=CGRectMake(0, -31, 320, 66);
    }
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
      [self.a setContentOffset:CGPointMake(0, -20) animated:YES];
}

-(void)loadData{
    _item=[[NSMutableArray alloc] init];
    [_item removeAllObjects];
    FMDatabase *db=[FMDatabase databaseWithPath:[[NSBundle mainBundle] pathForResource:@"SJGOData" ofType:@"sqlite"]];
    if ([db open]) {
        if ([[NSString stringWithFormat:@"%d",self.tabBarController.selectedIndex] isEqualToString:@"0"]) {
            FMResultSet *dbresult=[db executeQuery:[NSString stringWithFormat:@"SELECT * FROM ProductData WHERE ProductADID='%@'",[[NSUserDefaults standardUserDefaults] objectForKey:@"ProductADID"]]];
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
        }else{
            FMResultSet *dbresult=[db executeQuery:[NSString stringWithFormat:@"SELECT * FROM ProductData WHERE ProductSubType='%@'",self.navigationItem.title]];
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
        }
    }[db close];
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    [def setValue:@"无" forKey:@"groupby"];

}

-(void)orderbyPrice{
    FMDatabase *db=[FMDatabase databaseWithPath:[[NSBundle mainBundle] pathForResource:@"SJGOData" ofType:@"sqlite"]];
    
    NSMutableArray *array=[[[NSMutableArray alloc] initWithObjects:nil] autorelease];
    
    NSMutableArray *brray=[[[NSMutableArray alloc] initWithObjects:nil] autorelease];
    
    if ([db open]) {
        if ([[NSString stringWithFormat:@"%d",self.tabBarController.selectedIndex] isEqualToString:@"0"]) {
            FMResultSet *dbresult=[db executeQuery:[NSString stringWithFormat:@"SELECT * FROM ProductData WHERE ProductADID='%@'",[[NSUserDefaults standardUserDefaults] objectForKey:@"ProductADID"]]];
            while ([dbresult next]) {
                [array addObject:[dbresult stringForColumn:@"ProductPrice"]];}
        }else{
            FMResultSet *dbresult=[db executeQuery:[NSString stringWithFormat:@"select ProductPrice from ProductData WHERE ProductSubType='%@'",self.navigationItem.title]];
            while ([dbresult next]) {
                [array addObject:[dbresult stringForColumn:@"ProductPrice"]];
            }[dbresult close];
        }
    }[db close];
    if ([array lastObject]!=nil) {
        for (int i=0; i<[array count]; i++) {
            NSNumber *c=[[[NSNumber alloc] initWithInteger:(i)] autorelease];
            [brray addObject:c];
        }
        
        for (int i=0; i<[array count]-1; i++) {
            int m=i;
            for (int j=1+i; j<[array count]; j++) {
                if ([[array objectAtIndex:j] doubleValue]<=[[array objectAtIndex:m] doubleValue]) {
                    m=j;
                }
            }
            [array exchangeObjectAtIndex:m withObjectAtIndex:i];
            [brray exchangeObjectAtIndex:m withObjectAtIndex:i];   
        }
        _groupby=brray;
        [_groupby retain];
        NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
        [def setValue:@"价格降序" forKey:@"groupby"];
        [self.a reloadData];
    }else{
        [self loadData];
    }
[self movethree3:0];
}
-(void)orderbypraise{
    FMDatabase *db=[FMDatabase databaseWithPath:[[NSBundle mainBundle] pathForResource:@"SJGOData" ofType:@"sqlite"]];
    
    NSMutableArray *array=[[[NSMutableArray alloc] init] autorelease];
    
    NSMutableArray *brray=[[[NSMutableArray alloc] init] autorelease];
    
    if ([db open]) {
        if ([[NSString stringWithFormat:@"%d",self.tabBarController.selectedIndex] isEqualToString:@"0"]) {
            FMResultSet *dbresult=[db executeQuery:[NSString stringWithFormat:@"SELECT * FROM ProductData WHERE ProductADID='%@'",[[NSUserDefaults standardUserDefaults] objectForKey:@"ProductADID"]]];
            while ([dbresult next]) {
                [array addObject:[dbresult stringForColumn:@"ProductPraise"]];}
        }else{
            FMResultSet *dbresult=[db executeQuery:[NSString stringWithFormat:@"select ProductPraise from ProductData WHERE ProductSubType='%@'",self.navigationItem.title]];
            while ([dbresult next]) {
                [array addObject:[dbresult stringForColumn:@"ProductPraise"]];
            }[dbresult close];
        }
    }[db close];
    if ([array lastObject]!=nil) {
        for (int i=0; i<[array count]; i++) {
            NSNumber *c=[[[NSNumber alloc] initWithInteger:(i)] autorelease];
            
            [brray addObject:c];
            
        }
        
        for (int i=0; i<[array count]-1; i++) {
            int m=i;
            for (int j=1+i; j<[array count]; j++) {
                if ([[array objectAtIndex:j] doubleValue]>=[[array objectAtIndex:m] doubleValue]) {
                    m=j;
                }
            }
            [array exchangeObjectAtIndex:m withObjectAtIndex:i];
            [brray exchangeObjectAtIndex:m withObjectAtIndex:i];
        }
        
        _groupby=brray;
        [_groupby retain];
        NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
        [def setValue:@"好评升序" forKey:@"groupby"];
        [self.a reloadData];
    }else{
        [self loadData];
    }
    [self movethree3:2];
}
-(void)orderbysales{

        FMDatabase *db=[FMDatabase databaseWithPath:[[NSBundle mainBundle] pathForResource:@"SJGOData" ofType:@"sqlite"]];
        
        NSMutableArray *array=[[[NSMutableArray alloc] init] autorelease];
        
        NSMutableArray *brray=[[[NSMutableArray alloc] init] autorelease];
        
        if ([db open]) {
            if ([[NSString stringWithFormat:@"%d",self.tabBarController.selectedIndex] isEqualToString:@"0"]) {
                FMResultSet *dbresult=[db executeQuery:[NSString stringWithFormat:@"SELECT * FROM ProductData WHERE ProductADID='%@'",[[NSUserDefaults standardUserDefaults] objectForKey:@"ProductADID"]]];
                while ([dbresult next]) {
                    [array addObject:[dbresult stringForColumn:@"ProductSales"]];}
            }else{
                FMResultSet *dbresult=[db executeQuery:[NSString stringWithFormat:@"select ProductSales from ProductData WHERE ProductSubType='%@'",self.navigationItem.title]];
                while ([dbresult next]) {
                    [array addObject:[dbresult stringForColumn:@"ProductSales"]];
                }[dbresult close];
            }
        }[db close];
        if ([array lastObject]!=nil) {
            for (int i=0; i<[array count]; i++) {
                NSNumber *c=[[[NSNumber alloc] initWithInteger:i] autorelease];
                
                [brray addObject:c];
                
            }
            
            for (int i=0; i<[array count]-1; i++) {
                int m=i;
                for (int j=1+i; j<[array count]; j++) {
                    if ([[array objectAtIndex:j] doubleValue]>=[[array objectAtIndex:m] doubleValue]) {
                        m=j;
                    }
                }
                [array exchangeObjectAtIndex:m withObjectAtIndex:i];
                [brray exchangeObjectAtIndex:m withObjectAtIndex:i];
            }
            
            
            _groupby=brray;
            [_groupby retain];
            NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
            [def setValue:@"销量升序" forKey:@"groupby"];
            [self.a reloadData];
        }else{
            [self loadData];
        }
    [self movethree3:1];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 86.f;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [_item count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SubTypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell==nil){
        cell=[[[NSBundle mainBundle] loadNibNamed:@"SubTypeCell" owner:nil options:nil] lastObject];
    }

    NSDictionary *DIC=[NSDictionary dictionary];
        NSLog(@"%@",DIC);
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"groupby"] isEqualToString:@"价格降序"] ) {
        DIC=[_item objectAtIndex:[[_groupby objectAtIndex:indexPath.row] intValue]];
    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"groupby"] isEqualToString:@"销量升序"] ){
        DIC=[_item objectAtIndex:[[_groupby objectAtIndex:indexPath.row] intValue]];
    }else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"groupby"] isEqualToString:@"好评升序"] ){
        DIC=[_item objectAtIndex:[[_groupby objectAtIndex:indexPath.row] intValue]];
    }else{
        DIC=[_item objectAtIndex:indexPath.row];
    }
    
    
    [(UILabel *)[cell viewWithTag:2] setText:[DIC objectForKey:@"ProductName"]];
    
    UIImageView *Image=(UIImageView *)[cell viewWithTag:1];
    [Image setImageWithURL:[NSURL URLWithString:[DIC objectForKey:@"ProductImageID"]] placeholderImage:[UIImage imageNamed:@"nscd_bg"]];
    
    [(UILabel *)[cell viewWithTag:3] setText:[NSString stringWithFormat:@"￥%@",[DIC objectForKey:@"ProductPrice"]]];
    [(UILabel *)[cell viewWithTag:4] setText:[NSString stringWithFormat:@"好评:%@",[DIC objectForKey:@"ProductPraise"]]];
    [(UILabel *)[cell viewWithTag:5] setText:[NSString stringWithFormat:@"销量:%@",[DIC objectForKey:@"ProductSales"]]];
    [(UILabel *)[cell viewWithTag:6] setText:[DIC objectForKey:@"ProductID"]];
    
    
    cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Gomall_bg_main"]];
    UIImageView *cellselected=[[[UIImageView alloc] initWithFrame:cell.frame] autorelease];
    cellselected.image=[UIImage imageNamed:@"cellBackTouch"];
    cell.selectedBackgroundView=cellselected;
    [self.a setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    CALayer *celllayer=[(UIImageView *)[cell viewWithTag:1] layer];
    celllayer.borderColor = [[UIColor whiteColor] CGColor];
    celllayer.borderWidth = 1.5f;
    celllayer.masksToBounds=YES;
    celllayer.cornerRadius=2;
    celllayer.shadowPath=[UIBezierPath bezierPathWithRect:cell.imageView.bounds].CGPath;
    celllayer.shadowOffset=CGSizeMake(0, 0);
    celllayer.shadowColor=[UIColor blackColor].CGColor;
    celllayer.shadowOpacity=1.0;
    return cell;

}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSDictionary *DIC=[[[NSDictionary alloc] init] autorelease];
    NSDictionary *DIC=[NSDictionary dictionary];
//    NSLog(@"%@",DIC);
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"groupby"] isEqualToString:@"价格降序"] ) {
        DIC=[_item objectAtIndex:[[_groupby objectAtIndex:indexPath.row] intValue]];
    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"groupby"] isEqualToString:@"销量升序"] ){
        DIC=[_item objectAtIndex:[[_groupby objectAtIndex:indexPath.row] intValue]];
    }else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"groupby"] isEqualToString:@"好评升序"] ){
        DIC=[_item objectAtIndex:[[_groupby objectAtIndex:indexPath.row] intValue]];
    }else{
        DIC=[_item objectAtIndex:indexPath.row];//待编辑
    }
    NSString *proid=[DIC objectForKey:@"ProductID"];
    NSString *proimageid=[DIC objectForKey:@"ProductImageID"];
    NSUserDefaults *ID=[NSUserDefaults standardUserDefaults];
    [ID setObject:proid forKey:@"passproductid"];
    [ID setObject:proimageid forKey:@"proimageurl"];

    ProductdetailViewController *pro=[[[ProductdetailViewController alloc] init] autorelease];
    pro.navigationItem.title=@"产品细节";
    [self.navigationController pushViewController:pro animated:YES];
}

- (void)dealloc {
//    [toolbar release];
    [a release];
    [_item release];
    [_groupby release];
    [_three3 release];
    [_Pricebutton release];
    [_Salesbutton release];
    [_Praisebutton release];
    [_topimage release];
    [super dealloc];
}
- (void)viewDidUnload {
//    [self set_toolbar:nil];
    [a release];
    a = nil;
    [self setA:nil];
    [self setThree3:nil];
    [self setPricebutton:nil];
    [self setSalesbutton:nil];
    [self setPraisebutton:nil];
    [self setTopimage:nil];
    [super viewDidUnload];
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)Pricedownorder:(UIButton *)sender {
    [MCSoundBoard playSoundForKey:@"topclick"];
    [self orderbyPrice];
}


- (IBAction)Salesup:(UIButton *)sender {
    [MCSoundBoard playSoundForKey:@"topclick"];
    [self orderbysales];
}

- (IBAction)Praiseup:(UIButton *)sender {
    [MCSoundBoard playSoundForKey:@"topclick"];
        [self orderbypraise];
}



#pragma mark –
#pragma mark UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    [scrollView retain];
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    [scrollView retain];
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    
}

#pragma mark –
#pragma mark EGORefreshTableHeaderDelegate Methods
- (void)doneLoadingTableViewData{
    NSLog(@"===加载完数据");
    //  model should call this when its done loading
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.a];
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    [self loadData];//先更新数据
    [self.a reloadData];//再让tableview  重新连接datasource...
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
   
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
    return _reloading; // should return if data source model is reloading
    
}
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
    return [NSDate date]; // should return date data source was last changed
    
}

@end
