//
//  TDScanViewController.h
//  NCDS-SJGO
//
//  Created by 徐子迈 on 13-1-2.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"
//#import "QRCodeGenerator.h"
#import <QuartzCore/CALayer.h>
#import "UINavigationBar+CateNavigationBar.h"
#import <AVFoundation/AVFoundation.h>
@interface TDScanViewController : UIViewController<ZBarReaderDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (retain, nonatomic) IBOutlet UIImageView *_imageview;

@property (retain, nonatomic) IBOutlet UILabel *_label;
//@property (retain, nonatomic) IBOutlet UINavigationItem *navigationbar;
@property (nonatomic, strong) ZBarReaderView * readerView;
- (IBAction)button:(UIButton *)sender;

//- (IBAction)back:(UIBarButtonItem *)sender;
- (IBAction)pushtosub:(UIButton *)sender;
//-(void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image;
-(void)captureReader:(ZBarCaptureReader *)captureReader didReadNewSymbolsFromImage:(ZBarImage *)image;
- (IBAction)Getimagepicker:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UIImageView *top;
@end
