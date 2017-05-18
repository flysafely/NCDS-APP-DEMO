//
//  UserRegisterViewController.m
//  NCDS-SJGO
//
//  Created by 徐子迈 on 12-12-30.
//  Copyright (c) 2012年 XcodeTest. All rights reserved.
//

#import "UserRegisterViewController.h"
#import "CreateNewUserViewController.h"
#import "FMDatabase.h"
#import "UserClass.h"
#import "MCSoundBoard.h"
@interface UserRegisterViewController ()
@property (retain, nonatomic) IBOutlet JSAnimatedImagesView *animatedImagesView;

@end

@implementation UserRegisterViewController
@synthesize Password=_Password;
@synthesize Accounts=_Accounts;
@synthesize animatedImagesView = _animatedImagesView;
@synthesize delegate=_delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (NSUInteger)animatedImagesNumberOfImages:(JSAnimatedImagesView *)animatedImagesView
{
    return 7;
}

- (UIImage *)animatedImagesView:(JSAnimatedImagesView *)animatedImagesView imageAtIndex:(NSUInteger)index
{
    return [UIImage imageNamed:[NSString stringWithFormat:@"image%d.jpg", index + 1]];
}

- (void)viewDidLoad
{
    NSLog(@"当前文件为UserRegisterViewController************");
    [super viewDidLoad];
    self.animatedImagesView.delegate = self;
    // Do any additional setup after loading the view from its nib.
    key=@"0";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"register_bg.png"]];

}
-(void)viewWillAppear:(BOOL)animated{
    [self.animatedImagesView startAnimating];

     [self.Accounts becomeFirstResponder];
}
-(void)viewDidDisappear:(BOOL)animated{
    [self.animatedImagesView stopAnimating];
}
- (BOOL)canBecomeFirstResponder{
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ConfirmPassword:(UIButton *)sender {
   //验证密码是否正确...
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *sqlitePath = [documentDirectory stringByAppendingPathComponent:@"DataCache.sqlite"];
    UserClass *userdata=[[[UserClass alloc] init] autorelease];
    
    FMDatabase *urdb=[FMDatabase databaseWithPath:sqlitePath];
    if ([urdb open]) {
        FMResultSet *urresult=[urdb executeQuery:[NSString stringWithFormat:@"select * from CustomerData where CustomerAccount='%@'",self.Accounts.text]];
        if ([urresult next]) {
//            NSString *password=[urresult stringForColumn:@"CustomerPassword"];
//            NSString *username=[urresult stringForColumn:@"CustomerNickname"];
//            NSString *userid=[urresult stringForColumn:@"CustomerID"];
//            NSString *money=[urresult stringForColumn:@"UserMoney"];
            //用户类获得......赋值.......
            userdata._UserName=[urresult stringForColumn:@"CustomerNickname"];
            userdata._UserAccount=[urresult stringForColumn:@"CustomerAccount"];
            userdata._UserPassword=[urresult stringForColumn:@"CustomerPassword"];
            userdata._UserID=[urresult stringForColumn:@"CustomerID"];
            userdata._UserPoints=[urresult stringForColumn:@"TotalPoint"];
            userdata._Money=[urresult stringForColumn:@"UserMoney"];
            userdata._Level=[urresult stringForColumn:@"Level"];
            
            if ([self.Password.text isEqualToString:userdata._UserPassword]) {
                [self.Password resignFirstResponder];
                [self.Accounts resignFirstResponder];
                XYAlertView *alertView = [XYAlertView alertViewWithTitle:@"您好!"
                                                                 message:[NSString stringWithFormat:@"亲爱的“%@“,欢迎登录世纪购!",userdata._UserName]
                                                                 buttons:[NSArray arrayWithObjects:@"确定", nil]
                                                            afterDismiss:^(int buttonIndex) {
                                                                if (buttonIndex==0) {
                                                                    
                                                                    [MCSoundBoard playSoundForKey:@"Awards"];
                                                                    [self.delegate getimage:userdata._UserID];
                                                                    [self.delegate moveoutbutton];
                                                                    [self.delegate getuserdata:userdata];
                                                                    [self loaddata];
                                                                    [self Goback:nil];
                                                                    
                                                                }}];
 
                [alertView setButtonStyle:XYButtonStyleGray atIndex:1];
                [alertView show];
                //在此输入 设定登录状态检查默认值.用于在购物车等项目中检查....title=[foodclass objectAtIndex:indexPath.row];
                 NSString *Status=@"登录";
                NSUserDefaults *status=[NSUserDefaults standardUserDefaults];
                [status setObject:Status forKey:@"CheckStatus"];
                [status setObject:userdata._UserID forKey:@"CustomerID"];
                [status setObject:userdata._UserName forKey:@"CustomerNickname"];
//                [status setObject:money forKey:@"UserMoney"];

            }else{
                [self.Password resignFirstResponder];
                [self.Accounts resignFirstResponder];
                XYAlertView *alertView = [XYAlertView alertViewWithTitle:@"抱歉!"
                                                                 message:[NSString stringWithFormat:@"尊敬的%@,您输入的密码有误!",userdata._UserName]
                                                                 buttons:[NSArray arrayWithObjects:@"确定", nil]
                                                            afterDismiss:^(int buttonIndex) {
                                                                if (buttonIndex==0) {
                                                                    [self.Password becomeFirstResponder];

                                                                }
                                                                                                                            }];
                
                [alertView setButtonStyle:XYButtonStyleGray atIndex:1];

                [alertView show];
            }
        }else{
            [self.Password resignFirstResponder];
            [self.Accounts resignFirstResponder];
            XYAlertView *alertView = [XYAlertView alertViewWithTitle:@"抱歉!"
                                                             message:[NSString stringWithFormat:@"用户:“%@”不存在,请确认",self.Accounts.text]
                                                             buttons:[NSArray arrayWithObjects:@"确定", nil]
                                                        afterDismiss:^(int buttonIndex) {
                                                            if (buttonIndex==0) {
                                                            
                                                          [self.Accounts becomeFirstResponder];
                                                            }
                                                        }];
            
            // set the second button as gray style
            [alertView setButtonStyle:XYButtonStyleGray atIndex:1];
            
            // display
            [alertView show];
        }
        [urresult close];
    }
    [urdb close];
}
- (IBAction)Goback:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([self.Accounts isFirstResponder]) {
        [self.Accounts resignFirstResponder];
        [self.Password becomeFirstResponder];
        
    }else{
//        [self.Accounts resignFirstResponder];
//        [self.Password resignFirstResponder];
        [self ConfirmPassword:nil];
//        [self.Accounts becomeFirstResponder];
    }
    return YES;
}

-(void)loaddata{
    int n=0;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *sqlitePath = [documentDirectory stringByAppendingPathComponent:@"DataCache.sqlite"];
    NSLog(@"%@",sqlitePath);
    FMDatabase *usercartdb=[FMDatabase databaseWithPath:sqlitePath];
    if ([usercartdb open]) {
        FMResultSet *proincart=[usercartdb executeQuery:[NSString stringWithFormat:@"select * from UserCartData where CustomerID='%@'",[[NSUserDefaults standardUserDefaults] objectForKey:@"CustomerID"]]];
        while ([proincart next]) {
            n=n+1;
        }[proincart close];
    }[usercartdb close];
    NSLog(@"购物车中产品数量：%d",n);
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    [def setObject:[NSString stringWithFormat:@"%d",n] forKey:@"cartnum"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"additembragevalue" object:nil];
}

- (void)dealloc {
    [_Accounts release];
    [_Password release];
    [_animatedImagesView release];

    [super dealloc];
}
- (void)viewDidUnload {
    [self setAnimatedImagesView:nil];

    [_Accounts release];
    _Accounts = nil;
    [_Password release];
    _Password = nil;
    [self setPassword:nil];
    [self setAccounts:nil];
    [super viewDidUnload];
}
@end
