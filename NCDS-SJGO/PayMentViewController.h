//
//  PayMentViewController.h
//  NCDS-SJGO
//
//  Created by Mofioso on 13-5-1.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RVCollectionViewLayout.h"
#import "RVCollectionViewCell.h"
#import <QuartzCore/CALayer.h>

@interface PayMentViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray * imagesArray;
@property (nonatomic, strong) RVCollectionViewLayout * collectionViewLayout;
@property (retain, nonatomic) IBOutlet UIToolbar *toolBar;
@property (retain, nonatomic) IBOutlet UIImageView *BankImage;
@property (retain, nonatomic) IBOutlet UIView *CardView;
@property (retain, nonatomic) IBOutlet UITextField *CardAccount;
@property (retain, nonatomic) IBOutlet UITextField *CardPassword;
@property (retain, nonatomic) IBOutlet UILabel *PayPrice;
@property (retain, nonatomic) NSString *price;

- (IBAction)Back:(UIButton *)sender;
- (IBAction)showcards:(UIButton *)sender;
- (IBAction)hidecards:(UIButton *)sender;
- (IBAction)Confirm:(UIButton *)sender;
@end
