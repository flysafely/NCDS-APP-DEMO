//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//
#import <UIKit/UIKit.h>
#import "FaceViewController.h"
#import "AsyncUdpSocket.h"
#import "IPAddress.h"
#import "XYAlertView.h"
@class BaseTabBarController;

@interface ChatViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate> {
	NSString                   *_titleString;
	NSMutableString            *_messageString;
	NSString                   *_phraseString;
	NSMutableArray		       *_chatArray;
	
	UITableView                *_chatTableView;
	UITextField                *_messageTextField;
	BOOL                       _isFromNewSMS;
	FaceViewController      *_phraseViewController;
	AsyncUdpSocket             *_udpSocket;
	NSDate                     *_lastTime;

    
}

@property (nonatomic, retain) BaseTabBarController *basetempController;
//@property (nonatomic, retain) IBOutlet FaceViewController   *phraseViewController;
@property (nonatomic, retain) IBOutlet UITableView            *chatTableView;
@property (nonatomic, retain) IBOutlet UITextField            *messageTextField;
@property (nonatomic, retain) NSString               *phraseString;
@property (nonatomic, retain) NSString               *titleString;
@property (nonatomic, retain) NSString        *messageString;
@property (nonatomic, retain) NSMutableArray		 *chatArray;

@property (nonatomic, retain) NSDate                 *lastTime;
@property (nonatomic, retain) AsyncUdpSocket         *udpSocket;
@property (retain, nonatomic) IBOutlet UIToolbar *toolBar;
//@property (retain, nonatomic) IBOutlet UIButton *backbt;
@property BOOL FirstTime;
@property (retain,nonatomic) NSString *Host;
@property (retain,nonatomic) UIImage *Meimage;

-(IBAction)sendMessage_Click:(id)sender;
//-(IBAction)showPhraseInfo:(id)sender;


-(void)openUDPServer;
-(void)sendMassage:(NSString *)message;
//-(void)deleteContentFromTableView;

- (UIView *)bubbleView:(NSString *)text from:(BOOL)fromSelf;

-(void)getImageRange:(NSString*)message : (NSMutableArray*)array;
-(UIView *)assembleMessageAtIndex : (NSString *) message from: (BOOL)fromself;
- (IBAction)Pop:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UIToolbar *TextFieldTooBar;



@end
