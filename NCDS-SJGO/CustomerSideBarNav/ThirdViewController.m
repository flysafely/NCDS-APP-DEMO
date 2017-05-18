//
//  ThirdViewController.m
//  NCDS-SJGO
//
//  Created by 徐子迈 on 13-1-2.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import "ThirdViewController.h"
#import "ThirdSubViewController.h"
#import <QuartzCore/CALayer.h>
#import "FMDatabase.h"
#import "XYAlertView.h"
#import "UIImageView+WebCache.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController
@synthesize maintable=_maintable;
@synthesize item=_item;
@synthesize toolBar=_toolBar;
@synthesize back=_back;

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
        FMResultSet *result=[db executeQuery:[NSString stringWithFormat:@"select * from FinishOrderData where CustomerID='%@'",[[NSUserDefaults standardUserDefaults] objectForKey:@"CustomerID"]]];
        while ([result next]) {
            NSMutableDictionary *dic=[NSMutableDictionary dictionary];
            [dic setObject:[result stringForColumn:@"FinishOrderDataID"] forKey:@"FinishOrderDataID"];
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
//    NSLog(@"%@",[[_item objectAtIndex:0] objectForKey:@"Quantity"]);
//     NSLog(@"%@",[[_item objectAtIndex:0] objectForKey:@"ProductID"]);
//     NSLog(@"%@",[[_item objectAtIndex:0] objectForKey:@"CustomerID"]);
//     NSLog(@"%@",[[_item objectAtIndex:0] objectForKey:@"Date"]);
//     NSLog(@"%@",[[_item objectAtIndex:0] objectForKey:@"OrderInfo"]);
//     NSLog(@"%@",[[_item objectAtIndex:0] objectForKey:@"ProductName"]);
//     NSLog(@"%@",[[_item objectAtIndex:0] objectForKey:@"TotalPrice"]);
//    NSLog(@"%@",[[_item objectAtIndex:0] objectForKey:@"Address"]);
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
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
    [self loaddata];
    if ([_item count]==0) {
        self.maintable.hidden=YES;
        [self emptycart];
    }
}
-(void)emptycart{
    UIImageView *image=[[[UIImageView alloc] initWithFrame:CGRectMake(80, 280, 160, 49)] autorelease];
    image.image=[UIImage imageNamed:@"category-awesome"];
    image.alpha=0.6;
    UILabel *label=[[[UILabel alloc] initWithFrame:CGRectMake(105, 300, 150, 73)] autorelease];
    label.backgroundColor=[UIColor clearColor];
    [label setTextColor:[UIColor lightGrayColor]];
    label.font=[UIFont systemFontOfSize:12];
    label.text=@"没有已完成的订单.";
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
    static NSString *CellIdentifier = @"ThirdViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell==nil){
        cell=[[[NSBundle mainBundle] loadNibNamed:@"ThirdViewCell" owner:nil options:nil] lastObject];
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
  
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)pushtosub:(UIButton *)sender {
    ThirdSubViewController *sub=[[[ThirdSubViewController alloc] init] autorelease];
    [self.navigationController pushViewController:sub animated:YES];
}
- (void)dealloc {
    [_maintable release];
    [_toolBar release];
    [_back release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMaintable:nil];
    [self setToolBar:nil];
    [self setBack:nil];
    [super viewDidUnload];
}
- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
