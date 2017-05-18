//
//  PickerViewController.h
//  NCDS-SJGO
//
//  Created by 徐子迈 on 13-1-11.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>
- (IBAction)Comfirm:(UIButton *)sender;
- (IBAction)Addaddress:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UIButton *Comfirm;
@property (retain, nonatomic) IBOutlet UIButton *Addaddress;
@property (retain, nonatomic) IBOutlet UILabel *Proprice;
@property (retain, nonatomic) IBOutlet UITextField *Number;
@property (retain, nonatomic) IBOutlet UILabel *Proname;
@property (retain, nonatomic) IBOutlet UIImageView *Proimage;
@property (retain, nonatomic) IBOutlet UIPickerView *Picker;
@property (retain, nonatomic) IBOutlet UIImageView *Orderbg;
@property (retain,nonatomic) NSString *string;
@property (retain,nonatomic) NSMutableArray *item;
@property (retain,nonatomic) NSString *count;
@property (strong,nonatomic) NSMutableArray *optioncontent;

@property (retain,nonatomic) NSString *ParameterOption1;
@property (retain,nonatomic) NSString *ParameterOption2;
@property (retain,nonatomic) NSString *ParameterOption3;
@property (retain,nonatomic) NSString *ParameterOption4;
@property (retain,nonatomic) NSString *ParameterOption5;
@property (retain,nonatomic) NSString *address;
@property (retain,nonatomic) NSMutableArray *orderinfo;
@property (retain,nonatomic) NSString *orderinformation;
@property (retain,nonatomic) NSString *totalprice;

- (IBAction)resetkeyboard:(UIButton *)sender;

@end
