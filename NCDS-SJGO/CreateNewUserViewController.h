//
//  CreateNewUserViewController.h
//  NCDS-SJGO
//
//  Created by 徐子迈 on 12-12-30.
//  Copyright (c) 2012年 XcodeTest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDTakeController.h"
#import "JSAnimatedImagesView.h"

@interface CreateNewUserViewController : UIViewController<UITextFieldDelegate,FDTakeDelegate,JSAnimatedImagesViewDelegate,UIGestureRecognizerDelegate>{
    NSString *key;
    IBOutlet UITextField *_username;
    IBOutlet UITextField *_password;
    IBOutlet UITextField *_accounts;
}

@property (retain,nonatomic) FDTakeController *takeController;
@property (retain, nonatomic) IBOutlet UITextField *accounts;
@property (retain, nonatomic) IBOutlet UITextField *password;
@property (retain, nonatomic) IBOutlet UITextField *username;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;

@property (retain, nonatomic) NSString *acc;
@property (retain, nonatomic) NSString *pas;
@property (retain, nonatomic) NSString *use;

- (IBAction)GoVirtualMall:(UIButton *)sender;
- (IBAction)Finished:(UIButton *)sender;
- (IBAction)getimage:(UIButton *)sender;

@end
