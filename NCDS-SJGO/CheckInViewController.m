//
//  CheckInViewController.m
//  NCDS-SJGO
//
//  Created by Mofioso on 13-4-16.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import "CheckInViewController.h"
#import "FMDatabase.h"
#import "XYAlertView.h"
#import <CoreGraphics/CGAffineTransform.h>
#import <QuartzCore/CALayer.h>
#import "UIView+Origami.h"

#define place1Latitude 38.018421
#define place1Longitude 114.545528

#define kDeg2Rad 0.0174532925
#define kRad2Deg 57.2957795
@interface CheckInViewController ()
@property float high;
@property BOOL MapOpening;
@end

@implementation CheckInViewController
@synthesize Distance=_Distance;
@synthesize Locman=_Locman;
@synthesize PlaceTable=_PlaceTable;
@synthesize item=_item;
@synthesize data=_data;
@synthesize distancemeter=_distancemeter;
@synthesize toolBar=_toolBar;
@synthesize back=_back;
@synthesize brray=_brray;
@synthesize recentLocation=_recentLocation;
@synthesize latitude=_latitude;
@synthesize longtitude=_longtitude;
@synthesize headingdata=_headingdata;
@synthesize shadow=_shadow;
@synthesize MapView=_MapView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)showMap{
    
    [self.shadow setHidden:NO];
    [self.PlaceTable showOrigamiTransitionWith:self.MapView
                                 NumberOfFolds:2
                                      Duration:0.6
                                     Direction:XYOrigamiDirectionFromLeft
                                    completion:^(BOOL finished) {
                                        self.MapOpening=YES;
                                    }];
}
- (void)hideMap{
    [self.shadow setHidden:YES];
    [self.PlaceTable hideOrigamiTransitionWith:self.MapView
                                 NumberOfFolds:2
                                      Duration:0.6
                                     Direction:XYOrigamiDirectionFromLeft
                                    completion:^(BOOL finished) {
                                        self.MapOpening=NO;
                                    }];
}
-(void)locationmapwithlatitude:(float)latitude longtitude:(float)longtitude Title:(NSString *)title Subtitle:(NSString *)subtitle{
    MKCoordinateRegion mapRegion;
    mapRegion.center.latitude=latitude;
    mapRegion.center.longitude=longtitude;
    mapRegion.span.latitudeDelta=0.008;
    mapRegion.span.longitudeDelta=0.008;
    [_MapView setRegion:mapRegion animated:YES];

    CLLocationCoordinate2D workingCoordinate;
	workingCoordinate.latitude = latitude;
	workingCoordinate.longitude = longtitude;
    
	iCodeBlogAnnotation *annotation = [[[iCodeBlogAnnotation alloc] initWithCoordinate:workingCoordinate] autorelease];
    
	[annotation setTitle:title];
	[annotation setSubtitle:subtitle];
	[annotation setAnnotationType:iCodeBlogAnnotationTypeApple];
    
	[self.MapView addAnnotation:annotation];
    [self showMap];
}
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if ([annotation.title isEqualToString:@"Current Location"]) {
        MKPinAnnotationView *pinDrop=[[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myspot"] autorelease];
        pinDrop.animatesDrop=YES;
        pinDrop.canShowCallout=YES;
        pinDrop.pinColor=MKPinAnnotationColorGreen;
        return  pinDrop;
    }else{
        MKPinAnnotationView *pinDrop=[[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myspot"] autorelease];
        pinDrop.animatesDrop=YES;
        pinDrop.canShowCallout=YES;
        pinDrop.pinColor=MKPinAnnotationColorRed;
        return  pinDrop;
    }
}
-(void)LoadData{
    _item=[[NSMutableArray alloc] initWithCapacity:5];
    FMDatabase *db=[FMDatabase databaseWithPath:[[NSBundle mainBundle] pathForResource:@"SJGOData" ofType:@"sqlite"]];
    if ([db open]) {
        FMResultSet *dbresult=[db executeQuery:[NSString stringWithFormat:@"SELECT * FROM LocationInfo"]];
        while ([dbresult next]) {
            NSMutableDictionary * dic=[NSMutableDictionary dictionary];
            [dic setObject:[dbresult stringForColumn:@"PlaceDesc"] forKey:@"PlaceDesc"];
            [dic setObject:[dbresult stringForColumn:@"PlaceName"] forKey:@"PlaceName"];
            [dic setObject:[dbresult stringForColumn:@"PlaceLatitudeForMap"] forKey:@"PlaceLatitude"];
            [dic setObject:[dbresult stringForColumn:@"PlaceLongitudeForMap"] forKey:@"PlaceLongitude"];
            [dic setObject:[dbresult stringForColumn:@"PlaceLatitudeForSatellite"] forKey:@"PlaceLatitudeForSatellite"];
            [dic setObject:[dbresult stringForColumn:@"PlaceLongitudeForSatellite"] forKey:@"PlaceLongitudeForSatellite"];
            [_item addObject:dic];
        }[dbresult close];
    }[db close];
    NSLog(@"_item count %d",[_item count]);
}

- (void)viewDidLoad
{
    self.shadow.hidden=YES;
    self.MapOpening=NO;
//    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Mapiphone"]]];
    UIImage *image=[UIImage imageNamed:@"nux-red-button.png"];
    image=[image resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    [self.back setBackgroundImage:image forState:UIControlStateNormal];
    UIImage *toolBarIMG = [UIImage imageNamed: @"navbar-first"];
    if ([self.toolBar respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)]) {
        [self.toolBar setBackgroundImage:toolBarIMG forToolbarPosition:0 barMetrics:0];
    }//设置toolbar的背景图片
//    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    [self.PlaceTable setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Mapiphone-table.png"]]];

    [self LoadData];
    
    self.Locman=[[CLLocationManager alloc] init];
    self.Locman.delegate=self;
    self.Locman.desiredAccuracy=kCLLocationAccuracyBest;
    self.Locman.distanceFilter=1;//移动1m  获取一次新的位置信息
        [self.Locman startUpdatingLocation];
    
    //方向控制
//    if ([CLLocationManager headingAvailable]) {
//        self.Locman.headingFilter=2;
//        [self.Locman startUpdatingHeading];
//    }
    
    //Mapview添加手势
//    UITapGestureRecognizer *press=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(movemapview)];
//    press.delegate=self;
//    press.numberOfTapsRequired=1;
//    
//    [self.MapView addGestureRecognizer:press];
    self.MapView.userInteractionEnabled=YES;
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated{
    
//    MKCoordinateRegion mapRegion;
//    mapRegion.center.latitude=self.recentLocation.coordinate.latitude;
//    mapRegion.center.longitude=self.recentLocation.coordinate.longitude;
//    mapRegion.span.latitudeDelta=0.2;
//    mapRegion.span.longitudeDelta=0.2;
//    [_MapView setRegion:mapRegion animated:YES];
//    MKPlacemark *mymarker;
//    mymarker=[[MKPlacemark alloc] initWithCoordinate:self.recentLocation.coordinate addressDictionary:nil];
//    
//    [self.MapView addAnnotation:mymarker];
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if (error.code == kCLErrorDenied) {
        [self.Locman stopUpdatingLocation];
        [self setLocman:nil];
    }
}

-(void)OrderThePlace{

    _brray=[[NSMutableArray alloc] initWithObjects:nil];
    if ([_distancemeter lastObject]!=nil) {
        
        for (int i=0; i<[_distancemeter count]; i++) {
            NSNumber *c=[[[NSNumber alloc] initWithInteger:(i)] autorelease];
            
            [_brray addObject:c];
        }
        
        for (int i=0; i<[_distancemeter count]-1; i++) {
            int m=i;
            for (int j=1+i; j<[_distancemeter count]; j++) {
                if ([[_distancemeter objectAtIndex:j] intValue]<=[[_distancemeter objectAtIndex:m] intValue]) {
                    m=j;
                }
            }
            [_distancemeter exchangeObjectAtIndex:m withObjectAtIndex:i];
            [_brray exchangeObjectAtIndex:m withObjectAtIndex:i];
            
        }
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    _data=[[NSMutableArray alloc] initWithCapacity:10];
    _distancemeter=[[NSMutableArray alloc] initWithCapacity:10];
    
    _latitude=[[NSMutableArray alloc] initWithCapacity:50];
    _longtitude=[[NSMutableArray alloc] initWithCapacity:50];
    //测试用数据
//    CLLocation *text=[[CLLocation alloc] initWithLatitude:place1Latitude longitude:place1Longitude];
    if (newLocation.horizontalAccuracy >=0) {
        self.recentLocation=newLocation;
        for (int i=0; i<[_item count]; i++) {
             CLLocation *Place1=[[[CLLocation alloc] initWithLatitude:[[[_item objectAtIndex:i] objectForKey:@"PlaceLatitudeForSatellite"] doubleValue] longitude:[[[_item objectAtIndex:i] objectForKey:@"PlaceLongitudeForSatellite"] doubleValue]] autorelease];
            CLLocationDistance delta=[Place1 distanceFromLocation:newLocation];
            
            if ((int)delta<=1000) {
                //航向数据保存
                [_latitude addObject:[NSString stringWithFormat:@"%f",[[[_item objectAtIndex:i] objectForKey:@"PlaceLatitude"] doubleValue]]];
                [_longtitude addObject:[NSString stringWithFormat:@"%f",[[[_item objectAtIndex:i] objectForKey:@"PlaceLongitude"] doubleValue]]];
                //位置数据保存
                [_data addObject:[_item objectAtIndex:i]];
                [_distancemeter addObject:[NSString stringWithFormat:@"%d",(int)delta]];
            
            }
        }
    }
    //海拔
//    if (newLocation.verticalAccuracy >=0) {
//        for (int i=0; i<[_item count]; i++) {
//            CLLocation *Place1=[[CLLocation alloc] initWithLatitude:[[[_item objectAtIndex:i] objectForKey:@"PlaceLatitude"] doubleValue] longitude:[[[_item objectAtIndex:i] objectForKey:@"PlaceLongitude"] doubleValue]];
//            
//            CLLocationDistance delta=newLocation.altitude;
//            _high=delta;
//            NSLog(@"海拔为:%f",delta);
//        }
//    }
    [self OrderThePlace];
    [self.Distance setText:[NSString stringWithFormat:@"所在位置的GPS信息:%@",[newLocation description]]];
    [self.PlaceTable reloadData];
}
#pragma mark mapview move
//-(void)movemapview{
//    self.shadow.hidden=YES;
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [UIView beginAnimations:nil context:context];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationDuration:0.8];//动画时间长度，单位秒，浮点数
//    self.MapView.frame=CGRectMake(13, 54, 295, 501);
//    
//    [UIView setAnimationDelegate:self];
//    // 动画完毕后调用animationFinished
//    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
//    [UIView commitAnimations];
//    //    [self.a setContentOffset:CGPointMake(0, -20) animated:YES];
//    self.MapOpening=!self.MapOpening;
//}
//-(void)movemapview2{
//    self.shadow.hidden=NO;
//
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [UIView beginAnimations:nil context:context];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationDuration:0.8];//动画时间长度，单位秒，浮点数
//    self.MapView.frame=CGRectMake(13, 410, 295, 145);
//    
//    [UIView setAnimationDelegate:self];
//    // 动画完毕后调用animationFinished
//    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
//    [UIView commitAnimations];
//    //    [self.a setContentOffset:CGPointMake(0, -20) animated:YES];
//    self.MapOpening=!self.MapOpening;
//}
//获得弧度值
//-(double)headingToLocation:(CLLocationCoordinate2D)desired current:(CLLocationCoordinate2D)current{
//    double lat1=current.latitude*kDeg2Rad;
//    double lat2=desired.latitude*kDeg2Rad;
//    double lon1=current.longitude;
//    double lon2=desired.longitude;
//    double dlon=(lon2-lon1)*kDeg2Rad;
//    
//    double y= sin(dlon)*cos(lat2);
//    double x=cos(lat1)*sin(lat2) - sin(lat1)*cos(lat2)*cos(dlon);
//    
//    double heading=atan2(y, x);
//    
//    heading=heading*kRad2Deg;
//    heading=heading+360.0;
//    heading=fmod(heading,360.0);
//    return heading;
//}

//-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
//    _headingdata=[[NSMutableArray alloc] initWithCapacity:50];
//    if (self.recentLocation!=nil && newHeading.headingAccuracy >=0) {
//        for (int i=0; i<[_data count]; i++) {
//            CLLocation *Place1=[[CLLocation alloc] initWithLatitude:[[_latitude objectAtIndex:i] doubleValue] longitude:[[_longtitude objectAtIndex:i]  doubleValue]];
//            double course= [self headingToLocation:Place1.coordinate current:self.recentLocation.coordinate];
//            NSLog(@"%f",course);
//            NSString *pas=[NSString stringWithFormat:@"%f",course];
//            [self.headingdata addObject:pas];
//            
//        }
//    }
//    for (int i=0; i<[_data count]; i++) {
//       NSLog(@"%@",[_headingdata objectAtIndex:i]);
//    }
//    [self.PlaceTable reloadData];
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 53;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_data count];//
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PlaceCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell==nil){
        cell=[[[NSBundle mainBundle] loadNibNamed:@"PlaceCell" owner:nil options:nil] lastObject];
    }
    [(UILabel *)[cell viewWithTag:1] setText:[[_data objectAtIndex:[[_brray objectAtIndex:indexPath.row] intValue]] objectForKey:@"PlaceName"]];
    [(UILabel *)[cell viewWithTag:2] setText:[[_data objectAtIndex:[[_brray objectAtIndex:indexPath.row] intValue]] objectForKey:@"PlaceDesc"]];
    [(UILabel *)[cell viewWithTag:3] setText:[NSString stringWithFormat:@"%@ 米",[_distancemeter objectAtIndex:indexPath.row]]];
    
//    CGAffineTransform rotation = CGAffineTransformMakeRotation([[_headingdata objectAtIndex:[[_brray objectAtIndex:indexPath.row] intValue]] doubleValue]/kDeg2Rad);
//    [(UIImageView *)[cell viewWithTag:5] setTransform:rotation];

    if (indexPath.row==0) {
        [(UIImageView *)[cell viewWithTag:4] setFrame:CGRectMake(12, 15, 29, 20)];
        [(UIImageView *)[cell viewWithTag:4] setImage:[UIImage imageNamed:@"located_opposite"]];
    }else{
        [(UIImageView *)[cell viewWithTag:4] setFrame:CGRectMake(12, 15, 20, 20)];
        [(UIImageView *)[cell viewWithTag:4] setImage:[UIImage imageNamed:@"ff_IconLocationService"]];
    }
    UIImageView *cellselected=[[[UIImageView alloc] initWithFrame:cell.frame] autorelease];
    cellselected.image=[UIImage imageNamed:@"cellBackTouch"];
    cell.selectedBackgroundView=cellselected;

    [self.PlaceTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XYAlertView *alert=[[[XYAlertView alloc] initWithTitle:@"您好！" message:@"您想执行什么功能！" buttons:[NSArray  arrayWithObjects:@"签个到",@"找到它", nil] afterDismiss:^(int buttonIndex) {
        if (buttonIndex==0) {
            [self InsertDataInToDB:[[_data objectAtIndex:indexPath.row] objectForKey:@"PlaceName"] Passtime:[self GetDateWithymd] PassDistance:[_distancemeter objectAtIndex:indexPath.row]];
        }else{
            
            [self locationmapwithlatitude:[[_latitude objectAtIndex:[[_brray objectAtIndex:indexPath.row] intValue]] doubleValue] longtitude:[[_longtitude objectAtIndex:[[_brray objectAtIndex:indexPath.row] intValue]] doubleValue] Title:[[_data objectAtIndex:[[_brray objectAtIndex:indexPath.row] intValue]] objectForKey:@"PlaceName"] Subtitle:[[_data objectAtIndex:[[_brray objectAtIndex:indexPath.row] intValue]] objectForKey:@"PlaceDesc"]];
        }
    }] autorelease];
    [alert show];
    NSLog(@"%f,%f",[[_latitude objectAtIndex:[[_brray objectAtIndex:indexPath.row] intValue]] doubleValue],[[_longtitude objectAtIndex:[[_brray objectAtIndex:indexPath.row] intValue]] doubleValue]);
//    
//    [self InsertDataInToDB:[[_data objectAtIndex:indexPath.row] objectForKey:@"PlaceName"] Passtime:[self GetDateWithymd] PassDistance:[_distance objectAtIndex:indexPath.row]];
}

#pragma mark - CheckINtodb
-(NSString *)getdbpath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *sqlitePath = [documentDirectory stringByAppendingPathComponent:@"DataCache.sqlite"];
    return sqlitePath;
}

-(BOOL)CheckStats{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"CheckStatus"] isEqualToString:@"未登录"]) {
        return NO;
    }else{
        return YES;
    }
}

-(void)InsertDataInToDB:(NSString *)PlaceName Passtime:(NSString *)Time PassDistance:(NSString *) Distance{
    NSLog(@"地点：%@    时间：%@",PlaceName,Time);
    FMDatabase *addtocheckindb=[FMDatabase databaseWithPath:[self getdbpath]];
    if ([addtocheckindb open]) {
        if ([self CheckStats]) {
            FMResultSet *dbresult=[addtocheckindb executeQuery:[NSString stringWithFormat:@"SELECT * FROM CheckInData Where CustomerID='%@'",[[NSUserDefaults standardUserDefaults] objectForKey:@"CustomerID"]]];
                int i=0;
                while ([dbresult next]) {
            
                    if ([[dbresult stringForColumn:@"PlaceName"] isEqualToString:PlaceName]&&[[dbresult stringForColumn:@"Time"] isEqualToString:Time]&&[[dbresult stringForColumn:@"ProductID"] isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"passproductid"]]) {
                            i++;
                    }
                }
                  if (i==0) {
                      XYAlertView *alert=[[[XYAlertView alloc] initWithTitle:@"签到提示！" message:@"您在这里吗？" buttons:[NSArray  arrayWithObjects:@"是的",@"不是", nil] afterDismiss:^(int buttonIndex) {
                          if (buttonIndex==0) {
                              if ([Distance intValue]<=100) {
                              [addtocheckindb executeUpdate:[NSString stringWithFormat:@"INSERT INTO CheckInData(PlaceName,CustomerID,Time,ProductID) VALUES ('%@','%@','%@','%@')",PlaceName,[[NSUserDefaults standardUserDefaults] objectForKey:@"CustomerID"],[self GetDateWithymd],[[NSUserDefaults standardUserDefaults] objectForKey:@"passproductid"]]];
                              }else{
                                  XYAlertView *alert=[[[XYAlertView alloc] initWithTitle:@"抱歉！" message:@"您好像离它有点远哟！" buttons:[NSArray  arrayWithObjects:@"确定", nil] afterDismiss:^(int buttonIndex) {
                                      
                                  }] autorelease];
                                  [alert show];
                              }
                          }
                      }] autorelease];
                      [alert show];
                      
                     }else{
                       XYAlertView *alert=[[[XYAlertView alloc] initWithTitle:@"抱歉！" message:@"您今天在这已经签过到了.明天再签哟！" buttons:[NSArray  arrayWithObjects:@"确定", nil] afterDismiss:^(int buttonIndex) {
                        
                        }] autorelease];
                         [alert show];
                   }
        }else{
            XYAlertView *alert=[[[XYAlertView alloc] initWithTitle:@"抱歉！" message:@"您还没有登录！" buttons:[NSArray       arrayWithObjects:@"确定", nil] afterDismiss:^(int buttonIndex) {
                
            }] autorelease];
            [alert show];
        }
    }
    
//    [addtocheckindb close];
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

-(NSString *)GetDateWithymd{
    NSDate * newDate = [NSDate date];
    
    NSDateFormatter *dateformat=[[[NSDateFormatter alloc] init] autorelease];
    
    [dateformat setDateFormat:@"yyyy-MM-dd"];
    
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

- (void)dealloc {
    [_Distance release];
    [_PlaceTable release];
    [_toolBar release];
    [_back release];
    [_MapView release];
    [_shadow release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setLocman:nil];
    [self setPlaceTable:nil];
    [self setToolBar:nil];
    [self setBack:nil];
    [self setMapView:nil];
    [self setShadow:nil];
    
    [super viewDidUnload];
}

- (IBAction)pop:(UIButton *)sender {
    
    if (self.MapOpening) {
        [self hideMap];
    }else{
    [self.Locman stopUpdatingLocation];
//    [self.Locman stopUpdatingHeading];
    [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)Back:(UIButton *)sender {
    [self pop:nil];
}
@end
