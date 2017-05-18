//
//  AttentionViewController.m
//  NCDS-SJGO
//
//  Created by Mofioso on 13-4-25.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import "AttentionViewController.h"
#import <QuartzCore/CALayer.h>
#import "ListItem.h"
#import "FMDatabase.h"
#import "XYAlertView.h"
@interface AttentionViewController ()
@end

@implementation AttentionViewController
@synthesize topimage=_topimage;
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
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"CheckStatus"] isEqualToString:@"未登录"]) {
//        self.isonline=NO;
//    }else{
//        self.isonline=YES;
//    }
     self.topimage.frame=CGRectMake(0, 100, 320, 67);
    //数据获得
    Datalist=[[NSMutableArray alloc] initWithCapacity:10];
    DataList1=[[NSMutableArray alloc] initWithCapacity:50];
    DataList2=[[NSMutableArray alloc] initWithCapacity:50];
    DataList3=[[NSMutableArray alloc] initWithCapacity:50];
    DataList4=[[NSMutableArray alloc] initWithCapacity:50];
    DataList5=[[NSMutableArray alloc] initWithCapacity:50];
    DataList6=[[NSMutableArray alloc] initWithCapacity:50];
    //Listitem生成
    List1=[[NSMutableArray alloc] initWithCapacity:50];
    List2=[[NSMutableArray alloc] initWithCapacity:50];
    List3=[[NSMutableArray alloc] initWithCapacity:50];
    List4=[[NSMutableArray alloc] initWithCapacity:50];
    List5=[[NSMutableArray alloc] initWithCapacity:50];
    List6=[[NSMutableArray alloc] initWithCapacity:50];
    
    
    UIImage *toolBarIMG = [UIImage imageNamed: @"navbar-first"];
    if ([self.toolBar respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)]) {
        [self.toolBar setBackgroundImage:toolBarIMG forToolbarPosition:0 barMetrics:0];
    }
    self.toolBar.layer.shadowPath=[UIBezierPath bezierPathWithRect:self.toolBar.bounds].CGPath;
    self.toolBar.layer.shadowOffset = CGSizeMake(0, 0);
    self.toolBar.layer.shadowColor = [UIColor blackColor].CGColor;
    self.toolBar.layer.shadowOpacity = 0.8;
    
    [self GotData];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
   
    [self performSelector:@selector(movetopimage2) withObject:nil afterDelay:0.7];
}
-(void)viewDidAppear:(BOOL)animated{
    [MCSoundBoard playSoundForKey:@"attention"];
}
-(void)movetopimage2{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.8];//动画时间长度，单位秒，浮点数
    self.topimage.frame=CGRectMake(0, 23, 320, 67);
    
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
    //    [self.a setContentOffset:CGPointMake(0, -20) animated:YES];
    
}
#pragma mark table
- (int)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 155.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    NSString *title = @"";
    POHorizontalList *list;
    
    if ([indexPath row] == 0) {
        title = @"运动户外";
        if (List1!=nil) {
            
        list = [[[POHorizontalList alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 155.0) title:title items:List1] autorelease];
        list.delegate=self;
            UIImageView *image=[[[UIImageView alloc] initWithFrame:CGRectMake(0, -15, 320, 15)] autorelease];
            image.image=[UIImage imageNamed:@"shop-shelf-alt"];
        [cell.contentView addSubview:list];
            [cell.contentView addSubview:image];
        }
    }
    if ([indexPath row] == 1) {
        title = @"家居用品";
        if (List2!=nil) {
            
        
        list = [[[POHorizontalList alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 155.0) title:title items:List2] autorelease];
        list.delegate=self;
        [cell.contentView addSubview:list];
        }
    }
    if ([indexPath row] == 2) {
        title = @"男装";
        if (List3!=nil) {
            
            
            list = [[[POHorizontalList alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 155.0) title:title items:List3] autorelease];
            list.delegate=self;
            [cell.contentView addSubview:list];
        }
    }
    if ([indexPath row] == 3) {
        title = @"女装";
        if (List4!=nil) {
            
            
            list = [[[POHorizontalList alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 155.0) title:title items:List4] autorelease];
            list.delegate=self;
            [cell.contentView addSubview:list];
        }
    }
    if ([indexPath row] == 4) {
        title = @"淑女装";
        if (List5!=nil) {
            
            
            list = [[[POHorizontalList alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 155.0) title:title items:List5] autorelease];
            list.delegate=self;
            [cell.contentView addSubview:list];
        }
    }
    if ([indexPath row] == 5) {
        title = @"化妆品";
        if (List6!=nil) {
            
            
            list = [[[POHorizontalList alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 155.0) title:title items:List6] autorelease];
            list.delegate=self;
            [cell.contentView addSubview:list];
        }
    }
    
    return cell;
}
-(void)GotData{

    FMDatabase *db=[FMDatabase databaseWithPath:[[NSBundle mainBundle] pathForResource:@"SJGOData" ofType:@"sqlite"]];
    if ([db open]) {
        for (int i=1; i<7; i++) {
            FMResultSet *result=[db executeQuery:[NSString stringWithFormat:@"select * from BrandTable where BrandFloor='%d'",i]];
            while ([result next]) {
                
            NSMutableDictionary *dic=[NSMutableDictionary dictionary];
            [dic setObject:[result stringForColumn:@"BrandID"] forKey:@"BrandID"];
            [dic setObject:[result stringForColumn:@"BrandName"] forKey:@"BrandName"];
            switch (i) {
                case 1:
                    [DataList1 addObject:dic];
                    break;
                case 2:
                    [DataList2 addObject:dic];
                    break;
                case 3:
                    [DataList3 addObject:dic];
                    break;
                case 4:
                    [DataList4 addObject:dic];
                    break;
                case 5:
                    [DataList5 addObject:dic];
                    break;
                case 6:
                    [DataList6 addObject:dic];
                    break;
                default:
                    break;
            }
            }[result close];
        }
    
    }[db close];
    for (int i=0; i<6; i++) {
        switch (i) {
            case 0:
                if (DataList1!=nil) {
                    [Datalist addObject:DataList1];
                }else{
                    [Datalist addObject:@"nil"];
                }
                break;
            case 1:
                if (DataList2!=nil) {
                    [Datalist addObject:DataList2];
                }else{
                    [Datalist addObject:@"nil"];
                }
                break;
            case 2:
                if (DataList3!=nil) {
                    [Datalist addObject:DataList3];
                }else{
                    [Datalist addObject:@"nil"];
                }
                break;
            case 3:
                if (DataList4!=nil) {
                    [Datalist addObject:DataList4];
                }else{
                    [Datalist addObject:@"nil"];
                }
                break;
            case 4:
                if (DataList5!=nil) {
                    [Datalist addObject:DataList5];
                }else{
                    [Datalist addObject:@"nil"];
                }
                break;
            case 5:
                if (DataList6!=nil) {
                    [Datalist addObject:DataList6];
                }else{
                    [Datalist addObject:@"nil"];
                }
                break;
            default:
                break;
    }
}
    [self FillList];
}
-(void)FillList{
    
    for (int i=1; i<7; i++) {
        int m;
        m=[[Datalist objectAtIndex:i-1] count];
        
        for (int j=0; j<m; j++) {
            if ([Datalist objectAtIndex:i]!=nil) {
                switch (i) {
                    case 1:
                        [List1 addObject:[self CreateBrandItem:[[[Datalist objectAtIndex:i-1] objectAtIndex:j] objectForKey:@"BrandID"] BrandName:[[[Datalist objectAtIndex:i-1] objectAtIndex:j] objectForKey:@"BrandName"] IsOnline:self.isonline]];
                        break;
                    case 2:
                        [List2 addObject:[self CreateBrandItem:[[[Datalist objectAtIndex:i-1] objectAtIndex:j] objectForKey:@"BrandID"] BrandName:[[[Datalist objectAtIndex:i-1] objectAtIndex:j] objectForKey:@"BrandName"] IsOnline:self.isonline]];
                        break;
                    case 3:
                        [List3 addObject:[self CreateBrandItem:[[[Datalist objectAtIndex:i-1] objectAtIndex:j] objectForKey:@"BrandID"] BrandName:[[[Datalist objectAtIndex:i-1] objectAtIndex:j] objectForKey:@"BrandName"] IsOnline:self.isonline]];
                        break;
                    case 4:
                        [List4 addObject:[self CreateBrandItem:[[[Datalist objectAtIndex:i-1] objectAtIndex:j] objectForKey:@"BrandID"] BrandName:[[[Datalist objectAtIndex:i-1] objectAtIndex:j] objectForKey:@"BrandName"] IsOnline:self.isonline]];
                        break;
                    case 5:
                        [List5 addObject:[self CreateBrandItem:[[[Datalist objectAtIndex:i-1] objectAtIndex:j] objectForKey:@"BrandID"] BrandName:[[[Datalist objectAtIndex:i-1] objectAtIndex:j] objectForKey:@"BrandName"] IsOnline:self.isonline]];
                        break;
                    case 6:
                        [List6 addObject:[self CreateBrandItem:[[[Datalist objectAtIndex:i-1] objectAtIndex:j] objectForKey:@"BrandID"] BrandName:[[[Datalist objectAtIndex:i-1] objectAtIndex:j] objectForKey:@"BrandName"] IsOnline:self.isonline]];
                        break;
                        
                    default:
                        break;
                }
            }
           
        }
    }
}
-(ListItem *)CreateBrandItem:(NSString *)itemimage BrandName:(NSString *)itemname IsOnline:(BOOL)isonline{
    if (!isonline) {
    ListItem *item = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",itemimage]] text:itemname BrandID:itemimage];
    item.delegate=self;
    return item;
    }else{
        FMDatabase *db=[FMDatabase databaseWithPath:[self getdbpath]];
        if ([db open]) {
            FMResultSet *result=[db executeQuery:[NSString stringWithFormat:@"select * from AttentionTable where CustomerID ='%@'",[[NSUserDefaults standardUserDefaults] objectForKey:@"CustomerID"]]];
            int m=0;
            while ([result next]) {
                if ([[result stringForColumn:@"BrandID"] isEqualToString:itemimage]) {
                    m++;
                }
            }
            if (m==0) {
                ListItem *item = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",itemimage]] text:itemname BrandID:itemimage];
                item.delegate=self;
                item.isfocused=NO;
                [item.focus setTitle:@"关注" forState:UIControlStateNormal];
                return item;
            }else{
                ListItem *item = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",itemimage]] text:itemname BrandID:itemimage];
                item.delegate=self;
                item.isfocused=YES;
                [item.focus setTitle:@"取消关注" forState:UIControlStateNormal];
                //                    item.focus.titleLabel.textAlignment=NSTextAlignmentCenter;
                return item;
            }

            [result close];
        }else{
            ListItem *item = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",itemimage]] text:itemname BrandID:itemimage];
            item.delegate=self;
            return item;
        }
        [db close];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) didSelectItem:(ListItem *)item{
    
}
-(void)focusonthebrand:(ListItem *)item{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"CheckStatus"] isEqualToString:@"未登录"]) {
        XYAlertView *alert=[[[XYAlertView alloc] initWithTitle:@"抱歉！" message:@"您还没有登录！" buttons:[NSArray       arrayWithObjects:@"确定", nil] afterDismiss:^(int buttonIndex) {
            if (buttonIndex==0) {
                item.isfocused=NO;
                [item.focus setTitle:@"关注" forState:UIControlStateNormal];
            }
        }] autorelease];
        [alert show];
    }else{
        
    if (item.isfocused) {
        NSLog(@"你关注了%@",item.imageTitle);
        [self AddBrand:item];
    }else{
        NSLog(@"你取消关注了%@",item.imageTitle);
        [self DeleteBrand:item];
    }
    }
}
-(NSString *)getdbpath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *sqlitePath = [documentDirectory stringByAppendingPathComponent:@"DataCache.sqlite"];
    return sqlitePath;
}
-(void)AddBrand:(ListItem *)item{

        FMDatabase *db=[FMDatabase databaseWithPath:[self getdbpath]];
        if ([db open]) {
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO AttentionTable(CustomerID,BrandID,BrandName,Date) VALUES ('%@','%@','%@','%@')",[[NSUserDefaults standardUserDefaults] objectForKey:@"CustomerID"],item.brandid,item.imageTitle,[self GetDate]]];

        }[db close];
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
-(void)DeleteBrand:(ListItem *)item{

        FMDatabase *db=[FMDatabase databaseWithPath:[self getdbpath]];
        if ([db open]) {
//            FMResultSet *resulet=[db executeQuery:[NSString stringWithFormat:@"select * from AttentionTable where CustomerID='%@'",[[NSUserDefaults standardUserDefaults] objectForKey:@"CustomerID"]]];
//            while ([resulet next]) {
//                NSString *
//            }
            [db executeUpdate:[NSString stringWithFormat:@"Delete from AttentionTable where BrandID='%@' and CustomerID='%@'",item.brandid,[[NSUserDefaults standardUserDefaults] objectForKey:@"CustomerID"]]];
    
            NSLog(@"sql:%@",[NSString stringWithFormat:@"Delete from AttentionTable where BrandID='%@' and CustomerID='%@'",item.brandid,[[NSUserDefaults standardUserDefaults] objectForKey:@"CustomerID"]]);
        }[db close];
    
}
- (void)dealloc {
    [_toolBar release];
    [_topimage release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setToolBar:nil];
    [self setTopimage:nil];
    [super viewDidUnload];
}
- (IBAction)Back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
