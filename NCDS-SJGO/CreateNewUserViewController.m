//
//  CreateNewUserViewController.m
//  NCDS-SJGO
//
//  Created by 徐子迈 on 12-12-30.
//  Copyright (c) 2012年 XcodeTest. All rights reserved.
//

#import "CreateNewUserViewController.h"
#import "VirtualMallViewController.h"
#import "FMDatabase.h"
#import "XYAlertView.h"
#import <QuartzCore/CALayer.h>

@interface CreateNewUserViewController ()
@property (retain, nonatomic) IBOutlet JSAnimatedImagesView *animatedImagesView;

@end

@implementation CreateNewUserViewController
@synthesize accounts=_accounts;
@synthesize username=_username;
@synthesize password=_password;

@synthesize animatedImagesView = _animatedImagesView;
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
     NSLog(@"当前文件为CreateNewUserViewController************");
    [super viewDidLoad];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getimage:)];
    singleTap.delegate=self;
    singleTap.numberOfTapsRequired=1;
    [self.imageView addGestureRecognizer:singleTap];
    self.imageView.userInteractionEnabled=YES;
    [singleTap release];
    
     self.animatedImagesView.delegate = self;
    key=@"0";
    self.takeController = [[[FDTakeController alloc] init] autorelease];
    self.takeController.delegate = self;

    //用户头像image效果设置
    CALayer *celllayer=[self.imageView layer];
    celllayer.borderColor = [[UIColor whiteColor] CGColor];
    celllayer.borderWidth = 1.5f;
    self.imageView.layer.masksToBounds=YES;
    self.imageView.layer.cornerRadius=self.imageView.frame.size.width/2;
    

}
-(void)viewDidDisappear:(BOOL)animated{
    [self.animatedImagesView stopAnimating];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.animatedImagesView startAnimating];
    [self.accounts becomeFirstResponder];
}
- (NSUInteger)animatedImagesNumberOfImages:(JSAnimatedImagesView *)animatedImagesView
{
    return 7;
}

- (UIImage *)animatedImagesView:(JSAnimatedImagesView *)animatedImagesView imageAtIndex:(NSUInteger)index
{
    return [UIImage imageNamed:[NSString stringWithFormat:@"image%d.jpg", index + 1]];
}
- (BOOL)canBecomeFirstResponder{
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([self.accounts isFirstResponder]) {
        [self.accounts resignFirstResponder];
        [self.password becomeFirstResponder];
    }else if([self.password isFirstResponder]){
        [self.password resignFirstResponder];
        [self.username becomeFirstResponder];
    }else if([self.username isFirstResponder]){
        
        [self Finished:nil];
//        [self.accounts becomeFirstResponder];
    }
    return YES;
}

- (IBAction)GoVirtualMall:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)Finished:(UIButton *)sender {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *sqlitePath = [documentDirectory stringByAppendingPathComponent:@"DataCache.sqlite"];
    NSLog(@"%@",sqlitePath);
    //获取document文件夹下的sqlite数据库的路径
    NSString *UUID=[self createUUID];
    FMDatabase *cnudb=[FMDatabase databaseWithPath:sqlitePath];

    if ([cnudb open]) {
        FMResultSet *cnuresult=[cnudb executeQuery:[NSString stringWithFormat:@"select * from CustomerData where CustomerAccount='%@'",self.accounts.text]];
      if ([cnuresult next]) {
          [self.accounts resignFirstResponder];
          [self.password resignFirstResponder];
          [self.username resignFirstResponder];
          XYAlertView *alertView = [XYAlertView alertViewWithTitle:@"抱歉!"
                                                           message:[NSString stringWithFormat:@"用户名:“%@”已经被占用,请重新选择",self.accounts.text]
                                                           buttons:[NSArray arrayWithObjects:@"确定", @"取消", nil]
                                                      afterDismiss:^(int buttonIndex) {
                                                          if (buttonIndex==0) {
                                                              [self.accounts becomeFirstResponder];
                                                          }
                                                          
                                                      }];
          [alertView setButtonStyle:XYButtonStyleGray atIndex:1];
          [alertView show];
          [cnuresult close];
      }else{
          NSLog(@"用户名长度位：%d",[self.username.text length]);
          if ([self.username.text length]>9) {
              XYAlertView *alertView = [XYAlertView alertViewWithTitle:@"抱歉!"
                                                               message:@"用户名不能长度不能超过9位,请重新选择"
                                                               buttons:[NSArray arrayWithObjects:@"确定", @"取消", nil]
                                                          afterDismiss:^(int buttonIndex) {
                                                              if (buttonIndex==0) {
                                                                  [self.username becomeFirstResponder];
                                                              }
                                                              
                                                          }];
              [alertView setButtonStyle:XYButtonStyleGray atIndex:1];
              [alertView show];

          }else{
          [self.accounts resignFirstResponder];
          [self.password resignFirstResponder];
          [self.username resignFirstResponder];
          [cnudb executeUpdate:[NSString stringWithFormat:@"INSERT INTO CustomerData(CustomerAccount,CustomerPassword,CustomerNickname,CustomerID,TotalPoint,UserMoney,Level) VALUES ('%@','%@','%@','%@','%@','%@','%@')",self.accounts.text,self.password.text,self.username.text,UUID,@"0",@"5000",@"0"]] ;
          
          UIImage *pickedimage=self.imageView.image;
          
          NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
          NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",UUID]];
          //将图片写到Documents文件中
          [UIImagePNGRepresentation(pickedimage)writeToFile: uniquePath    atomically:YES];
          
          XYAlertView *alertView = [XYAlertView alertViewWithTitle:@"恭喜!"
                                                           message:@"注册成功！"
                                                           buttons:[NSArray arrayWithObjects:@"继续", nil]
                                                      afterDismiss:^(int buttonIndex) {
                                                             [self GoVirtualMall:nil];
                                                      }];
          

          [alertView setButtonStyle:XYButtonStyleGray atIndex:1];
          [alertView show];
          
      }
      }
    }
    [cnudb close];
}

- (IBAction)getimage:(UIButton *)sender {

    
    [self passviewcontroller];
       [self.takeController takePhotoOrChooseFromLibrary];

}

-(void)passviewcontroller{
    [self.takeController getviewcontroller:self];
}
- (void)takeController:(FDTakeController *)controller didCancelAfterAttempting:(BOOL)madeAttempt
{
    XYAlertView *alertView = [XYAlertView alertViewWithTitle:@"注意!"
                                                     message:@"已经取消选择。"
                                                     buttons:[NSArray arrayWithObjects:@"确定", nil]
                                                afterDismiss:^(int buttonIndex) {
                                                    
                                                }];
    
    
    [alertView setButtonStyle:XYButtonStyleGray atIndex:1];
    [alertView show];
}

- (void)takeController:(FDTakeController *)controller gotPhoto:(UIImage *)photo withInfo:(NSDictionary *)info
{
    [self.imageView setImage:photo];
}

- (NSString *)createUUID//UUID生成....
{
    CFUUIDRef uuidObject = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuidStr = (NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuidObject);
    CFRelease(uuidObject);
    return [uuidStr autorelease];
}
- (void)dealloc {
    [_accounts release];
    [_username release];
    [_password release];
    [_imageView release];
    [_animatedImagesView release];

    [super dealloc];
}
- (void)viewDidUnload {
    [_accounts release];
    _accounts = nil;
    [self setAccounts:nil];
    [_password release];
    _password = nil;
    [_username release];
    _username = nil;
    [self setPassword:nil];
    [self setUsername:nil];
    [self setImageView:nil];
    [self setAnimatedImagesView:nil]; 
    [super viewDidUnload];
    
}
@end
