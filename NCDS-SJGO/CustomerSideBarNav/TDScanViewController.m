//
//  TDScanViewController.m
//  NCDS-SJGO
//
//  Created by 徐子迈 on 13-1-2.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import "TDScanViewController.h"
#import "TDScanSubViewController.h"
#import "ProductdetailViewController.h"
#import "XYAlertView.h"
#import <QuartzCore/CALayer.h>
#import "FMDatabase.h"
#import "FirstViewController.h"

@interface TDScanViewController ()
@property (nonatomic, strong) ZBarImageScanner * zbarImageScanner;
@property (nonatomic, strong) UIImage * image;
@property (nonatomic, strong) ZBarSymbolSet * symbolSet;

@end

@implementation TDScanViewController
@synthesize _label=label;
@synthesize _imageview=imageview;
@synthesize top=_top;
//@synthesize navigationbar=_navigationbar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"二维码扫描";
        UIButton *leftbutton=[[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 52, 32)] autorelease];
        UIImage *image=[[UIImage imageNamed:@"navi_back_btn"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 15, 5, 10)];
        [leftbutton setBackgroundImage:image forState:UIControlStateNormal];
        UIImage *imageh=[[UIImage imageNamed:@"navi_back_btn_h"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 15, 5, 10)];
        [leftbutton setBackgroundImage:imageh forState:UIControlStateHighlighted];
        leftbutton.titleLabel.font=[UIFont systemFontOfSize:11];
        [leftbutton setTitle:@"  返   回" forState:UIControlStateNormal];
        [leftbutton setTitle:@"  返   回" forState:UIControlStateHighlighted];
        [leftbutton addTarget:self action:@selector(dismissview) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftitem=[[[UIBarButtonItem alloc] initWithCustomView:leftbutton] autorelease];
        self.navigationItem.leftBarButtonItem=leftitem;
        [self.view bringSubviewToFront:self.top];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    imageview.layer.masksToBounds=YES;
    imageview.layer.cornerRadius=self._imageview.frame.size.width/2;
    CALayer *celllayer=[imageview layer];
    celllayer.borderColor = [[UIColor whiteColor] CGColor];
    celllayer.borderWidth = 2.f;
    celllayer.masksToBounds=YES;
    celllayer.cornerRadius=celllayer.frame.size.width/2;
    
    self.readerView = [[[ZBarReaderView alloc] initWithImageScanner:[[[ZBarImageScanner alloc] init] autorelease]] autorelease];
    self.readerView.frame = CGRectMake(20, 22, 280, 230);
     CALayer *celllayer2=[self.readerView layer];
    celllayer2.borderColor = [[UIColor whiteColor] CGColor];
    celllayer2.borderWidth = 1.f;
    celllayer2.masksToBounds=YES;
    celllayer2.cornerRadius=celllayer.frame.size.width/2;
    
    UIImage *image=[UIImage imageNamed:@"tmall_scan_laser"];
    UIImageView *imvi=[[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 280, 22)];
    imvi.image=image;
    [self.readerView addSubview:imvi];
     self.zbarImageScanner = [ZBarImageScanner new];
    self.readerView.readerDelegate = self;
    [self.view addSubview:self.readerView];
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(movepull2) userInfo:nil repeats:YES];
    
}
-(void)movepull2{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //动画时间长度，单位秒，浮点数
    [UIView setAnimationDuration:1.5];
    [[self.readerView.subviews lastObject] setFrame:CGRectMake(0, 280, 280, 22)];
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
    [self performSelector:@selector(movepull3) withObject:nil afterDelay:1.5];
    //    [self movepull3];
}
-(void)movepull3{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //动画时间长度，单位秒，浮点数
    [UIView setAnimationDuration:1.5];
    [[self.readerView.subviews lastObject] setFrame:CGRectMake(0, 0, 280, 22)];
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
}
-(void)viewDidAppear:(BOOL)animated{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"Camera"] isEqualToString:@"打开"]) {
        
//      [self button:nil];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [self movepull2];
    self.readerView.hidden=NO;
    [[self.readerView.subviews lastObject] setHidden:NO];
[self.readerView start];
}
-(void)viewDidDisappear:(BOOL)animated{
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    [def setObject:@"关闭" forKey:@"Camera"];
    [self.readerView stop];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dismissview{
    [self dismissViewControllerAnimated:YES completion:Nil];
}

- (void) change:(id) sender {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentModalViewController:picker animated:YES];
    [[self.readerView.subviews lastObject] setHidden:YES];
}
- (void) scannerImage {
    ZBarImage * zbarImage = [[[ZBarImage alloc] initWithCGImage:self.image.CGImage] autorelease];
    int status = [self.zbarImageScanner scanImage:zbarImage];
    self.symbolSet = self.zbarImageScanner.results;
    [self dealWithStatus:status];
}

- (void) dealWithStatus:(int) status{
    if (status == 0) {
        self._label.text=@"";
    } else {

        for (ZBarSymbol * symbol in self.symbolSet) {
            NSString * data = [NSString stringWithFormat:@"%@",symbol.data];
            self._label.text=data;
        }
    }

}
- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{   
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self._imageview.image=image;
    self.image=image;
    [reader dismissModalViewControllerAnimated:YES];
    self.readerView.hidden=YES;
    [self.readerView stop];
    [self scannerImage];
}
- (void)dealloc {
    [label release];
    [imageview release];

//    [_navigationbar release];
    [_top release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self set_label:nil];
    [self set_imageview:nil];

//    [self setNavigationbar:nil];
    [self setTop:nil];
    [super viewDidUnload];
}
-(void)GoOnScan{
    self.readerView.hidden=NO;
    [self.readerView start];
}
- (IBAction)button:(UIButton *)sender {
    [[self.readerView.subviews lastObject] setHidden:NO];
    [self GoOnScan];
}

- (void) readerView: (ZBarReaderView*) readerView didReadSymbols: (ZBarSymbolSet*) symbols fromImage: (UIImage*) image {
    XYAlertView *aler=[XYAlertView alertViewWithTitle:@"提醒！" message:@"已经扫描到二维码！" buttons:[NSArray arrayWithObjects:@"确定", nil] afterDismiss:^(int buttonIndex) {
        
    }];
    
    [aler show];
    [self.readerView stop];
    [[self.readerView.subviews lastObject] setHidden:YES];
    self.readerView.hidden=YES;
    
    for (ZBarSymbol * symbol in symbols) {
        NSString * data = [NSString stringWithFormat:@"%@",symbol.data];
        self._label.text=data;
    }

    self._imageview.image=image;
}

-(BOOL)getprodata{
    FMDatabase *db=[FMDatabase databaseWithPath:[[NSBundle mainBundle] pathForResource:@"SJGOData" ofType:@"sqlite"]];
    if ([db open]) {
        
            FMResultSet *dbresult=[db executeQuery:[NSString stringWithFormat:@"SELECT * FROM ProductData WHERE ProductID='%@'",self._label.text]];
            if ([dbresult next]) {
                
                return YES;
            }else{
                return NO;
            }[dbresult close];
    }else{
        return NO;
    }
}
- (IBAction)pushtosub:(UIButton *)sender {
//    self._label.text=@"17170478779 ";//测试用
    if (![self._label.text isEqualToString:@""]) {
    NSString *proid=self._label.text;
        NSString *trimmedString = [proid stringByTrimmingCharactersInSet:
                                   [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    [def setObject:trimmedString forKey:@"passproductid"];
        if ([self getprodata]) {
            ProductdetailViewController *sub=[[[ProductdetailViewController alloc] init] autorelease];
            sub.title=@"产品描述";
            [self.navigationController pushViewController:sub animated:YES];
        }else{
            XYAlertView *aler=[XYAlertView alertViewWithTitle:@"提醒！" message:@"没有找到相应的商品！" buttons:[NSArray arrayWithObjects:@"确定", nil] afterDismiss:^(int buttonIndex) {
                
            }];
            
            [aler show];
            
        }
    }else{
        
        XYAlertView *aler=[XYAlertView alertViewWithTitle:@"提醒！" message:@"扫描失败！" buttons:[NSArray arrayWithObjects:@"取消", nil] afterDismiss:^(int buttonIndex) {
            if (buttonIndex==0) {
                [self button:Nil];
            }
        }];
        [aler show];
    }
}

//没用到的方法

-(void)captureReader:(ZBarCaptureReader *)captureReader didReadNewSymbolsFromImage:(ZBarImage *)image{
    
}

- (IBAction)Getimagepicker:(UIButton *)sender {
    [self.readerView stop];
    [self change:nil];
}

@end
