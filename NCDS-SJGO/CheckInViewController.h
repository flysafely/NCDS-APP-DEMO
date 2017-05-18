//
//  CheckInViewController.h
//  NCDS-SJGO
//
//  Created by Mofioso on 13-4-16.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "iCodeBlogAnnotation.h"
#import "iCodeBlogAnnotationView.h"
@interface CheckInViewController : UIViewController<CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate,MKAnnotation,UIGestureRecognizerDelegate>
@property (retain, nonatomic) IBOutlet UIButton *back;
@property (retain, nonatomic) IBOutlet UILabel *Distance;
@property (retain, nonatomic) CLLocationManager *Locman;
@property (retain, nonatomic) IBOutlet UITableView *PlaceTable;
@property (retain, nonatomic) NSMutableArray *item;
@property (retain, nonatomic) NSMutableArray *data;
@property (retain, nonatomic) NSMutableArray *distancemeter;
@property (retain, nonatomic) NSMutableArray *brray;

@property (retain, nonatomic) CLLocation *recentLocation;
@property (retain,nonatomic) NSMutableArray *latitude;
@property (retain,nonatomic) NSMutableArray *longtitude;
@property (retain,nonatomic) NSMutableArray *headingdata;

@property (retain, nonatomic) IBOutlet UIImageView *shadow;
@property (retain, nonatomic) IBOutlet MKMapView *MapView;
- (IBAction)pop:(UIButton *)sender;
- (IBAction)Back:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UIToolbar *toolBar;
@end
