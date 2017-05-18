//
//  ProductdetailViewController.m
//  NCDS-SJGO
//
//  Created by 徐子迈 on 13-1-7.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import "ProductdetailViewController.h"
#import <QuartzCore/CALayer.h>
#import "FMDatabase.h"
#import "PraisedetailViewController.h"
#import "PickerViewController.h"
#import "UIImageView+WebCache.h"
#import "XYAlertView.h"
#import "CheckInViewController.h"
#import "MCSoundBoard.h"
#import "FVImageSequenceDemoViewController.h"

@interface ProductdetailViewController ()


@end

@implementation ProductdetailViewController
@synthesize scrollview=_scrollview;
@synthesize imageid=_imageid;
@synthesize Pricelabel=_Pricelabel;
@synthesize Productdescription=_Productdescription;
@synthesize Productnamelabel=_Productnamelabel;
@synthesize productid=_productid;
@synthesize sales=_sales;
@synthesize praise=_praise;
@synthesize likebtn=_likebtn;
@synthesize Buyit=_Buyit;
@synthesize AddtoUserCart=_AddtoUserCart;
@synthesize infoview=_infoview;
@synthesize web=_web;
@synthesize WebIsShowing=_WebIsShowing;
@synthesize webdesc=_webdesc;
@synthesize bgview=_bgview;
@synthesize bigimage=_bigimage;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //自定义leftbarbuttonitem
    self.WebIsShowing=NO;
    self.infoview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Gomall_bg_main"]];
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
    
    //自定义rightbarbuttonitem
    UIButton *rightbutton=[[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 51, 32)] autorelease];
    UIImage *rimage=[[UIImage imageNamed:@"navi_btn"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 15, 5, 10)];
    [rightbutton setBackgroundImage:rimage forState:UIControlStateNormal];
    UIImage *rimageh=[[UIImage imageNamed:@"navi_btn_h"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 15, 5, 10)];
    [rightbutton setBackgroundImage:rimageh forState:UIControlStateHighlighted];
    rightbutton.titleLabel.font=[UIFont systemFontOfSize:11];
    [rightbutton setTitle:@"评价详情" forState:UIControlStateNormal];
    [rightbutton setTitle:@"评价详情" forState:UIControlStateHighlighted];
    [rightbutton addTarget:self action:@selector(pushtopraise) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightitem=[[UIBarButtonItem alloc] initWithCustomView:rightbutton];
    self.navigationItem.rightBarButtonItem=rightitem;
    //添加购物车按钮和直接购买按钮设置
    UIImage *Createbg=[[UIImage imageNamed:@"tmall_button_detail_buy_normal"] autorelease];
    Createbg=[Createbg resizableImageWithCapInsets:UIEdgeInsetsMake(3, 3, 3, 3)];
    UIImage *presscreatebg=[[UIImage imageNamed:@"tmall_button_detail_buy_down"] autorelease];
    presscreatebg=[presscreatebg resizableImageWithCapInsets:UIEdgeInsetsMake(3, 3, 3, 3)];
    
    UIImage *Createbuybg=[[UIImage imageNamed:@"tmall_button_detail_Shoppingcart_normal"] autorelease];
    Createbuybg=[Createbuybg resizableImageWithCapInsets:UIEdgeInsetsMake(3, 3, 3, 3)];
    UIImage *presscreatebuybg=[[UIImage imageNamed:@"tmall_button_detail_Shoppingcart_down"] autorelease];
    presscreatebuybg=[presscreatebuybg resizableImageWithCapInsets:UIEdgeInsetsMake(3, 3, 3, 3)];
    [self.AddtoUserCart setBackgroundImage:Createbuybg forState:UIControlStateNormal];
    [self.AddtoUserCart setBackgroundImage:presscreatebuybg forState:UIControlStateHighlighted];
    [self.Buyit setBackgroundImage:Createbg forState:UIControlStateNormal];
    [self.Buyit setBackgroundImage:presscreatebg forState:UIControlStateHighlighted];
//分享后的图标点亮
    self.likebtn.image=[UIImage imageNamed:@"icon_detail_like_normal"];
    //细节页面滚动布局
    self.scrollview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"tmall_bg_Detail_bg"]];
    FMDatabase *prodb=[FMDatabase databaseWithPath:[[NSBundle mainBundle] pathForResource:@"SJGOData" ofType:@"sqlite"]];
    if ([prodb open]) {
        FMResultSet *proresult=[prodb executeQuery:[NSString stringWithFormat:@"SELECT * FROM ProductData WHERE ProductID='%@'",[[NSUserDefaults standardUserDefaults] objectForKey:@"passproductid"]]];
        while ([proresult next]) {
            NSString *ID=[NSString stringWithFormat:@"%d",[proresult intForColumn:@"ProductID"]];
            NSString *proname=[proresult stringForColumn:@"ProductName"];
            //Web 详细信息获取
            NSString *html=[proresult stringForColumn:@"WebDesc"];
            self.webdesc=html;
            _web=[[UIWebView alloc] initWithFrame:CGRectMake(0, 550, 320, 480)];
            _web.backgroundColor=[UIColor clearColor];
            _web.scalesPageToFit=YES;
            
            [self.view addSubview:_web];
            
            NSString *prodescrption=[proresult stringForColumn:@"ProductDescription"];
            NSString *proprice=[NSString stringWithFormat:@"¥:%@",[proresult stringForColumn:@"ProductPrice"]];
            NSString *prosales=[NSString stringWithFormat:@"月销量:%@",[proresult stringForColumn:@"ProductSales"]];
            NSString *propraise=[NSString stringWithFormat:@"好评:%@",[proresult stringForColumn:@"ProductPraise"]];
            
            NSUserDefaults *name=[NSUserDefaults standardUserDefaults];
            [name setObject:[proresult stringForColumn:@"ProductName"] forKey:@"PassName"];
            NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
            [def setObject:[proresult stringForColumn:@"ProductPrice"] forKey:@"PassPrice"];
            NSUserDefaults *def2=[NSUserDefaults standardUserDefaults];
            [def2 setObject:[proresult stringForColumn:@"ProductImageID"] forKey:@"proimageurl"];
            
        _praise.text=propraise;
        _sales.text=prosales;
        _Pricelabel.text=proprice;
        _Productdescription.text=prodescrption;
        _Productnamelabel.text=proname;
        _productid=ID;

        NSString *proimage1=[NSString stringWithFormat:@"%@",[proresult stringForColumn:@"ProductPictures1"]];
        NSString *proimage2=[NSString stringWithFormat:@"%@",[proresult stringForColumn:@"ProductPictures2"]];
        NSString *proimage3=[NSString stringWithFormat:@"%@",[proresult stringForColumn:@"ProductPictures3"]];
        NSString *proimage4=[NSString stringWithFormat:@"%@",[proresult stringForColumn:@"ProductPictures4"]];

        self.imageid=[[[NSMutableArray alloc] initWithObjects:proimage1,proimage2,proimage3,proimage4,nil] autorelease];
        }[proresult close];
    }[prodb close];

    [_scrollview setContentSize:CGSizeMake(300,500)];//这个很重要..
    self.Scrollproductimage.layer.masksToBounds=YES;
    self.Scrollproductimage.layer.cornerRadius=2.0;
    self.Scrollproductimage.contentSize=CGSizeMake(4*193.,193.);
    for (int i=0; i<4; i++) {
//        UIImageView *imageview=[[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[self.imageid objectAtIndex:i]]]];   离线测试 代码！
        
        
        UIImageView *imageview=[[UIImageView alloc] init];
        [imageview setImageWithURL:[self.imageid objectAtIndex:i] placeholderImage:[UIImage imageNamed:@"nscd_bg"]];
        
        imageview.frame=CGRectMake((i)*193., 0., 193., 193.);
        imageview.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(MakeImageBiger)];
        singleTap.delegate=self;
        singleTap.numberOfTapsRequired=1;
        [imageview addGestureRecognizer:singleTap];
        
        [singleTap release];
        [self.Scrollproductimage addSubview:imageview];
    }
    //添加放大效果
    self.bgview=[[UIView alloc] initWithFrame:self.view.bounds];
    self.bgview.backgroundColor=[UIColor blackColor];
    self.bgview.alpha=0.;
    self.bgview.userInteractionEnabled=YES;    
    
    self.bigimage=[[UIImageView alloc] initWithFrame:CGRectMake(12, 22, 193, 193)];
    self.bigimage.userInteractionEnabled=YES;
    
    [self.view addSubview:self.bgview];
    [self.view addSubview:self.bigimage];
    [self.view bringSubviewToFront:self.bgview];
    [self.view bringSubviewToFront:self.bigimage];
    self.bgview.hidden=YES;
    self.bigimage.hidden=YES;

    [self addmenu];//添加分享按钮....

}


-(void)MakeImageBiger{

    self.bgview.userInteractionEnabled=YES;
    self.bigimage.hidden=NO;
    self.bgview.hidden=NO;

    [self pushimage];
}
-(void)popimage{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.6];//动画时间长度，单位秒，浮点数

    self.bigimage.Frame=CGRectMake(12, 22, 193, 193);
    self.bgview.alpha=0.0;
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
    [self performSelector:@selector(hideimage) withObject:nil afterDelay:0.6];
    [self performSelector:@selector(uninteraction) withObject:nil afterDelay:0.6];

}
-(void)uninteraction{
    self.bgview.userInteractionEnabled=NO;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popimage)];
    singleTap.delegate=self;
    singleTap.numberOfTapsRequired=1;
    [self.bgview removeGestureRecognizer:singleTap];
}
-(void)interaction{
    self.bgview.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popimage)];
    singleTap.delegate=self;
    singleTap.numberOfTapsRequired=1;
    [self.bgview addGestureRecognizer:singleTap];
}
-(void)hideimage{
    self.bigimage.hidden=YES;
    self.bgview.hidden=YES;
}
-(void)pushimage{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.6];//动画时间长度，单位秒，浮点数
    self.bigimage.image=[(UIImageView *)[self.Scrollproductimage.subviews objectAtIndex:self.pagecontrol.currentPage] image];
    self.bigimage.hidden=NO;
    self.bgview.hidden=NO;
    self.bigimage.Frame=CGRectMake(0, 80, 320, 320);
    self.bgview.alpha=0.7;
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
    [self performSelector:@selector(interaction) withObject:nil afterDelay:0.6];
}
-(void)addmenu{
    UIImage *storyMenuItemImage = [UIImage imageNamed:@"socialitembg"];
    UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"socialitembg"];
    
    // weibo MenuItem.
    QuadCurveMenuItem *weiboMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                                highlightedImage:storyMenuItemImagePressed
                                                                    ContentImage:[UIImage imageNamed:@"share_to_sinaweibo_icon"]
                                                         highlightedContentImage:nil];
    // facebook MenuItem.
    QuadCurveMenuItem *facebookMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                                highlightedImage:storyMenuItemImagePressed
                                                                    ContentImage:[UIImage imageNamed:@"facebook"]
                                                         highlightedContentImage:nil];
    // twitter MenuItem.
    QuadCurveMenuItem *twitterMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed
                                                                   ContentImage:[UIImage imageNamed:@"twitter"]
                                                        highlightedContentImage:nil];
    //check in  MenuItem
    QuadCurveMenuItem *checkin = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                                 highlightedImage:storyMenuItemImagePressed
                                                                     ContentImage:[UIImage imageNamed:@"main_btn_bd_hl"]
                                                          highlightedContentImage:nil];
    
    NSArray *menus = [NSArray arrayWithObjects:weiboMenuItem, facebookMenuItem, twitterMenuItem,checkin, nil];
    [weiboMenuItem release];
    [facebookMenuItem release];
    [twitterMenuItem release];
    [checkin release];
    QuadCurveMenu *menu = [[QuadCurveMenu alloc] initWithFrame:self.view.bounds menus:menus];
    menu.delegate = self;
    menu.social=self;
    [self.view addSubview:menu];
    [self.view bringSubviewToFront:menu];
}

-(void)pop{
    if (self.WebIsShowing) {
        [self HideWebView];
    }else{
    [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)pushtopraise{
    PraisedetailViewController *pra=[[[PraisedetailViewController alloc] init] autorelease];
    pra.title=@"评价详情";
    [self.navigationController pushViewController:pra animated:YES];

}
-(void)pushtopick{
    PickerViewController *pickview=[[[PickerViewController alloc] init] autorelease];
    [self.navigationController pushViewController:pickview animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_Scrollproductimage.contentOffset.x >0 &&_Scrollproductimage.contentOffset.x<=193) {
        _pagecontrol.currentPage=1;
    }else if (_Scrollproductimage.contentOffset.x >193 &&_Scrollproductimage.contentOffset.x<=386){
        _pagecontrol.currentPage=2;
    }else if (_Scrollproductimage.contentOffset.x >386 &&_Scrollproductimage.contentOffset.x<=579){
        _pagecontrol.currentPage=3;
    }else if (_Scrollproductimage.contentOffset.x >579 &&_Scrollproductimage.contentOffset.x<=772){
        _pagecontrol.currentPage=4;
    }else if (_Scrollproductimage.contentOffset.x >=0){
        _pagecontrol.currentPage=0;
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
             [_scrollview release];
             [_Scrollproductimage release];
             [_Pricelabel release];
             [_Productnamelabel release];
             [_Productdescription release];
             [_sales release];
             [_praise release];
             [_pagecontrol release];
             [_AddtoUserCart release];
             [_Buyit release];
    [_likebtn release];
    [_infoview release];
    [_web release];
    [_fvview release];
             [super dealloc];
}
- (void)viewDidUnload {
             [self setScrollview:nil];
             [self setScrollproductimage:nil];
             [self setPricelabel:nil];
             [self setProductnamelabel:nil];
             [self setProductdescription:nil];
             [self setSales:nil];
             [self setPraise:nil];
             [self setPagecontrol:nil];
             [self setAddtoUserCart:nil];
             [self setBuyit:nil];
    [self setLikebtn:nil];
    [self setInfoview:nil];
    [self setWeb:nil];
    [self setFvview:nil];
             [super viewDidUnload];
}
- (IBAction)AddtoUserCart:(UIButton *)sender {
    NSUserDefaults *addorbuy=[NSUserDefaults standardUserDefaults];
    [addorbuy setObject:@"add" forKey:@"AddOrBuy"];
    [self pushtopick];
}

- (IBAction)Buyit:(UIButton *)sender {
    NSUserDefaults *addorbuy=[NSUserDefaults standardUserDefaults];
    [addorbuy setObject:@"buy" forKey:@"AddOrBuy"];
    [self pushtopick];
}
- (void)back{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)sendtoWeibo{
    
    if ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=6) {
        
        
        // if([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo])
        //{
        slComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
        [slComposerSheet setInitialText:[[NSUserDefaults standardUserDefaults] objectForKey:@"PassName"]];
        
        
        UIImageView *imageview=[[[UIImageView alloc] init] autorelease];
        [imageview setImageWithURL:[self.imageid objectAtIndex:self.pagecontrol.currentPage] placeholderImage:[UIImage imageNamed:@"nscd_bg"]];
        [slComposerSheet addImage:imageview.image];
        [slComposerSheet addURL:[NSURL URLWithString:@"http://www.sjgo365.com/"]];
        [self presentViewController:slComposerSheet animated:YES completion:nil];
        //}
        
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result) {
                         if (result == SLComposeViewControllerResultCancelled) {
                                 
                             } else
                                 {
                                     XYAlertView *aler=[[XYAlertView alloc] initWithTitle:@"新浪微博" message:@"分享成功！" buttons:[NSArray       arrayWithObjects:@"确定",nil] afterDismiss:^(int buttonIndex){
                                         if (buttonIndex==0) {
                                          [self changelikebtn];
                                     [self.likebtn setImage:[UIImage imageNamed:@"icon_detail_like_down"]];
                                         }
                                     }];
                                     [aler show];
                                     [aler release];
                                    }
                         [slComposerSheet dismissViewControllerAnimated:YES completion:Nil];
                    };
        slComposerSheet.completionHandler = myBlock;
    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://weibo.com"]];
        
    }

    
}

- (void)sendtoFacebook{
    if ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=6) {
        //  if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        //{
        slComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [slComposerSheet setInitialText:[[NSUserDefaults standardUserDefaults] objectForKey:@"PassName"]];
        UIImageView *imageview=[[[UIImageView alloc] init] autorelease];
        [imageview setImageWithURL:[self.imageid objectAtIndex:0] placeholderImage:[UIImage imageNamed:@"nscd_bg"]];
        [slComposerSheet addImage:imageview.image];
        [slComposerSheet addURL:[NSURL URLWithString:@"http://www.facebook.com/"]];
        [self presentViewController:slComposerSheet animated:YES completion:nil];
        // }
        
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result) {
            if (result == SLComposeViewControllerResultCancelled) {
                
            } else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"新浪微博" message:@"分享成功" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
                [alert release];
                [self.likebtn setImage:[UIImage imageNamed:@"icon_detail_like_down"]];
            }
            [slComposerSheet dismissViewControllerAnimated:YES completion:Nil];
        };
        slComposerSheet.completionHandler = myBlock;
    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.facebook.com"]];
    }
}

- (void)sendtotwitter{
    int currentver = [[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue];
    //ios5
    if (currentver==5 ) {
        // Set up the built-in twitter composition view controller.
        TWTweetComposeViewController *tweetViewController = [[[TWTweetComposeViewController alloc] init] autorelease];
        // Set the initial tweet text. See the framework for additional properties that can be set.
        [tweetViewController setInitialText:@"IOS5 twitter"];
        // Create the completion handler block.
        [tweetViewController setCompletionHandler:^(TWTweetComposeViewControllerResult result) {
            // Dismiss the tweet composition view controller.
            [self dismissModalViewControllerAnimated:YES];
        }];
        
        // Present the tweet composition view controller modally.
        [self presentModalViewController:tweetViewController animated:YES];
        //ios6
    }else if (currentver==6) {
        //        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        //        {
        slComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [slComposerSheet setInitialText:[[NSUserDefaults standardUserDefaults] objectForKey:@"PassName"]];
        UIImageView *imageview=[[[UIImageView alloc] init] autorelease];
        [imageview setImageWithURL:[self.imageid objectAtIndex:0] placeholderImage:[UIImage imageNamed:@"nscd_bg"]];
        [slComposerSheet addImage:imageview.image];
        [slComposerSheet addURL:[NSURL URLWithString:@"http://www.twitter.com/"]];
        [self presentViewController:slComposerSheet animated:YES completion:nil];
        //        }
        
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result) {
            if (result == SLComposeViewControllerResultCancelled) {
                
            } else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"新浪微博" message:@"分享成功" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
                [alert release];
                [self.likebtn setImage:[UIImage imageNamed:@"icon_detail_like_down"]];
            }
            [slComposerSheet dismissViewControllerAnimated:YES completion:Nil];
        };
        slComposerSheet.completionHandler = myBlock;
        
        
        
        
    }else{//ios5 以下
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://twitter.com"]];
    }
    
}
-(void)CheckIn{
    CheckInViewController *checkin=[[[CheckInViewController alloc] init] autorelease];
    [self presentViewController:checkin animated:YES completion:nil];
}
-(void)changelikebtn{
    [UIView beginAnimations:@"animationID" context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.likebtn cache:YES];
    [UIView commitAnimations];
    [MCSoundBoard playSoundForKey:@"favorite"];
}

- (IBAction)ShowWebView:(UIButton *)sender {
    self.WebIsShowing=YES;
//    [_web setContentScaleFactor:[_web contentScaleFactor]+100];
    [_web loadHTMLString:self.webdesc baseURL:nil];
    self.navigationItem.title=@"详细描述";
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.8];//动画时间长度，单位秒，浮点数
    _web.frame=CGRectMake(0, 0, 320, 530);
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
}

- (IBAction)ShowFVview:(UIButton *)sender {
    FVImageSequenceDemoViewController *fv=[[FVImageSequenceDemoViewController alloc] initWithNibName:@"FVImageSequenceView" bundle:[NSBundle mainBundle]];
    [self presentViewController:fv animated:YES completion:nil];
}
-(void)HideWebView{
    self.WebIsShowing=NO;
    self.navigationItem.title=@"产品细节";
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.8];//动画时间长度，单位秒，浮点数
    _web.frame=CGRectMake(0, 550, 320, 480);
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
}
-(void)quadCurveMenu:(QuadCurveMenu *)menu didSelectIndex:(NSInteger)idx;{
    
}

@end
