//
//  ProductdetailViewController.h
//  NCDS-SJGO
//
//  Created by 徐子迈 on 13-1-7.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuadCurveMenu.h"
#import <Twitter/Twitter.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

#import "SocialDelegate.h"

@interface ProductdetailViewController : UIViewController<UIScrollViewDelegate,QuadCurveMenuDelegate,SocialDelegate,UIGestureRecognizerDelegate>{
        SLComposeViewController *slComposerSheet;
}
@property (retain, nonatomic) IBOutlet UIScrollView *scrollview;
@property (retain, nonatomic) IBOutlet UIScrollView *Scrollproductimage;
@property (retain, nonatomic) IBOutlet UILabel *Pricelabel;
@property (retain, nonatomic) IBOutlet UILabel *sales;
@property (retain, nonatomic) IBOutlet UILabel *praise;
@property (retain, nonatomic) NSString *webdesc;
@property (retain, nonatomic) IBOutlet UIPageControl *pagecontrol;
@property (retain, nonatomic) IBOutlet UIButton *AddtoUserCart;
- (IBAction)AddtoUserCart:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UIButton *Buyit;
- (IBAction)Buyit:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UILabel *Productnamelabel;
@property (retain, nonatomic) IBOutlet UILabel *Productdescription;
@property (retain,nonatomic) NSMutableArray *imageid;
@property (retain,nonatomic) NSString *productid;
@property (retain, nonatomic) IBOutlet UIImageView *likebtn;
@property (retain, nonatomic) IBOutlet UIImageView *infoview;
@property (retain, nonatomic) UIWebView *web;
@property (nonatomic) BOOL WebIsShowing;
@property (retain, nonatomic) UIView *bgview;
@property (retain, nonatomic) UIImageView *bigimage;
@property (retain, nonatomic) IBOutlet UIButton *fvview;
- (IBAction)ShowWebView:(UIButton *)sender;
- (IBAction)ShowFVview:(UIButton *)sender;
-(void)quadCurveMenu:(QuadCurveMenu *)menu didSelectIndex:(NSInteger)idx;
@end
