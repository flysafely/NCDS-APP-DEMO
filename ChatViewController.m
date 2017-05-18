//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//

#import "ChatViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ChatCustomCell.h"
#import "MCSoundBoard.h"
//#import "URBAlertView.h"
#define TOOLBARTAG		200
#define TABLEVIEWTAG	300


#define BEGIN_FLAG @"[/"
#define END_FLAG @"]"

@interface ChatViewController (Private)

- (void)bounceOutAnimationStopped;
- (void)bounceInAnimationStopped;

@end

@implementation ChatViewController
@synthesize titleString = _titleString;
@synthesize chatArray = _chatArray;
@synthesize chatTableView = _chatTableView;
@synthesize messageTextField = _messageTextField;
//@synthesize phraseViewController = _phraseViewController;
@synthesize udpSocket = _udpSocket;
@synthesize messageString = _messageString;
@synthesize phraseString = _phraseString;
@synthesize lastTime = _lastTime;

@synthesize basetempController;
@synthesize TextFieldTooBar=_TextFieldTooBar;
@synthesize toolBar=_toolBar;
//@synthesize backbt=_backbt;
@synthesize FirstTime=_FirstTime;
@synthesize Host=_Host;
@synthesize Meimage=_Meimage;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

- (void)viewDidLoad {
    [self openUDPServer];
    [self getimage:[[NSUserDefaults standardUserDefaults] objectForKey:@"CustomerID"]];
//    [self sendMassage:@"我已登录"];
    
    self.TextFieldTooBar.hidden=YES;
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
    
    UIImage *texttoolimage=[UIImage imageNamed:@"textfield"];
    if ([self.TextFieldTooBar respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)]) {
        [self.TextFieldTooBar setBackgroundImage:texttoolimage forToolbarPosition:0 barMetrics:0];
    }//设置toolbar的背景图片
    self.TextFieldTooBar.layer.shadowPath=[UIBezierPath bezierPathWithRect:self.toolBar.bounds].CGPath;
    self.TextFieldTooBar.layer.shadowOffset = CGSizeMake(0, 0);
    self.TextFieldTooBar.layer.shadowColor = [UIColor blackColor].CGColor;
    self.TextFieldTooBar.layer.shadowOpacity = 0.7;

    
//    UIImage *btimage=[UIImage imageNamed:@"nux-red-button.png"];
//    btimage=[btimage resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
//    
//    [self.backbt setBackgroundImage:btimage forState:UIControlStateNormal];
    UIImage *textimage=[UIImage imageNamed:@"sms_input_conver"];
    textimage=[textimage resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
    [self.messageTextField setBackground:textimage];
    [self.messageTextField setTextColor:[UIColor darkGrayColor]];
    
    self.FirstTime=YES;
    UIImage *image = [UIImage imageNamed:@"backitem.png"];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    [backBtn setBackgroundImage:image forState:UIControlStateNormal];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc ] initWithCustomView:backBtn ];
    self.navigationItem.leftBarButtonItem = backItem;
    [backItem release];

//    self.phraseViewController.chatViewController = self;
    
   	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	self.chatArray = tempArray;
	[tempArray release];
	
    NSMutableString *tempStr = [[NSMutableString alloc] initWithFormat:@""];
    self.messageString = tempStr;
    [tempStr release];
		
	NSDate   *tempDate = [[NSDate alloc] init];
	self.lastTime = tempDate;
	[tempDate release];
    
    
    //监听键盘高度的变换 
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // 键盘高度变化通知，ios5.0新增的  
#ifdef __IPHONE_5_0
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 5.0) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
#endif
    [self sendMassage:@"我已登录"];
}

//-(void) dismissSelf{
//    [self dismissModalViewControllerAnimated:YES];
//}
-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:YES];
	self.title = @"IM通信";
	[self.messageTextField setText:self.messageString];
	[self.chatTableView reloadData];
}
-(void)viewDidAppear:(BOOL)animated{

}

-(void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
	
}
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [self setToolBar:nil];
    [self setTextFieldTooBar:nil];
    [super viewDidUnload];
  
}


- (void)dealloc {
	[_lastTime release];
	[_phraseString release];
	[_messageString release];
	[_udpSocket release];
	[_phraseViewController release];
	[_messageTextField release];
	[_chatArray release];
	[_titleString release];
	[_chatTableView release];
    
    [_toolBar release];
//    [_backbt release];
    [_TextFieldTooBar release];
    [super dealloc];
}


//建立基于UDP的Socket连接
-(void)openUDPServer{
	//初始化udp
	AsyncUdpSocket *tempSocket=[[AsyncUdpSocket alloc] initWithDelegate:self];
	self.udpSocket=tempSocket;
	[tempSocket release];
	//绑定端口
	NSError *error = nil;
	[self.udpSocket bindToPort:8888 error:&error];
    [self.udpSocket joinMulticastGroup:@"224.0.0.3" error:&error];
    
   	//启动接收线程
	[self.udpSocket receiveWithTimeout:-2 tag:0];
  
}
//发送消息
-(IBAction)sendMessage_Click:(id)sender
{	
	NSString *messageStr = self.messageTextField.text;
    self.messageString = self.messageTextField.text;
    
    if (messageStr == nil)
    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发送失败！" message:@"发送的内容不能为空！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alert show];
//        [alert release];
        XYAlertView *aler=[XYAlertView alertViewWithTitle:@"发送失败！" message:@"发送的内容不能为空！" buttons:[NSArray arrayWithObjects:@"确定", nil] afterDismiss:^(int buttonIndex) {
            
        }];
        
        [aler show];
    }else
    {
    [self sendMassage:messageStr];
    }
	self.messageTextField.text = @"";
    self.messageString = self.messageTextField.text;
//	[_messageTextField resignFirstResponder];
    [self keyboardWillHide:nil];
    [_messageTextField resignFirstResponder];

}
//通过UDP,发送消息
-(void)sendMassage:(NSString *)message
{   
    NSString *username=[[NSUserDefaults standardUserDefaults] objectForKey:@"CustomerNickname"];
    int lengthofname=[username length];
//    NSLog(@"名字长度是%d",lengthofname);

	NSMutableString *sendString=[NSMutableString stringWithCapacity:100];
    //添加用户名具体信息
    [sendString appendFormat:@"%d",lengthofname];
    [sendString appendString:[[NSUserDefaults standardUserDefaults] objectForKey:@"CustomerNickname"]];
    //添加信息内容
	[sendString appendString:message];
    
    NSDate *nowTime = [NSDate date];
   NSLog(@"名字长度是%@",sendString);
	//开始发送
	BOOL res = [self.udpSocket sendData:[sendString dataUsingEncoding:NSUTF8StringEncoding] 
								 toHost:@"224.0.0.1"
								   port:8888
							withTimeout:-1 
                                   tag:0];
    

   	if (!res) {

        XYAlertView *aler=[XYAlertView alertViewWithTitle:@"发送失败！" message:@"发送的内容不能为空！" buttons:[NSArray arrayWithObjects:@"确定", nil] afterDismiss:^(int buttonIndex) {
            
        }];
        
        [aler show];
        return;
	}
	
	if ([self.chatArray lastObject] == nil) {
		self.lastTime = nowTime;
		[self.chatArray addObject:nowTime];
	}
	// 发送后生成泡泡显示出来
	NSTimeInterval timeInterval = [nowTime timeIntervalSinceDate:self.lastTime];
	if (timeInterval >5) {
		self.lastTime = nowTime;
		[self.chatArray addObject:nowTime];
	}	
    UIView *chatView = [self bubbleView:[NSString stringWithFormat:@"%@: %@", NSLocalizedString([[NSUserDefaults standardUserDefaults] objectForKey:@"CustomerNickname"],nil), message]
								   from:YES];
	[self.chatArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:message, @"text", @"self", @"speaker", chatView, @"view", nil]];
       
	
	[self.chatTableView reloadData];
	[self.chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.chatArray count]-1 inSection:0] 
							  atScrollPosition: UITableViewScrollPositionBottom 
									  animated:YES];
}


-(void)getimage:(NSString *)uuid{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
    NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",uuid]];
    NSData *data=[NSData dataWithContentsOfFile:uniquePath];
    if (data==nil) {
        self.Meimage=[UIImage imageNamed:@"tmcontact_blank"];
    }else{
        self.Meimage=[UIImage imageWithData:data];
    }
}
#pragma mark -
#pragma mark Table view methods
/*
 生成泡泡UIView
 */
- (UIView *)bubbleView:(NSString *)text from:(BOOL)fromSelf {
	// build single chat bubble cell with given text
    UIView *returnView =  [self assembleMessageAtIndex:text from:fromSelf];
    returnView.backgroundColor = [UIColor clearColor];
    UIView *cellView = [[UIView alloc] initWithFrame:CGRectZero];
    cellView.backgroundColor = [UIColor clearColor];
    
	UIImage *bubble = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fromSelf?@"SenderTextNodeBkg":@"ReceiverTextNodeBkg" ofType:@"png"]];
	UIImageView *bubbleImageView = [[UIImageView alloc] initWithImage:[bubble resizableImageWithCapInsets:UIEdgeInsetsMake(30, 20, 20, 25)]];
    
       UIImageView *headImageView = [[UIImageView alloc] init];
    UIImageView *headImageBox=[[UIImageView alloc] init];
    if(fromSelf){
        [headImageBox setImage:[UIImage imageNamed:@"UserHeaderImageBox.png"]];
        [headImageView setImage:self.Meimage];
        returnView.frame= CGRectMake(9.0f, 15.0f, returnView.frame.size.width, returnView.frame.size.height);
        bubbleImageView.frame = CGRectMake(0.0f, 4.0f, returnView.frame.size.width+28.0f, returnView.frame.size.height+48.0f );
        cellView.frame = CGRectMake(265.0f-bubbleImageView.frame.size.width, 0.0f,bubbleImageView.frame.size.width+50.0f, bubbleImageView.frame.size.height+10.0f);
        headImageView.frame = CGRectMake(bubbleImageView.frame.size.width+5, cellView.frame.size.height-54.0f, 40.0f, 40.0f);
        headImageBox.frame=CGRectMake(bubbleImageView.frame.size.width+2, cellView.frame.size.height-55.0f, 46.0f, 46.0f);
    }
	else{
        
        [headImageView setImage:[UIImage imageNamed:@"NCDS-BG"]];
        returnView.frame= CGRectMake(65.0f, 15.0f, returnView.frame.size.width, returnView.frame.size.height);
       bubbleImageView.frame = CGRectMake(50.0f, 4.0f, returnView.frame.size.width+24.0f, returnView.frame.size.height+48.0f);
		cellView.frame = CGRectMake(0.0f, 0.0f, bubbleImageView.frame.size.width+50.0f,bubbleImageView.frame.size.height+10.0f);
         headImageView.frame = CGRectMake(5.0f, cellView.frame.size.height-54.0f, 40.0f, 40.0f);
        
    }
    

    [cellView addSubview:headImageBox];
    [cellView addSubview:bubbleImageView];
    [cellView addSubview:headImageView];
    [cellView addSubview:returnView];
    [bubbleImageView release];
    [returnView release];
    [headImageView release];
	return [cellView autorelease];
    
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark UDP Delegate Methods
//解析收到的信息
-(NSString *)GetUserName:(NSString *)info Getinfo:(BOOL)infomation{
    if (infomation) {
        int usernamelength=[[info substringWithRange:NSMakeRange(0, 1)] intValue];
        NSString *theinfo=[info substringWithRange:NSMakeRange(usernamelength+1,([info length]- (usernamelength+1)))];
        return theinfo;
    }else{
    int usernamelength=[[info substringWithRange:NSMakeRange(0, 1)] intValue];
    NSString *username=[info substringWithRange:NSMakeRange(1, usernamelength)];
    return username;
    }
}

- (BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port
{
    NSString *info=[[[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding] autorelease];
    NSLog(@"收到的信息内容是:%@",info);
    
    if (self.FirstTime) {//不接受自己发送的信息
        self.Host=host;
        self.FirstTime=!self.FirstTime;
    }
    if (![host isEqualToString:self.Host]) {

    NSLog(@"消息来源地IP:%@",host);
    [self.udpSocket receiveWithTimeout:-1 tag:0];
   	//接收到数据回调，用泡泡VIEW显示出来
	NSString *info=[[[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding] autorelease];

        UIView *chatView = [self bubbleView:[NSString stringWithFormat:@"%@:%@",[self GetUserName:info Getinfo:NO], [self GetUserName:info Getinfo:YES]]
                                       from:NO];
        
	[self.chatArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:info, @"text", @"other", @"speaker", chatView, @"view", nil]];
//	}
	[self.chatTableView reloadData];
	[self.chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.chatArray count]-1 inSection:0] 
							  atScrollPosition: UITableViewScrollPositionBottom 
									  animated:YES];
	//已经处理完毕
        [MCSoundBoard playSoundForKey:@"message"];
        NSLog(@"一共有%d条聊天记录",[self.chatArray count]);
//    return YES;
        return YES;
        }else{
            return NO;
        }
}

- (void)onUdpSocket:(AsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error
{
	//无法发送时,返回的异常提示信息
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
													message:[error description]
												   delegate:self
										  cancelButtonTitle:@"取消"
										  otherButtonTitles:nil];
	[alert show];
	[alert release];
	
}
- (void)onUdpSocket:(AsyncUdpSocket *)sock didNotReceiveDataWithTag:(long)tag dueToError:(NSError *)error
{   
	//无法接收时，返回异常提示信息
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
													message:[error description]
												   delegate:self
										  cancelButtonTitle:@"取消"
										  otherButtonTitles:nil];
	[alert show];
	[alert release];	
}

#pragma mark -
#pragma mark Table View DataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.chatArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if ([[self.chatArray objectAtIndex:[indexPath row]] isKindOfClass:[NSDate class]]) {
		return 30;
	}else {
		UIView *chatView = [[self.chatArray objectAtIndex:[indexPath row]] objectForKey:@"view"];
		return chatView.frame.size.height+10;
	}
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *CommentCellIdentifier = @"CommentCell";
	ChatCustomCell *cell = (ChatCustomCell*)[tableView dequeueReusableCellWithIdentifier:CommentCellIdentifier];
	if (cell == nil) {
		cell = [[[NSBundle mainBundle] loadNibNamed:@"ChatCustomCell" owner:self options:nil] lastObject];
	}
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	if ([[self.chatArray objectAtIndex:[indexPath row]] isKindOfClass:[NSDate class]]) {
		// Set up the cell...
		NSDateFormatter  *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:@"yy-MM-dd HH:mm"];
		NSMutableString *timeString = [NSMutableString stringWithFormat:@"%@",[formatter stringFromDate:[self.chatArray objectAtIndex:[indexPath row]]]];
		[formatter release];
				
		[cell.dateLabel setText:timeString];
        [cell.dateLabel setFont:[UIFont systemFontOfSize:11]];//日期字体大小
		
	}else {
		// Set up the cell...
		NSDictionary *chatInfo = [self.chatArray objectAtIndex:[indexPath row]];
		UIView *chatView = [chatInfo objectForKey:@"view"];
		[cell.contentView addSubview:chatView];
	}
    return cell;
}
#pragma mark -
#pragma mark Table View Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.messageTextField resignFirstResponder];
}
#pragma mark -
#pragma mark TextField Delegate Methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	if(textField == self.messageTextField)
	{
//		[self moveViewUp];
	}
}

-(void) autoMovekeyBoard: (float) h{
    
    UIToolbar *toolbar = (UIToolbar *)[self.view viewWithTag:TOOLBARTAG];
	toolbar.frame = CGRectMake(0.0f, (float)(588.0-h-108.0), 320.0f, 44.0f);
	UITableView *tableView = (UITableView *)[self.view viewWithTag:TABLEVIEWTAG];
	tableView.frame = CGRectMake(0.0f, 0.0f, 320.0f,(float)(588.0-h-108.0));
    
}

#pragma mark -
#pragma mark Responding to keyboard events
- (void)keyboardWillShow:(NSNotification *)notification {
    self.TextFieldTooBar.hidden=NO;

    /*
     Reduce the size of the text view so that it's not obscured by the keyboard.
     Animate the resize so that it's in sync with the appearance of the keyboard.
     */
    
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    CGRect keyboardRect = [aValue CGRectValue];
    
    // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
    [self autoMovekeyBoard:keyboardRect.size.height];
}


- (void)keyboardWillHide:(NSNotification *)notification {
    self.TextFieldTooBar.hidden=YES;

    NSDictionary* userInfo = [notification userInfo];

    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    

    [self autoMovekeyBoard:0];
}




//图文混排

-(void)getImageRange:(NSString*)message : (NSMutableArray*)array {
    NSRange range=[message rangeOfString: BEGIN_FLAG];
    NSRange range1=[message rangeOfString: END_FLAG];
    //判断当前字符串是否还有表情的标志。
    if (range.length>0 && range1.length>0) {
        if (range.location > 0) {
            [array addObject:[message substringToIndex:range.location]];
            [array addObject:[message substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)]];
            NSString *str=[message substringFromIndex:range1.location+1];
            [self getImageRange:str :array];
        }else {
            NSString *nextstr=[message substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)];
            //排除文字是“”的
            if (![nextstr isEqualToString:@""]) {
                [array addObject:nextstr];
                NSString *str=[message substringFromIndex:range1.location+1];
                [self getImageRange:str :array];
            }else {
                return;
            }
        }
        
    } else if (message != nil) {
            [array addObject:message];
        }
}

#define KFacialSizeWidth  18
#define KFacialSizeHeight 18
#define MAX_WIDTH 150
-(UIView *)assembleMessageAtIndex : (NSString *) message from:(BOOL)fromself
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self getImageRange:message :array];
    UIView *returnView = [[UIView alloc] initWithFrame:CGRectZero];
    NSArray *data = array;
    UIFont *fon = [UIFont systemFontOfSize:13.0f];
    CGFloat upX = 0;
    CGFloat upY = 0;
    CGFloat X = 0;
    CGFloat Y = 0;
    if (data) {
        for (int i=0;i < [data count];i++) {
            NSString *str=[data objectAtIndex:i];
//            NSLog(@"str--->%@",str);
            
                if ([str hasPrefix: BEGIN_FLAG] && [str hasSuffix: END_FLAG])
            {
                if (upX >= MAX_WIDTH)
                {
                    upY = upY + KFacialSizeHeight;
                    upX = 0;
                    X = 150;
                    Y = upY;
                }
//                NSLog(@"str(image)---->%@",str);
                NSString *imageName=[str substringWithRange:NSMakeRange(2, str.length - 3)];
                UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
                img.frame = CGRectMake(upX, upY, KFacialSizeWidth, KFacialSizeHeight);
                [returnView addSubview:img];
                [img release];
                upX=KFacialSizeWidth+upX;
                if (X<150) X = upX;
                    
                
            } else {
                for (int j = 0; j < [str length]; j++) {
                    NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
                    if (upX >= MAX_WIDTH)
                    {
                        upY = upY + KFacialSizeHeight;
                        upX = 0;
                        X = 150;
                        Y =upY;
                    }
                    CGSize size=[temp sizeWithFont:fon constrainedToSize:CGSizeMake(150, 40)];
                    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(upX,upY,size.width,size.height)];
                    la.font = fon;
                    la.text = temp;
                    la.backgroundColor = [UIColor clearColor];
                    [returnView addSubview:la];
                    [la release];
                    upX=upX+size.width;
                    if (X<150) {
                        X = upX;
                    }
                }
            }
        }
    }
    returnView.frame = CGRectMake(15.0f,1.0f, X, Y); //@ 需要将该view的尺寸记下，方便以后使用
    NSLog(@"%.1f %.1f", X, Y);
    return returnView;
}
- (IBAction)Pop:(UIButton *)sender {
//    [self.udpSocket retain];
[self dismissModalViewControllerAnimated:YES];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self sendMessage_Click:nil];
    [self keyboardWillHide:nil];
    [self.messageTextField resignFirstResponder];
    return YES;
}


@end
