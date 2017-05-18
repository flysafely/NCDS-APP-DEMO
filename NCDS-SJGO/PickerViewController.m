//
//  PickerViewController.m
//  NCDS-SJGO
//
//  Created by 徐子迈 on 13-1-11.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import "PickerViewController.h"
#import "FMDatabase.h"
#import <QuartzCore/CALayer.h>
#import "XYAlertViewHeader.h"
#import "SecondViewController.h"
#import "SecondNavigationViewController.h"
#import "FourNavigationViewController.h"
#import "FourViewController.h"
#import "UIImageView+WebCache.h"
#import "UserRegisterViewController.h"
#import "MCSoundBoard.h"
#import "PayMentViewController.h"
@interface PickerViewController ()

@end

@implementation PickerViewController
@synthesize item=_item;
@synthesize Picker=_Picker;
@synthesize string=_string;
@synthesize count=_count;
@synthesize optioncontent=_optioncontent;
@synthesize Proimage=_Proimage;
@synthesize Proname=_Proname;
@synthesize Number=_Number;
@synthesize Orderbg=_Orderbg;
@synthesize Addaddress=_Addaddress;
@synthesize ParameterOption1=_ParameterOption1;
@synthesize ParameterOption2=_ParameterOption2;
@synthesize ParameterOption3=_ParameterOption3;
@synthesize ParameterOption4=_ParameterOption4;
@synthesize ParameterOption5=_ParameterOption5;
@synthesize orderinfo=_orderinfo;
@synthesize orderinformation=_orderinformation;
@synthesize address=_address;
@synthesize totalprice=_totalprice;


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
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"AddOrBuy"] isEqualToString:@"add"] ) {
        self.title=@"加入购物车";
    }else{
        self.title=@"直接购买";
    }
//
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"CheckStatus"] isEqualToString:@"未登录"]){
//        self.Addaddress.hidden=YES;
//    }
    
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    [def setObject:@"" forKey:@"PassAddress"];
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"catagroy_bg"]];
    self.Orderbg.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Gomall_bg_main"]];
    self.Proname.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"PassName"];
    self.Proname.font=[UIFont systemFontOfSize:14];
    self.Picker.alpha=0;
    self.Picker.frame=CGRectMake(0, 480, 320, 216);
//    self.Proimage.image=[UIImage imageNamed:[[NSUserDefaults standardUserDefaults] objectForKey:@"passproductid"]];
    
    [self.Proimage setImageWithURL:[[NSUserDefaults standardUserDefaults] objectForKey:@"proimageurl"] placeholderImage:[UIImage imageNamed:@"nscd_bg"]];
    
    CALayer *celllayer=[self.Proimage layer];
    celllayer.borderColor = [[UIColor whiteColor] CGColor];
    celllayer.borderWidth = 1.5f;
    celllayer.masksToBounds=YES;
    celllayer.cornerRadius=2;
    celllayer.shadowPath=[UIBezierPath bezierPathWithRect:self.Proimage.bounds].CGPath;
    celllayer.shadowOffset=CGSizeMake(0, 0);
    celllayer.shadowColor=[UIColor blackColor].CGColor;
    celllayer.shadowOpacity=1.0;
    
    self.Proprice.text=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"PassPrice"]];
    self.Proprice.font=[UIFont systemFontOfSize:19];
    
    UIImage *Createbg=[[UIImage imageNamed:@"order_confirm_normal"] autorelease];
    Createbg=[Createbg resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10,10)];
    [self.Comfirm setBackgroundImage:Createbg forState:UIControlStateNormal];
    UIImage *presscreatebg=[[UIImage imageNamed:@"order_confirm_down"] autorelease];
    presscreatebg=[presscreatebg resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [self.Comfirm setBackgroundImage:presscreatebg forState:UIControlStateHighlighted];

    
    UIButton *leftbutton=[[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 52, 32)] autorelease];
    UIImage *image=[[UIImage imageNamed:@"navi_back_btn"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 15, 5, 10)];
    [leftbutton setBackgroundImage:image forState:UIControlStateNormal];
    UIImage *imageh=[[UIImage imageNamed:@"navi_back_btn_h"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 15, 5, 10)];
    [leftbutton setBackgroundImage:imageh forState:UIControlStateHighlighted];
    leftbutton.titleLabel.font=[UIFont systemFontOfSize:11];
    [leftbutton setTitle:@"  返   回" forState:UIControlStateNormal];
    [leftbutton setTitle:@"  返   回" forState:UIControlStateHighlighted];
    [leftbutton addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftitem=[[[UIBarButtonItem alloc] initWithCustomView:leftbutton] autorelease];
    self.navigationItem.leftBarButtonItem=leftitem;
    
    
    _item=[[NSMutableArray alloc] init];
    NSString *proid=[[NSUserDefaults standardUserDefaults] objectForKey:@"passproductid"];
    FMDatabase *db=[FMDatabase databaseWithPath:[[NSBundle mainBundle] pathForResource:@"SJGOData" ofType:@"sqlite"]];
    if ([db open]) {
        FMResultSet *result=[db executeQuery:[NSString stringWithFormat:@"select * from ProductParameter where ProductID='%@'",proid]];
        while ([result next]) {
            NSMutableDictionary *dic=[[[NSMutableDictionary alloc] init] autorelease];

            _string=[result stringForColumn:@"ProductName"];
            NSString *resultcount=[NSString stringWithFormat:@"%@",[result stringForColumn:@"ParameterCount"]];
            self.count=resultcount;
            [resultcount release];
            for (int i=1; i<[_count intValue]+1; i++) {
                [dic setObject:[result stringForColumn:[NSString stringWithFormat:@"ParameterOption%d",i]] forKey:[NSString stringWithFormat:@"ParameterOption%d",i]];

                [dic setObject:[result stringForColumn:[NSString stringWithFormat:@"ParameterOption%dCount",i]] forKey:[NSString stringWithFormat:@"ParameterOption%dCount",i]];
               
            }

             [_item addObject:dic];
        }[result close];
    }[db close];
    [self loadoption];
    [_count retain];
//    [_optioncontent retain];

}
-(NSString *)getdbpath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *sqlitePath = [documentDirectory stringByAppendingPathComponent:@"DataCache.sqlite"];
    return sqlitePath;
}
-(void)viewWillAppear:(BOOL)animated{
    if ([_count intValue]==0) {
        [self poppicker];
    
    }else{
        [self LableMake];
        [self pushpicker];
        [self DefaultPick];
    }
//    NSLog(@"_optioncontent is %d",[_optioncontent retainCount]); 
}

-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)LableMake{
   
    NSDictionary *dic=[_item lastObject];
    
    for (int i=1; i<[_count intValue]+1; i++) {
        UILabel *myView = [[[UILabel alloc] initWithFrame:CGRectMake(14+(i-1)*(296/[_count intValue]), 275, 68, 24)] autorelease];
        
        myView.text=[NSString stringWithFormat:@"     %@:",[dic objectForKey:[NSString stringWithFormat:@"ParameterOption%d",i]]];
        myView.textAlignment = UITextAlignmentLeft;
        myView.font = [UIFont systemFontOfSize:10];
        myView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"label_bg"]];
        myView.textColor=[UIColor darkGrayColor];
        [self.view addSubview:myView];
    }
    
//    NSLog(@"dic is %d",[dic retainCount]);
}

-(void)loadoption{
    self.optioncontent=[NSMutableArray arrayWithCapacity:5];
        NSString *proid=[[NSUserDefaults standardUserDefaults] objectForKey:@"passproductid"];
    FMDatabase *db2=[FMDatabase databaseWithPath:[[NSBundle mainBundle] pathForResource:@"SJGOData" ofType:@"sqlite"]];
    if ([db2 open]) {
        FMResultSet *result2=[db2 executeQuery:[NSString stringWithFormat:@"select * from ProductOption where ProductID='%@'",proid]];
        while ([result2 next]) {
            NSMutableDictionary *Dic=[[[NSMutableDictionary alloc] init] autorelease];
            for (int i=1; i<[_count intValue]+1; i++) {
                if (![[result2 stringForColumn:[NSString stringWithFormat:@"ProductOption%d",i]] isEqualToString:@""] ) {
                    [Dic setObject:[result2 stringForColumn:[NSString stringWithFormat:@"ProductOption%d",i]] forKey:[NSString stringWithFormat:@"ProductOption%d",i]];
                   }
            }
            [_optioncontent addObject:Dic];
        }[result2 close];
    }[db2 close];

}
-(void)poppicker{
    
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.2];//动画时间长度，单位秒，浮点数
        self.Picker.frame = CGRectMake(0, 480, 320, 216);
        
        [UIView setAnimationDelegate:self];
        // 动画完毕后调用animationFinished
        [UIView setAnimationDidStopSelector:@selector(animationFinished)];
        [UIView commitAnimations];
    
}
-(void)pushpicker{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.8];//动画时间长度，单位秒，浮点数
    self.Picker.frame = CGRectMake(0, 300, 320, 216);
    self.Picker.alpha=1;
    [MCSoundBoard playSoundForKey:@"pickerup"];
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return [_count intValue];

}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSDictionary *dic=[NSDictionary dictionary];
    dic=[_item lastObject];
    
    for (int i=1; i<[_count intValue]+1; i++) {
        return [[dic objectForKey:[NSString stringWithFormat:@"ParameterOption%dCount",component+1]]intValue];
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    [_optioncontent retain];
    NSDictionary *dic=[_optioncontent objectAtIndex:row];
    for (int i=1; i<[_count intValue]+1; i++) {
        return [dic objectForKey:[NSString stringWithFormat:@"ProductOption%d",component+1]];
        
                 }
 NSLog(@"titleforrow count is %d",[_count retainCount]);
    return 0;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if ([_count intValue]==1) {
        switch (component) {
            case 0:
                _ParameterOption1=[[_optioncontent objectAtIndex:row] objectForKey:@"ProductOption1"];
                break;
                
            default:
                break;
        }
    }else if ([_count intValue]==2){
        switch (component) {
            case 0:
                _ParameterOption1=[[_optioncontent objectAtIndex:row] objectForKey:@"ProductOption1"];
                break;
            case 1:
                _ParameterOption2=[[_optioncontent objectAtIndex:row] objectForKey:@"ProductOption2"];
                break;
            default:
                break;
        }
    }else if ([_count intValue]==3){
        switch (component) {
            case 0:
                _ParameterOption1=[[_optioncontent objectAtIndex:row] objectForKey:@"ProductOption1"];
                break;
            case 1:
                _ParameterOption2=[[_optioncontent objectAtIndex:row] objectForKey:@"ProductOption2"];
                break;
            case 2:
                _ParameterOption3=[[_optioncontent objectAtIndex:row] objectForKey:@"ProductOption3"];
                break;
            default:
                break;
        }
    }else if ([_count intValue]==4){
            switch (component) {
                case 0:
                    _ParameterOption1=[[_optioncontent objectAtIndex:row] objectForKey:@"ProductOption1"];
                    break;
                case 1:
                    _ParameterOption2=[[_optioncontent objectAtIndex:row] objectForKey:@"ProductOption2"];
                    break;
                case 2:
                    _ParameterOption3=[[_optioncontent objectAtIndex:row] objectForKey:@"ProductOption3"];
                    break;
                case 3:
                    _ParameterOption4=[[_optioncontent objectAtIndex:row] objectForKey:@"ProductOption4"];
                    break;
                case 4:
                    _ParameterOption5=[[_optioncontent objectAtIndex:row] objectForKey:@"ProductOption5"];
                    break;

                default:
                    break;
            }
    }
// NSLog(@"didselected count is %d",[_count retainCount]);
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *myView = nil;
    NSDictionary *dic=[_optioncontent objectAtIndex:row];


    for (int i=1; i<[_count intValue]+1; i++) {
        myView = [[[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 30)] autorelease];
        
        myView.textAlignment = UITextAlignmentCenter;
        
        myView.text = [dic objectForKey:[NSString stringWithFormat:@"ProductOption%d",component+1]];
        
        myView.font = [UIFont systemFontOfSize:14];         //用label来设置字体大小
        
        myView.backgroundColor = [UIColor clearColor];
        
    }
//NSLog(@"_optioncontent is %d",[_optioncontent retainCount]);
return myView;
}

- (void)dealloc {
    [_Picker release];
    [_Orderbg release];
    [_Proimage release];
    [_Proname release];
    [_Number release];
    [_Proprice release];
    [_Comfirm release];
    [_Addaddress release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setPicker:nil];
    [self setOrderbg:nil];
    [self setProimage:nil];
    [self setProname:nil];
    [self setNumber:nil];
    [self setProprice:nil];
    [self setComfirm:nil];
    [self setAddaddress:nil];
    [super viewDidUnload];
}
-(void)DefaultPick{
//    [_optioncontent retain];///尼玛逼的！！！！碉堡了！！
if ([_count intValue]==1) {
    _ParameterOption1=[[_optioncontent objectAtIndex:0] objectForKey:@"ProductOption1"];
}else if ([_count intValue]==2){
    _ParameterOption1=[[_optioncontent objectAtIndex:0] objectForKey:@"ProductOption1"];
    _ParameterOption2=[[_optioncontent objectAtIndex:0] objectForKey:@"ProductOption2"];
}else if ([_count intValue]==3){
    _ParameterOption1=[[_optioncontent objectAtIndex:0] objectForKey:@"ProductOption1"];
    _ParameterOption2=[[_optioncontent objectAtIndex:0] objectForKey:@"ProductOption2"];
    _ParameterOption3=[[_optioncontent objectAtIndex:0] objectForKey:@"ProductOption3"];
}else if ([_count intValue]==4){
    _ParameterOption1=[[_optioncontent objectAtIndex:0] objectForKey:@"ProductOption1"];
    _ParameterOption2=[[_optioncontent objectAtIndex:0] objectForKey:@"ProductOption2"];
    _ParameterOption3=[[_optioncontent objectAtIndex:0] objectForKey:@"ProductOption3"];
    _ParameterOption4=[[_optioncontent objectAtIndex:0] objectForKey:@"ProductOption4"];
}else{
    _ParameterOption1=[[_optioncontent objectAtIndex:0] objectForKey:@"ProductOption1"];
    _ParameterOption2=[[_optioncontent objectAtIndex:0] objectForKey:@"ProductOption2"];
    _ParameterOption3=[[_optioncontent objectAtIndex:0] objectForKey:@"ProductOption3"];
    _ParameterOption4=[[_optioncontent objectAtIndex:0] objectForKey:@"ProductOption4"];
    _ParameterOption4=[[_optioncontent objectAtIndex:0] objectForKey:@"ProductOption5"];

}

}
- (IBAction)Comfirm:(UIButton *)sender {
    NSString *totalnumber=self.Number.text;
    
    if ([self.title isEqualToString:@"加入购物车"]) {
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"CheckStatus"] isEqualToString:@"未登录"]) {
            XYAlertView *alert=[[[XYAlertView alloc] initWithTitle:@"抱歉！" message:@"您还没有登录！" buttons:[NSArray       arrayWithObjects:@"取消", @"立即登陆", nil] afterDismiss:^(int buttonIndex) {
                if (buttonIndex==1) {
//                    UserRegisterViewController *user=[[[UserRegisterViewController alloc] init] autorelease];
//                    [self presentViewController:user animated:YES completion:nil];
                    [self.tabBarController setSelectedIndex:2];
                }
            }] autorelease];
            [alert show];
            
        }else{
            self.orderinformation=[NSString stringWithFormat:@"%@,%@,%@,%@,%@",_ParameterOption1,_ParameterOption2,_ParameterOption3,_ParameterOption4,_ParameterOption5];//订单信息
            self.totalprice=[NSString stringWithFormat:@"%d",[self.Proprice.text intValue]*[totalnumber intValue]];
            [self AddtoUserCart];
            
            
        }
    }else{
        //检查登录状况，写入未完成订单。
        if ([self.Number.text hasPrefix:@"0"]) {
            XYAlertView *aler=[[XYAlertView alloc] initWithTitle:@"提示" message:@"您的输入有误." buttons:[NSArray       arrayWithObjects:@"确定",nil] afterDismiss:^(int buttonIndex){
                if (buttonIndex==0) {
                    [self.Number isFirstResponder];
                }
            }];
            [aler show];
            [aler release];
        }else{
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"CheckStatus"] isEqualToString:@"未登录"]) {
            XYAlertView *alert=[[[XYAlertView alloc] initWithTitle:@"抱歉！" message:@"您还没有登录！" buttons:[NSArray       arrayWithObjects:@"取消", @"立即登陆", nil] afterDismiss:^(int buttonIndex) {
                if (buttonIndex==1) {
//                    UserRegisterViewController *user=[[[UserRegisterViewController alloc] init] autorelease];
//                    [self presentViewController:user animated:YES completion:nil];
                    [self.tabBarController setSelectedIndex:2];
                }
            }] autorelease];
            [alert show];
            
            
        }else{
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"PassAddress"] isEqualToString:@""]) {
                [self Addanaddress];
            }else{
                self.orderinformation=[NSString stringWithFormat:@"%@,%@,%@,%@,%@",_ParameterOption1,_ParameterOption2,_ParameterOption3,_ParameterOption4,_ParameterOption5];//订单信息
                self.totalprice=[NSString stringWithFormat:@"%d",[self.Proprice.text intValue]*[totalnumber intValue]];

                
                XYAlertView *aler=[[XYAlertView alloc] initWithTitle:@"支付确认!" message:@"直接用余额支付？" buttons:[NSArray arrayWithObjects:@"确认", @"其他",@"取消", nil] afterDismiss:^(int buttonIndex) {
                    if (buttonIndex==0) {
                        [self checkusermoney];
                    }else if (buttonIndex==1){
                        PayMentViewController *pay=[[PayMentViewController alloc] init];
                        pay.price=self.totalprice;
                        [self presentViewController:pay animated:YES completion:nil];
                    }
                    
                }
                                   ];
                [aler show];
                [aler release];

            }
        }
     }
   }
}
-(void)checkusermoney{
    FMDatabase *urdb=[FMDatabase databaseWithPath:[self getdbpath]];
    if ([urdb open]) {
        FMResultSet *urresult=[urdb executeQuery:[NSString stringWithFormat:@"select * from CustomerData where CustomerID='%@'",[[NSUserDefaults standardUserDefaults] objectForKey:@"CustomerID"]]];
        if ([urresult next]) {
            NSString *money=[urresult stringForColumn:@"UserMoney"];
            NSString *points=[urresult stringForColumn:@"TotalPoint"];

            if ([money intValue]>=[self.totalprice intValue]) {
                
                NSString *updatemoney=[NSString stringWithFormat:@"%d",([money intValue]-[self.totalprice intValue])];
                NSString *updatepoints=[NSString stringWithFormat:@"%d",([points intValue]+[self.Number.text intValue])];
                [urdb executeUpdate:[NSString stringWithFormat:@"UPDATE CustomerData SET UserMoney='%@' where CustomerID='%@'",updatemoney,[[NSUserDefaults standardUserDefaults] objectForKey:@"CustomerID"]]];
                [urdb executeUpdate:[NSString stringWithFormat:@"UPDATE CustomerData SET TotalPoint='%@' where CustomerID='%@'",updatepoints,[[NSUserDefaults standardUserDefaults] objectForKey:@"CustomerID"]]];
                [urresult close];
                [urdb close];
                [self Checkout];
            }else{
                [self Message:@"余额不足!请充值."];
            }
        }[urresult close];
    }[urdb close];
    
}
- (IBAction)Addaddress:(UIButton *)sender {
    [self Addanaddress];
}

-(void)Addanaddress{
    XYInputView *inputView = [XYInputView inputViewWithPlaceholder:@"请输入你的收件地址"
                                                       initialText:nil buttons:[NSArray arrayWithObjects:@"取消", @"完成", nil]
                                                      afterDismiss:^(int buttonIndex, NSString *text) {
                                                          if(buttonIndex == 1){
                                                              NSString *Text=[NSString stringWithFormat:@"%p",text];
                                                              if ([Text isEqualToString:@"0x0"]) {
                                                                  NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
                                                                  [def setObject:@"" forKey:@"PassAddress"];

                                                              }else{

                                                              NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
                                                              [def setObject:text forKey:@"PassAddress"];
                                                            

                                                              }
                                                              
                                                              XYAlertView *aler=[[XYAlertView alloc] initWithTitle:@"提示" message:@"地址已经添加,请再次确认购买！" buttons:[NSArray       arrayWithObjects:@"确定",nil] afterDismiss:^(int buttonIndex){
                                                                  if (buttonIndex==0) {
                                                                    
                                                                  }
                                                              }];
                                                              [aler show];
                                                              [aler release];
                                                               }
                                                         }];
    [inputView setButtonStyle:XYButtonStyleGreen atIndex:1];
    [inputView show];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    self.Comfirm.userInteractionEnabled=YES;
    [self.Number resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.Comfirm.userInteractionEnabled=NO;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.Comfirm.userInteractionEnabled=YES;
}
-(void)AddtoUserCart{
    
    if ([self.Number.text hasPrefix:@"0"]) {
        XYAlertView *aler=[[XYAlertView alloc] initWithTitle:@"提示" message:@"您的输入有误." buttons:[NSArray       arrayWithObjects:@"确定",nil] afterDismiss:^(int buttonIndex){
            if (buttonIndex==0) {
                [self.Number isFirstResponder];
            }
        }];
        [aler show];
        [aler release];
    }else{
        [self.Number resignFirstResponder];
    

    
    FMDatabase *addtocartdb=[FMDatabase databaseWithPath:[self getdbpath]];

    if ([addtocartdb open]) {
        [addtocartdb executeUpdate:[NSString stringWithFormat:@"INSERT INTO UserCartData(CustomerID,OrderInfo,ProductID,TotalNumber,TotalPrice,ProductImageURL) VALUES ('%@','%@','%@','%@','%@','%@')",[[NSUserDefaults standardUserDefaults] objectForKey:@"CustomerID"],self.orderinformation,[[NSUserDefaults standardUserDefaults] objectForKey:@"passproductid"],self.Number.text,self.totalprice,[[NSUserDefaults standardUserDefaults] objectForKey:@"proimageurl"]]];
        [self Message:@"添加成功!"];
    }[addtocartdb close];
    [MCSoundBoard playSoundForKey:@"addtouserchart"];
    }
//    [[self.tabBarController.tabBar.items objectAtIndex:2] setBadgeValue:@"待付款"];
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    [def setObject:[NSString stringWithFormat:@"%d",[[[NSUserDefaults standardUserDefaults] objectForKey:@"cartnum"] intValue]+[[NSString stringWithFormat:@"%@",self.Number.text] intValue]] forKey:@"cartnum"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"additembragevalue" object:nil];
    
}

-(void)Checkout{
    
    NSString *date=[self GetDate];
    NSString *getname=[self getname];
    FMDatabase *addtocartdb=[FMDatabase databaseWithPath:[self getdbpath]];

    
    if ([addtocartdb open]) {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"PassAddress"]isEqualToString:@""]) {
            XYAlertView *aler=[[XYAlertView alloc] initWithTitle:@"提示" message:@"您还没有输入联系方式和地址" buttons:[NSArray       arrayWithObjects:@"确定",nil] afterDismiss:^(int buttonIndex){
            }];
            [aler show];
            [aler release];
        }else{
        [addtocartdb executeUpdate:[NSString stringWithFormat:@"INSERT INTO UnFinishOrderData(CustomerID,OrderInfo,ProductID,Quantity,TotalPrice,Date,Address,ProductName,ProductImageURL) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@')",[[NSUserDefaults standardUserDefaults] objectForKey:@"CustomerID"],self.orderinformation,[[NSUserDefaults standardUserDefaults] objectForKey:@"passproductid"],self.Number.text,self.totalprice,date,[[NSUserDefaults standardUserDefaults] objectForKey:@"PassAddress"],getname,[[NSUserDefaults standardUserDefaults] objectForKey:@"proimageurl"]]];
        [self Message:@"购买成功!"];
    }[addtocartdb close];
        [MCSoundBoard playSoundForKey:@"checkout"];
    }
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    [def setObject:@"" forKey:@"PassAddress"];
//    [self checkusermoney];
    
}

-(void)Message:(NSString *)message{
    
    if ([message isEqualToString:@"余额不足!请充值."]) {
    XYAlertView *aler=[[XYAlertView alloc] initWithTitle:@"提示" message:message buttons:[NSArray       arrayWithObjects:@"确定",nil] afterDismiss:^(int buttonIndex){
        
    }];
    [aler show];
        [aler release];
    }else{
        XYAlertView *aler=[[XYAlertView alloc] initWithTitle:@"提示" message:message buttons:[NSArray       arrayWithObjects:@"确定",@"立即前往",nil] afterDismiss:^(int buttonIndex){
            if (buttonIndex==1) {
                if ([self.title isEqualToString:@"直接购买"]) {
                    FourViewController *pushview=[[[FourViewController alloc] init] autorelease];
                    FourNavigationViewController *nav=[[[FourNavigationViewController alloc] initWithRootViewController:pushview] autorelease];
                    [self presentViewController:nav animated:YES completion:nil];
                }else{
                    SecondViewController *pushview=[[[SecondViewController alloc] init] autorelease];
                    SecondNavigationViewController *nav=[[[SecondNavigationViewController alloc] initWithRootViewController:pushview] autorelease];
                    [self presentViewController:nav animated:YES completion:nil];
                }
            }
        }];
        [aler show];
        [aler release];
    }
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

-(NSString *)getname{
    NSString *name=@"";
        FMDatabase *db=[FMDatabase databaseWithPath:[[NSBundle mainBundle] pathForResource:@"SJGOData" ofType:@"sqlite"]];
        if ([db open]) {
            FMResultSet *getname=[db executeQuery:[NSString stringWithFormat:@"select ProductName from ProductData where ProductID='%@'",[[NSUserDefaults standardUserDefaults] objectForKey:@"passproductid"]]];
            while ([getname next]) {
                name=[getname stringForColumn:@"ProductName"];
            }[getname close];
        }[db close];
    return name;
    }

- (IBAction)resetkeyboard:(UIButton *)sender {
    if ([self.Number.text hasPrefix:@"0"]) {
        XYAlertView *aler=[[XYAlertView alloc] initWithTitle:@"提示" message:@"您的输入有误." buttons:[NSArray       arrayWithObjects:@"确定",nil] afterDismiss:^(int buttonIndex){
            if (buttonIndex==0) {
                [self.Number isFirstResponder];
            }
        }];
        [aler show];
        [aler release];
    }else{
    [self.Number resignFirstResponder];
    }
}

//- (IBAction)StepperValueChanged:(UIStepper *)sender {
//    if ([self.Number.text isEqualToString:@""]) {
//        self.Number.text=[NSString stringWithFormat:@"%d",(int)self.stepper.value];
//    }else{
//        self.Number.text=[NSString stringWithFormat:@"%d",(int)self.stepper.value];
//    }
//    
//}
@end
