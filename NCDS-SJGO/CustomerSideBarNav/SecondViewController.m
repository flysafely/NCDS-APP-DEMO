
//
//  SeconViewController.m
//  SideBarNavDemo
//
//  Created by JianYe on 12-12-12.
//  Copyright (c) 2012年 JianYe. All rights reserved.
//

#import "SecondViewController.h"
//#import "SecondSubViewController.h"
#import "FMDatabase.h"
#import "XYAlertView.h"
#import <QuartzCore/CALayer.h>
#import "UIImageView+WebCache.h"
#import "MCSoundBoard.h"
#import "PayMentViewController.h"
//#import "QBPopupMenu.h"
@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize item=_item;
@synthesize proid=_proid;
@synthesize proname=_proname;
@synthesize carttable=_carttable;
@synthesize totalmoney=_totalmoney;
@synthesize totalvolume=_totalvolume;
@synthesize address=_address;
@synthesize addimage=_addimage;
@synthesize addtext=_addtext;
@synthesize toolBar=_toolBar;
@synthesize checkoutbtn=_checkoutbtn;
@synthesize back=_back;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    
    [self data];
    if ([_item count]==0) {
        self.carttable.hidden=YES;
        self.checkoutbtn.enabled=NO;
        [self emptycart];
    }else{
        self.checkoutbtn.enabled=YES;
    }
    UIImage *image=[UIImage imageNamed:@"nux-red-button.png"];
    image=[image resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    [self.back setBackgroundImage:image forState:UIControlStateNormal];
        
    self.addimage=[[[UIImageView alloc] initWithFrame:CGRectMake(0, 46, 311, 45)] autorelease];
    self.addimage.backgroundColor=[UIColor clearColor];
    self.addimage.image=[UIImage imageNamed:@"button_seller_offers"];
    self.addtext=[[[UITextField alloc] initWithFrame:CGRectMake(40, 57, 270, 58)] autorelease];
    self.addtext.alpha=0;
    self.addtext.returnKeyType=UIReturnKeyDone;
    self.addtext.delegate=self;
    [self.view addSubview:self.addimage];
    [self.view addSubview:self.addtext];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Default-PortraitBlank"]];
//  toolbar设置
    UIImage *toolBarIMG = [UIImage imageNamed: @"navbar-first"];
    if ([self.toolBar respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)]) {
        [self.toolBar setBackgroundImage:toolBarIMG forToolbarPosition:0 barMetrics:0];
    }//设置toolbar的背景图片
    self.toolBar.layer.shadowPath=[UIBezierPath bezierPathWithRect:self.toolBar.bounds].CGPath;
    self.toolBar.layer.shadowOffset = CGSizeMake(0, 0);
    self.toolBar.layer.shadowColor = [UIColor blackColor].CGColor;
    self.toolBar.layer.shadowOpacity = 0.7;
}

-(void)emptycart{
    UIImageView *image=[[[UIImageView alloc] initWithFrame:CGRectMake(80, 280, 160, 49)] autorelease];
    image.image=[UIImage imageNamed:@"category-awesome"];
    image.alpha=0.6;
    UILabel *label=[[[UILabel alloc] initWithFrame:CGRectMake(100, 300, 150, 73)] autorelease];
    label.backgroundColor=[UIColor clearColor];
    [label setTextColor:[UIColor lightGrayColor]];
    label.font=[UIFont systemFontOfSize:12];
    label.text=@"购物车里面还没有商品.";
    [self.view addSubview:image];
    [self.view addSubview:label];
    [self.view bringSubviewToFront:label];
    [self.view bringSubviewToFront:image];
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    [def setObject:@"0" forKey:@"cartnum"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"clearbragevalue" object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [self poppicker];
}

- (BOOL)canBecomeFirstResponder{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    self.address=self.addtext.text;
    [self.addtext resignFirstResponder];
    if ([self.address isEqualToString:@""]) {
        [self Message:@"您输入的地址有误！"];
        [self.addtext becomeFirstResponder];
    }else{
        self.address=self.addtext.text;
        XYAlertView *aler=[[XYAlertView alloc] initWithTitle:@"支付确认!" message:@"直接用余额支付？" buttons:[NSArray arrayWithObjects:@"确认", @"其他",@"取消", nil] afterDismiss:^(int buttonIndex) {
            if (buttonIndex==0) {
                [self poppicker];
                [self AddToUnfinishedOrder];
                [self checkusermoney];
            }else if (buttonIndex==1){
                PayMentViewController *pay=[[PayMentViewController alloc] init];
                pay.price=[NSString stringWithFormat:@"￥ %@",self.totalmoney.text];
                [self presentViewController:pay animated:YES completion:nil];
                [pay release];
            }else{
                [self poppicker];
                
            }
            
                        }
        ];
        [aler show];
        [aler release];
    }
    return YES;
}

-(void)data{
    [self loaddata];
    [self getname];
    int volume=0;
    int money=0;
    for (int i=0; i<[_item count]; i++) {
        volume=volume+[[[_item objectAtIndex:i] objectForKey:@"TotalNumber"] intValue];
        money=money+[[[_item objectAtIndex:i] objectForKey:@"TotalPrice"] intValue];
    }
    self.totalvolume.text=[NSString stringWithFormat:@"%d",volume];
    self.totalmoney.text=[NSString stringWithFormat:@"%d",money];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    static NSString *CellIdentifier = @"SecondSubTypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell==nil){
        cell=[[[NSBundle mainBundle] loadNibNamed:@"SecondViewCell" owner:nil options:nil] lastObject];
    }
    
    
    [(UIImageView *)[cell viewWithTag:1] setImageWithURL:[[_item objectAtIndex:indexPath.row] objectForKey:@"ProductImageURL"] placeholderImage:[UIImage imageNamed:@"nscd_bg"]];
    
    [(UILabel *)[cell viewWithTag:2] setText:[_proname objectAtIndex:indexPath.row]];
    [(UILabel *)[cell viewWithTag:3] setText:[NSString stringWithFormat:@"%d",[[[_item objectAtIndex:indexPath.row] objectForKey:@"TotalPrice"] intValue]/[[[_item objectAtIndex:indexPath.row] objectForKey:@"TotalNumber"] intValue]]];
    [(UILabel *)[cell viewWithTag:4] setText:[[_item objectAtIndex:indexPath.row] objectForKey:@"TotalNumber"]];
    [(UILabel *)[cell viewWithTag:5] setText:[[_item objectAtIndex:indexPath.row] objectForKey:@"TotalPrice"]];

    [self.carttable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    UIView *tablebgview=[[[UIView alloc] init] autorelease];
    tablebgview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Gomall_bg_main"]];
    
    cell.backgroundView=tablebgview;
    cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Gomall_bg_main"]];

    UIImageView *cellselected=[[[UIImageView alloc] initWithFrame:cell.frame] autorelease];
    cellselected.image=[UIImage imageNamed:@"cellBackTouch"];

    cell.selectedBackgroundView=cellselected;
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


 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {

 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
    
     XYAlertView *aler=[[XYAlertView alloc] initWithTitle:@"确认操作!" message:@"确认从购物车中删除？" buttons:[NSArray arrayWithObjects:@"确认", @"取消", nil] afterDismiss:^(int buttonIndex) {
         if (buttonIndex==0) {
             NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     NSString *documentDirectory = [paths objectAtIndex:0];
     NSString *sqlitePath = [documentDirectory stringByAppendingPathComponent:@"DataCache.sqlite"];
     FMDatabase *usercartdb=[FMDatabase databaseWithPath:sqlitePath];
     if ([usercartdb open]) {
//         NSLog(@"**********%@",[[_item objectAtIndex:indexPath.row ]objectForKey:@"UserCartDataID"]);
         [usercartdb executeUpdate:[NSString stringWithFormat:@"Delete from UserCartData where UserCartDataID='%@'",[[_item objectAtIndex:indexPath.row ]objectForKey:@"UserCartDataID"]]];
          }[usercartdb close];
             [MCSoundBoard playSoundForKey:@"deleteclick"];
     [self data];
     [self.carttable reloadData];
             NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
             [def setObject:[NSString stringWithFormat:@"%d",[[[NSUserDefaults standardUserDefaults] objectForKey:@"cartnum"] intValue]-1] forKey:@"cartnum"];
             [[NSNotificationCenter defaultCenter] postNotificationName:@"deletebragevalue" object:nil];
         }
     }];
     [aler show];
     [aler release];

 }
// else if (editingStyle == UITableViewCellEditingStyleInsert) {
// }
 }
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删 除";
}

#pragma mark - Table view delegate
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
////    UITouch *Touch = [touches anyObject];
////    [Touch retain];
//    touch=[touches anyObject];
//    [touch retain];
////    [self returntouch:touch];
//}
//-(void)returntouch:(UITouch *)gettouch{
//    touch=gettouch;
//}
//-(void)returnviewtouchY:(float)touchview{
//    y=touchview;
//}
//-(void)returnviewtouchX:(float)touchview{
//    x=touchview;
//    
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self returntouch:touch];
//    [self returnviewtouchX:[touch locationInView:self.view].x];
//    [self returnviewtouchY:[touch locationInView:self.view].y];
//    NSLog(@"%f,%f",x,y);
//    
//    [self.popupMenu showInView:self.view atPoint:CGPointMake(x, y)];
    NSString *info=[NSString stringWithFormat:@"该商品的选购信息：%@",[[[[_item objectAtIndex:indexPath.row] objectForKey:@"OrderInfo"] stringByReplacingOccurrencesOfString:@",(null)" withString:@""] stringByReplacingOccurrencesOfString:@"(null)" withString:@"无"]];
XYAlertView *aler=[[XYAlertView alloc] initWithTitle:@"信息确认!" message:info buttons:[NSArray arrayWithObjects:@"确认", nil] afterDismiss:^(int buttonIndex) {
}];
    [aler show];
    [aler release];
}
-(void)loaddata{
    _item=[[NSMutableArray alloc] initWithCapacity:5];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *sqlitePath = [documentDirectory stringByAppendingPathComponent:@"DataCache.sqlite"];
    NSLog(@"%@",sqlitePath);
    FMDatabase *usercartdb=[FMDatabase databaseWithPath:sqlitePath];
    if ([usercartdb open]) {
        FMResultSet *proincart=[usercartdb executeQuery:[NSString stringWithFormat:@"select * from UserCartData where CustomerID='%@'",[[NSUserDefaults standardUserDefaults] objectForKey:@"CustomerID"]]];
        while ([proincart next]) {
            NSMutableDictionary *dict=[NSMutableDictionary dictionary];
            [dict setObject:[proincart stringForColumn:@"ProductID"] forKey:@"ProductID"];
            [dict setObject:[proincart stringForColumn:@"OrderInfo"] forKey:@"OrderInfo"];
            [dict setObject:[proincart stringForColumn:@"TotalNumber"] forKey:@"TotalNumber"];
            [dict setObject:[proincart stringForColumn:@"TotalPrice"] forKey:@"TotalPrice"];
            [dict setObject:[proincart stringForColumn:@"UserCartDataID"] forKey:@"UserCartDataID"];
            [dict setObject:[proincart stringForColumn:@"ProductImageURL"] forKey:@"ProductImageURL"];
            [_item addObject:dict];
        }[proincart close];
    }[usercartdb close];
}
-(void)getname{
    _proid=[[NSMutableArray alloc] initWithCapacity:10];
    _proname=[[NSMutableArray alloc] initWithCapacity:10];
    for (int i=0; i<[_item count]; i++) {
       [_proid addObject:[[_item objectAtIndex:i] objectForKey:@"ProductID"]];
    }
    for (int i=0; i<[_item count]; i++) {
        FMDatabase *db=[FMDatabase databaseWithPath:[[NSBundle mainBundle] pathForResource:@"SJGOData" ofType:@"sqlite"]];
        if ([db open]) {
            FMResultSet *getname=[db executeQuery:[NSString stringWithFormat:@"select ProductName from ProductData where ProductID='%@'",[_proid objectAtIndex:i]]];
            while ([getname next]) {
                [_proname addObject:[getname stringForColumn:@"ProductName"]];
            }[getname close];
        }[db close];
    }
}

- (void)dealloc {
    [_carttable release];
    [_totalvolume release];
    [_totalmoney release];
    [_toolBar release];
    [_checkoutbtn release];
    [_back release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setCarttable:nil];
    [self setTotalvolume:nil];
    [self setTotalmoney:nil];
    [self setToolBar:nil];
    [self setCheckoutbtn:nil];
    [self setBack:nil];
    [super viewDidUnload];
}
-(void)poppicker{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];//动画时间长度，单位秒，浮点数
    self.addimage.frame = CGRectMake(-320, 46, 311, 45);
    self.addtext.frame=CGRectMake(320, 57, 320, 58);
    [self.addtext resignFirstResponder];
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
    
}
-(void)pushpicker{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.3];//动画时间长度，单位秒，浮点数
    self.addimage.frame = CGRectMake(0, 46, 311, 45);
    self.addtext.alpha=1;
    self.addtext.frame=CGRectMake(40, 57, 270, 58);
    [MCSoundBoard playSoundForKey:@"pickerup"];
    
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
    [self.addtext becomeFirstResponder];
}

- (IBAction)CheckOut:(UIButton *)sender {
    
    XYAlertView *aler=[[XYAlertView alloc] initWithTitle:@"提示!" message:@"请输入您的收货地址." buttons:[NSArray arrayWithObjects:@"确认",@"取消",nil] afterDismiss:^(int buttonIndex) {
        if (buttonIndex==0) {
          [self pushpicker];  
        }
    }];
    [aler show];
    [aler release];
    
}
-(void)AddToUnfinishedOrder{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *sqlitePath = [documentDirectory stringByAppendingPathComponent:@"DataCache.sqlite"];
    FMDatabase *addtounfinishorderdb=[FMDatabase databaseWithPath:sqlitePath];
    NSString *date=[self GetDate];
    if ([addtounfinishorderdb open]) {
        for (int i=0; i<[_item count]; i++) {
        [addtounfinishorderdb executeUpdate:[NSString stringWithFormat:@"INSERT INTO UnFinishOrderData(CustomerID,OrderInfo,ProductID,Quantity,TotalPrice,ProductName,Date,Address,ProductImageURL) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@')",[[NSUserDefaults standardUserDefaults] objectForKey:@"CustomerID"],[[_item objectAtIndex:i] objectForKey:@"OrderInfo"],[[_item objectAtIndex:i] objectForKey:@"ProductID"],[[_item objectAtIndex:i] objectForKey:@"TotalNumber"],[[_item objectAtIndex:i] objectForKey:@"TotalPrice"],[_proname objectAtIndex:i],date,_address,[[_item objectAtIndex:i] objectForKey:@"ProductImageURL"]]];
        }
    }[addtounfinishorderdb close];
    [MCSoundBoard playSoundForKey:@"checkout"];
    
}
-(void)Message:(NSString *)message{
    XYAlertView *aler=[[XYAlertView alloc] initWithTitle:@"提示" message:message buttons:[NSArray arrayWithObjects:@"确定",nil] afterDismiss:nil];
    [aler show];
    [aler release];
}

-(void)checkusermoney{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *sqlitePath = [documentDirectory stringByAppendingPathComponent:@"DataCache.sqlite"];
    FMDatabase *urdb=[FMDatabase databaseWithPath:sqlitePath];
    if ([urdb open]) {
        FMResultSet *urresult=[urdb executeQuery:[NSString stringWithFormat:@"select * from CustomerData where CustomerID='%@'",[[NSUserDefaults standardUserDefaults] objectForKey:@"CustomerID"]]];
        if ([urresult next]) {
            NSString *money=[urresult stringForColumn:@"UserMoney"];
            NSString *points=[urresult stringForColumn:@"TotalPoint"];
            
            if ([money intValue]>=[self.totalmoney.text intValue]) {
             
            NSString *updatemoney=[NSString stringWithFormat:@"%d",([money intValue]-[self.totalmoney.text intValue])];
                NSString *updatepoints=[NSString stringWithFormat:@"%d",([points intValue]+[self.totalvolume.text intValue])];
            [urdb executeUpdate:[NSString stringWithFormat:@"UPDATE CustomerData SET UserMoney='%@' where CustomerID='%@'",updatemoney,[[NSUserDefaults standardUserDefaults] objectForKey:@"CustomerID"]]];
                [urdb executeUpdate:[NSString stringWithFormat:@"UPDATE CustomerData SET TotalPoint='%@' where CustomerID='%@'",updatepoints,[[NSUserDefaults standardUserDefaults] objectForKey:@"CustomerID"]]];
                XYAlertView *aler=[[XYAlertView alloc] initWithTitle:@"提示!" message:@"交易成功！" buttons:[NSArray arrayWithObjects:@"确认", nil] afterDismiss:^(int buttonIndex) {
                    if (buttonIndex==0) {
                        [self EmptyCart];
                    }
                }];
                [aler show];
                [aler release];
            }else{
                [self Message:@"您账户的余额不足!请充值."];
            }
        }[urresult close];
    }[urdb close];
    
}
-(void)EmptyCart{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *sqlitePath = [documentDirectory stringByAppendingPathComponent:@"DataCache.sqlite"];
    FMDatabase *usercartdb=[FMDatabase databaseWithPath:sqlitePath];
    if ([usercartdb open]) {
        [usercartdb executeUpdate:[NSString stringWithFormat:@"Delete from UserCartData where CustomerID='%@'",[[NSUserDefaults standardUserDefaults] objectForKey:@"CustomerID"]]];
    }[usercartdb close];
    [self data];
    [self.carttable reloadData];
    self.checkoutbtn.enabled=NO;
    [self emptycart];
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
@end
