//
//  UserRegisterViewController.h
//  NCDS-SJGO
//
//  Created by 徐子迈 on 12-12-30.
//  Copyright (c) 2012年 XcodeTest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYAlertView.h"
#import "UserRegisterDelegate.h"
#import "JSAnimatedImagesView.h"
//#import "UIpassvaluedelegate.h"
@interface UserRegisterViewController : UIViewController<UITextFieldDelegate,JSAnimatedImagesViewDelegate>{
    NSString *key;//临时变量
    NSObject<UserRegisterDelegate> *_delegate;
}

@property (retain, nonatomic) NSObject<UserRegisterDelegate> *delegate;
@property (retain, nonatomic) IBOutlet UITextField *Password;
@property (retain, nonatomic) IBOutlet UITextField *Accounts;
//@property (assign, nonatomic) NSObject<UIpassvaluedelegate> *delegate;
- (IBAction)ConfirmPassword:(UIButton *)sender;
- (IBAction)Goback:(UIButton *)sender;


@end
