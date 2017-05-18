//
//  FourViewController.m
//  NCDS-SJGO
//
//  Created by 徐子迈 on 13-1-2.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import "FourViewController.h"
#import "FourSubViewController.h"
#import <QuartzCore/CALayer.h>
#import "FMDatabase.h"
#import "XYAlertView.h"
#import "XYAlertViewHeader.h"
#import "UIImageView+WebCache.h"

@interface FourViewController ()
@property (retain,nonatomic) NSString *proid;
@end

@implementation FourViewController
@synthesize toolBar=_toolBar;
@synthesize maintable=_maintable;
@synthesize item=_item;
@synthesize praise=_praise;
@synthesize starView=_starView;
@synthesize index=_index;
@synthesize ratebtn=_ratebtn;
@synthesize rateview=_rateview;
@synthesize ratetitle=_ratetitle;
@synthesize bgbtn=_bgbtn;
@synthesize datas=_datas;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)loaddata{
    _item=[[NSMutableArray alloc] initWithCapacity:10];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *sqlitePath = [documentDirectory stringByAppendingPathComponent:@"DataCache.sqlite"];
    FMDatabase *db=[FMDatabase databaseWithPath:sqlitePath];
    if ([db open]) {
        FMResultSet *result=[db executeQuery:[NSString stringWithFormat:@"select * from UnFinishOrderData where CustomerID='%@'",[[NSUserDefaults standardUserDefaults] objectForKey:@"CustomerID"]]];
        while ([result next]) {
            NSMutableDictionary *dic=[NSMutableDictionary dictionary];
            [dic setObject:[result stringForColumn:@"UnFinishOrderDataID"] forKey:@"UnFinishOrderDataID"];
            [dic setObject:[result stringForColumn:@"ProductID"] forKey:@"ProductID"];
            [dic setObject:[result stringForColumn:@"CustomerID"] forKey:@"CustomerID"];
            [dic setObject:[result stringForColumn:@"Date"] forKey:@"Date"];
            [dic setObject:[result stringForColumn:@"OrderInfo"] forKey:@"OrderInfo"];
            [dic setObject:[result stringForColumn:@"Quantity"] forKey:@"Quantity"];
            [dic setObject:[result stringForColumn:@"ProductName"] forKey:@"ProductName"];
            [dic setObject:[result stringForColumn:@"TotalPrice"] forKey:@"TotalPrice"];
            [dic setObject:[result stringForColumn:@"Address"] forKey:@"Address"];
            [dic setObject:[result stringForColumn:@"ProductImageURL"] forKey:@"ProductImageURL"];
            [self.item addObject:dic];
        }[result close];
    }[db close];
    if ([_item count]==0) {
        self.maintable.hidden=YES;
        [self emptycart];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //商品评分
    self.ratetitle=[[[UILabel alloc] initWithFrame:CGRectMake(120, 203, 130, 40)] autorelease];
    self.ratetitle.text=@"商 品 评 分";
    [self.ratetitle setTextColor:[UIColor lightGrayColor]];
    [self.ratetitle setBackgroundColor:[UIColor clearColor]];
    //完成按钮
    self.ratebtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.ratebtn.frame=CGRectMake(130,270, 60, 30);
    self.ratebtn.tintColor=[UIColor blackColor];
    self.ratebtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [self.ratebtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.ratebtn setBackgroundImage:[UIImage imageNamed:@"camera-cancel-button"] forState:UIControlStateNormal];
    [self.ratebtn setBackgroundImage:[UIImage imageNamed:@"camera-cancel-button-pressed"] forState:UIControlStateHighlighted];
    [self.ratebtn addTarget:self action:@selector(rateover:) forControlEvents:UIControlEventTouchUpInside];
    //阻挡操作按钮
    self.bgbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.bgbtn.frame=CGRectMake(0, 0, 320, 1136);
    self.bgbtn.backgroundColor=[UIColor blackColor];
    self.bgbtn.alpha=0.8;
    
    self.rateview=[[[UIImageView alloc] initWithFrame:CGRectMake(20, 170, 280, 170)] autorelease];
    self.rateview.image=[UIImage imageNamed:@"item_reduced"];
    [self.rateview setContentMode:UIViewContentModeScaleToFill];
    starView=[[RatingView alloc] initWithFrame:CGRectMake(90, 238, 150, 100)];
    [starView setImagesDeselected:@"0.png" partlySelected:@"1.png" fullSelected:@"2.png" andDelegate:self];
    [starView displayRating:5.0];
    
    [self.view addSubview:self.rateview];
    [self.view addSubview:starView];
    [self.view addSubview:self.ratebtn];
    [self.view addSubview:self.ratetitle];
    [self.view addSubview:self.bgbtn];
    [self.view bringSubviewToFront:self.bgbtn];
    [self.view bringSubviewToFront:self.rateview];
    [self.view bringSubviewToFront:self.ratebtn];
    [self.view bringSubviewToFront:starView];
    [self.view bringSubviewToFront:self.ratetitle];
    
    self.bgbtn.hidden=YES;
    self.rateview.hidden=YES;
    self.ratebtn.hidden=YES;
    starView.hidden=YES;
    self.ratetitle.hidden=YES;
    // Do any additional setup after loading the view from its nib.
    UIImage *image=[UIImage imageNamed:@"nux-red-button.png"];
    image=[image resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [self.back setBackgroundImage:image forState:UIControlStateNormal];
    // view背景设定
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Default-PortraitBlank"]];
    //  toolbar设置
    UIImage *toolBarIMG = [UIImage imageNamed: @"navbar-first"];
    //    toolBarIMG=[toolBarIMG resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    if ([self.toolBar respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)]) {
        [self.toolBar setBackgroundImage:toolBarIMG forToolbarPosition:0 barMetrics:0];
    }//设置toolbar的背景图片
    self.toolBar.layer.shadowPath=[UIBezierPath bezierPathWithRect:self.toolBar.bounds].CGPath;
    self.toolBar.layer.shadowOffset = CGSizeMake(0, 0);
    self.toolBar.layer.shadowColor = [UIColor blackColor].CGColor;
    self.toolBar.layer.shadowOpacity = 1;
    self.praise=[[[NSString alloc] init] autorelease];
    self.proid=[[[NSString alloc] init] autorelease];
    [self loaddata];
}
-(void)emptycart{
    UIImageView *image=[[[UIImageView alloc] initWithFrame:CGRectMake(80, 280, 160, 49)] autorelease];
    image.image=[UIImage imageNamed:@"category-awesome"];
    image.alpha=0.6;
    UILabel *label=[[[UILabel alloc] initWithFrame:CGRectMake(105, 300, 150, 73)] autorelease];
    label.backgroundColor=[UIColor clearColor];
    [label setTextColor:[UIColor lightGrayColor]];
    label.font=[UIFont systemFontOfSize:12];
    label.text=@"没有未签收的订单.";
    [self.view addSubview:image];
    [self.view addSubview:label];
    [self.view bringSubviewToFront:label];
    [self.view bringSubviewToFront:image];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 104.f;
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
    static NSString *CellIdentifier = @"FourSubTypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell==nil){
        cell=[[[NSBundle mainBundle] loadNibNamed:@"FourViewCell" owner:nil options:nil] lastObject];
    }
    [self.maintable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    UIView *tablebgview=[[[UIView alloc] init] autorelease];
    tablebgview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Gomall_bg_main"]];
    cell.backgroundView=tablebgview;
    
    cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Gomall_bg_main"]];
    UIImageView *cellselected=[[[UIImageView alloc] initWithFrame:cell.frame] autorelease];
    cellselected.image=[UIImage imageNamed:@"cellBackTouch"];
    //    [vie addSubview:cellselected];
    cell.selectedBackgroundView=cellselected;
    
//    [(UIImageView *)[cell viewWithTag:1] setImage:[UIImage imageNamed:[[_item objectAtIndex:indexPath.row] objectForKey:@"ProductID"]]];
    [(UIImageView *)[cell viewWithTag:1] setImageWithURL:[[_item objectAtIndex:indexPath.row] objectForKey:@"ProductImageURL"] placeholderImage:[UIImage imageNamed:@"nscd_bg"]];
    
    [(UILabel *)[cell viewWithTag:2] setText:[[_item objectAtIndex:indexPath.row] objectForKey:@"ProductName"]];
    [(UILabel *)[cell viewWithTag:3] setText:[NSString stringWithFormat:@"%d",[[[_item objectAtIndex:indexPath.row] objectForKey:@"TotalPrice"] intValue]/[[[_item objectAtIndex:indexPath.row] objectForKey:@"Quantity"] intValue]]];
    [(UILabel *)[cell viewWithTag:4] setText:[[_item objectAtIndex:indexPath.row] objectForKey:@"Quantity"]];
    [(UILabel *)[cell viewWithTag:5] setText:[[_item objectAtIndex:indexPath.row] objectForKey:@"TotalPrice"]];
    [(UILabel *)[cell viewWithTag:6] setText:[[_item objectAtIndex:indexPath.row] objectForKey:@"Date"]];
    [(UILabel *)[cell viewWithTag:7] setText:[[_item objectAtIndex:indexPath.row] objectForKey:@"Address"]];
    
   
    
    CALayer *celllayer=[(UIImageView *)[cell viewWithTag:1] layer];
    celllayer.borderColor = [[UIColor whiteColor] CGColor];
    celllayer.borderWidth = 1.5f;
    celllayer.masksToBounds=YES;
    celllayer.cornerRadius=2;
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.index=indexPath;
    self.proid=[[_item objectAtIndex:indexPath.row] objectForKey:@"ProductID"];
    XYAlertView *aler=[[XYAlertView alloc] initWithTitle:@"提示!" message:@"确认收货？" buttons:[NSArray arrayWithObjects:@"确认",@"取消",nil] afterDismiss:^(int buttonIndex) {
        if (buttonIndex==0) {
//            [self writepraise];
            
            XYInputView *inputView = [XYInputView inputViewWithPlaceholder:@"请输入你的评价"
                                                               initialText:nil buttons:[NSArray arrayWithObjects:@"取消", @"完成", nil]
                                                              afterDismiss:^(int buttonIndex, NSString *text) {
                                                                  if(buttonIndex == 1){
                                                                      NSString *Text=[NSString stringWithFormat:@"%p",text];
                                                                      if ([Text isEqualToString:@"0x0"]) {
                                                                          self.praise=@"好评!";
                                                                          [self addpraise];
                                                                      }else{
                                                                          self.praise=text;
                                                                          [self addpraise];
                                                                      }                       
                                                                      //
                                                                      
                                                                      self.rateview.hidden=NO;
                                                                      self.ratebtn.hidden=NO;
                                                                      starView.hidden=NO;
                                                                      self.ratetitle.hidden=NO;
                                                                      self.bgbtn.hidden=NO;

//                                                                      UIButton *ratebtn=[UIButton buttonWithType:UIButtonTypeCustom];
//                                                                      ratebtn.frame=CGRectMake(140, 290, 60, 30);
//                                                                      ratebtn.backgroundColor=[UIColor whiteColor];
//                                                                      ratebtn.tintColor=[UIColor whiteColor];
//                                                                      ratebtn.titleLabel.text=@"完成";
//                                                                      
//                                                                      [ratebtn addTarget:self action:@selector(rateover:) forControlEvents:UIControlEventTouchUpInside];
//                                                                      UIView *view=[[UIView alloc] initWithFrame:CGRectMake(80, 200, 155, 100)];
//                                                                      view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"m_set_bg"]];
//                                                                      starView=[[RatingView alloc] initWithFrame:CGRectMake(100, 253, 70, 40)];
//                                                                      [starView setImagesDeselected:@"0.png" partlySelected:@"1.png" fullSelected:@"2.png" andDelegate:nil];
//                                                                      [starView displayRating:1.5];
//                                                                      
//                                                                      [self.view addSubview:view];
//                                                                      [self.view addSubview:starView];
//                                                                      [self.view addSubview:ratebtn];
//                                                                      [self.view bringSubviewToFront:view];
//                                                                      [self.view bringSubviewToFront:ratebtn];
//                                                                      [self.view bringSubviewToFront:starView];
                                                                      
                                                                      //
//                                                                      [self addtofinishedorder:indexPath];
//                                                                      [self deleteonedate:indexPath];
//                                                                      [self loaddata];
//                                                                      [self.maintable reloadData];
                                                                    
                                                                  }
                                                              }];
            [inputView setButtonStyle:XYButtonStyleGreen atIndex:1];
            [inputView show];

        }
    }];
    [aler show];
    [aler release];
}
-(void)rateover:(NSIndexPath *)indexPath{
    NSLog(@"分数是%@",self.ratepoints);
    self.bgbtn.hidden=YES;
    self.rateview.hidden=YES;
    self.ratebtn.hidden=YES;
    starView.hidden=YES;
    self.ratetitle.hidden=YES;
    [self addtofinishedorder:self.index];
    [self deleteonedate:self.index];
    [self loaddata];
    [self.maintable reloadData];
}
-(void)addtofinishedorder:(NSIndexPath *)indexPath{
    NSString *date=[self GetDate];
    FMDatabase *db=[FMDatabase databaseWithPath:[self opendb]];
    if ([db open]) {
        [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO FinishOrderData(CustomerID,OrderInfo,ProductID,Quantity,TotalPrice,ProductName,Date,Address,ProductImageURL,RatePoints) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",[[NSUserDefaults standardUserDefaults] objectForKey:@"CustomerID"],[[_item objectAtIndex:indexPath.row] objectForKey:@"OrderInfo"],[[_item objectAtIndex:indexPath.row] objectForKey:@"ProductID"],[[_item objectAtIndex:indexPath.row] objectForKey:@"Quantity"],[[_item objectAtIndex:indexPath.row] objectForKey:@"TotalPrice"],[[_item objectAtIndex:indexPath.row] objectForKey:@"ProductName"],date,[[_item objectAtIndex:indexPath.row] objectForKey:@"Address"],[[_item objectAtIndex:indexPath.row] objectForKey:@"ProductImageURL"],self.ratepoints]];
    }[db close];
    [self startRequest:indexPath];//PHP 后台执行 演示！！！！
}
-(void)addpraise{
    
    NSString *date=[self GetDate];
    FMDatabase *db=[FMDatabase databaseWithPath:[self opendb]];
    if ([db open]) {
        [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO PraiseData(CustomerID,ProductID,Date,PraiseText) VALUES ('%@','%@','%@','%@')",[[NSUserDefaults standardUserDefaults] objectForKey:@"CustomerID"],self.proid,date,self.praise]];
    }[db close];
    
}
-(void)deleteonedate:(NSIndexPath *)indexPath{

    FMDatabase *db=[FMDatabase databaseWithPath:[self opendb]];
    if ([db open]) {
        [db executeUpdate:[NSString stringWithFormat:@"Delete from UnFinishOrderData where UnFinishOrderDataID='%@'",[[_item objectAtIndex:indexPath.row] objectForKey:@"UnFinishOrderDataID"]]];
    }[db close];
}

-(NSString *)opendb{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *sqlitePath = [documentDirectory stringByAppendingPathComponent:@"DataCache.sqlite"];
    return sqlitePath;
}

-(NSString *)GetDate{
    NSDate * newDate = [NSDate date];
    
    NSDateFormatter *dateformat=[[[NSDateFormatter alloc] init] autorelease];
    
    [dateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString * newDateOne = [dateformat stringFromDate:newDate];
    
    [dateformat setFormatterBehavior:NSDateFormatterFullStyle];
    
    [dateformat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    return newDateOne;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark  PHP 
-(void)startRequest:(NSIndexPath *)indexPath {
    NSString *date=[self GetDate];
    NSString *strURLpart2 = [NSString stringWithFormat:@"?Type=Add& CustomerID='%@'&OrderInfo='%@'&ProductID='%@'&Quantity='%@'&TotalPrice='%@'&ProductName='%@'&Date='%@'&Address='%@'&ProductImageURL='%@'&RatePoints='%@'",[[NSUserDefaults standardUserDefaults] objectForKey:@"CustomerID"],[[_item objectAtIndex:indexPath.row] objectForKey:@"OrderInfo"],[[_item objectAtIndex:indexPath.row] objectForKey:@"ProductID"],[[_item objectAtIndex:indexPath.row] objectForKey:@"Quantity"],[[_item objectAtIndex:indexPath.row] objectForKey:@"TotalPrice"],[[_item objectAtIndex:indexPath.row] objectForKey:@"ProductName"],date,[[_item objectAtIndex:indexPath.row] objectForKey:@"Address"],[[_item objectAtIndex:indexPath.row] objectForKey:@"ProductImageURL"],self.ratepoints];
    NSString *strURLpart1 =@"http://apple.local/DataCache_AttentionTable.php";
    strURLpart1=[strURLpart1 stringByAppendingString:[strURLpart2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];

    NSURL *url = [NSURL URLWithString:strURLpart1];

    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    if (connection) {//回调
        _datas = [NSMutableData new];
    }
}
#pragma mark- NSURLConnection 回调方法
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_datas appendData:data];
}
-(void) connection:(NSURLConnection *)connection didFailWithError: (NSError *)error {
    NSLog(@"%@",[error localizedDescription]);
}
- (void) connectionDidFinishLoading: (NSURLConnection*) connection {
    NSLog(@"请求完成…");
    
}

- (void)dealloc {
    [_toolBar release];
    [_back release];
    [_maintable release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setToolBar:nil];
    [self setBack:nil];
    [self setMaintable:nil];
    [super viewDidUnload];
}
- (IBAction)dismiss:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)ratingChanged:(float)newRating{
    self.ratepoints=[NSString stringWithFormat:@"%1.1f", newRating];
}
//- (void)writepraise{
//    XYInputView *inputView = [XYInputView inputViewWithPlaceholder:@"请输入你的评价"
//                                                       initialText:nil buttons:[NSArray arrayWithObjects:@"取消", @"完成", nil]
//                                                      afterDismiss:^(int buttonIndex, NSString *text) {
//                                                          if(buttonIndex == 1){
//                                                              NSString *Text=[NSString stringWithFormat:@"%p",text];
//                                                              if ([Text isEqualToString:@"0x0"]) {
//                                                                  self.praise=@"好评!";
//                                                                  [self addpraise];
//                                                              }else{
//                                                              self.praise=text;
//                                                                  [self addpraise];
//                                                              }
//                                                          }
//                                                      }];
//    [inputView setButtonStyle:XYButtonStyleGreen atIndex:1];
//    [inputView show];
//}
@end
