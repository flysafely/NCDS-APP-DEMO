//
//  ViewController.m
//  SideBarNavDemo
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//


#import "SidebarViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "LeftSideBarViewController.h"
#import "RightSideBarViewController.h"
#import "SecondViewController.h"
//#import "ChatViewController.h"
@interface SidebarViewController ()
{
    UIViewController  *_currentMainController;
    UITapGestureRecognizer *_tapGestureRecognizer;
    UIPanGestureRecognizer *_panGestureReconginzer;
    BOOL sideBarShowing;
    CGFloat currentTranslate;
    
}
@property (strong,nonatomic)LeftSideBarViewController *leftSideBarViewController;
//@property (strong,nonatomic)ChatViewController *rightSideBarViewController;
@property (strong,nonatomic)RightSideBarViewController *rightSideBarViewController;


@end

@implementation SidebarViewController
@synthesize leftSideBarViewController,rightSideBarViewController,contentView,navBackView;

static SidebarViewController *rootViewCon;
const int ContentOffset=264;
const int ContentMinOffset=60;
const float MoveAnimationDuration = 0.3;
#pragma mark touch
- (void)moveViewWithX:(float)x
{
    
    x = x>320?320:x;
    x = x<0?0:x;
    
//    CGRect frame = self.view.frame;
//    frame.origin.x = x;
//    self.view.frame = frame;
    
    float scale = (x/6400)+0.95;
    
   self.navBackView.transform = CGAffineTransformMakeScale(scale, scale);
   
    
}



#pragma mark move
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

+ (id)share
{
    return rootViewCon;
}
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
    NSLog(@"当前文件为SidebarViewController************");
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blackColor];
    [(UIButton *)[self.tabBarController.tabBar viewWithTag:100] setHidden:YES];
    self.navBackView.backgroundColor=[UIColor clearColor];
    self.contentView.backgroundColor=[UIColor blackColor];
    if (rootViewCon) {
        rootViewCon = nil;
    }
	rootViewCon = self;
    
    sideBarShowing = NO;
    currentTranslate = 0;
    self.contentView.layer.shadowPath=[UIBezierPath bezierPathWithRect:self.contentView.bounds].CGPath;
    self.contentView.layer.shadowOffset = CGSizeMake(0, 0);
    self.contentView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.contentView.layer.shadowOpacity = 1;
    self.contentView.layer.cornerRadius=5.0;
    self.contentView.layer.masksToBounds=NO;
    
    LeftSideBarViewController *_leftCon = [[[LeftSideBarViewController alloc] initWithNibName:@"LeftSideBarViewController" bundle:nil] autorelease];
    _leftCon.delegate = self;
    
    self.leftSideBarViewController = _leftCon;
  
//    ChatViewController *chat=[[ChatViewController alloc] initWithNibName:@"ChatViewController" bundle:nil];
    RightSideBarViewController *_rightCon = [[[RightSideBarViewController alloc] initWithNibName:@"RightSideBarViewController" bundle:nil] autorelease];
    self.rightSideBarViewController = _rightCon;
  
    [self addChildViewController:self.leftSideBarViewController];
    [self addChildViewController:self.rightSideBarViewController];
    self.leftSideBarViewController.view.frame = self.navBackView.bounds;
    self.rightSideBarViewController.view.frame = self.navBackView.bounds;
    [self.navBackView addSubview:self.leftSideBarViewController.view];
    [self.navBackView addSubview:self.rightSideBarViewController.view];
    
    _panGestureReconginzer = [[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panInContentView:)] autorelease];
    
    [self.contentView addGestureRecognizer:_panGestureReconginzer];
}

- (void)contentViewAddTapGestures
{
    if (_tapGestureRecognizer) {
        [self.contentView   removeGestureRecognizer:_tapGestureRecognizer];
        _tapGestureRecognizer = nil;
    }
    
    _tapGestureRecognizer = [[[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(tapOnContentView:)] autorelease];
    [self.contentView addGestureRecognizer:_tapGestureRecognizer];
}

- (void)tapOnContentView:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [self moveAnimationWithDirection:SideBarShowDirectionNone duration:MoveAnimationDuration];
//    _panGestureReconginzer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panInContentView:)];
//    [self.contentView addGestureRecognizer:_panGestureReconginzer];
}

- (void)panInContentView:(UIPanGestureRecognizer *)panGestureReconginzer
{

	if (panGestureReconginzer.state == UIGestureRecognizerStateChanged)
    {
        CGFloat translation = [panGestureReconginzer translationInView:self.contentView].x;
        self.contentView.transform = CGAffineTransformMakeTranslation(translation+currentTranslate, 0);
//        NSLog(@"第一个VIew 位移了:%f",translation);
        
        float right=fabs(self.contentView.transform.tx)>264?264:self.contentView.transform.tx;
        right=fabs(self.contentView.transform.tx)<10?0:self.contentView.transform.tx;
          float scale = (-right/5280)+0.95;
        float scale2=right/5280+0.95;
        
        UIView *view ;
        if (translation+currentTranslate>0)
        {
            view = self.leftSideBarViewController.view;
//            [self moveViewWithX:scale2];
            
            
            self.navBackView.transform=CGAffineTransformMakeScale(scale2, scale2);
        }else
        {
           
            view = self.rightSideBarViewController.view;
//            [self moveViewWithX:scale];
            self.navBackView.transform=CGAffineTransformMakeScale(scale, scale);
           
        }
        [self.navBackView bringSubviewToFront:view];
        
	} else if (panGestureReconginzer.state == UIGestureRecognizerStateEnded)
    {
		currentTranslate = self.contentView.transform.tx;
        if (!sideBarShowing) {
            if (fabs(currentTranslate)<ContentMinOffset) {
                [self moveAnimationWithDirection:SideBarShowDirectionNone duration:MoveAnimationDuration];
               
            }else if(currentTranslate>ContentMinOffset)
            {
                [self moveAnimationWithDirection:SideBarShowDirectionLeft duration:MoveAnimationDuration];
//                self.navBackView.transform=CGAffineTransformMakeScale(1, 1);

//                [self.contentView removeGestureRecognizer:_panGestureReconginzer];
            }else
            {
                [self moveAnimationWithDirection:SideBarShowDirectionRight duration:MoveAnimationDuration];
                self.navBackView.transform=CGAffineTransformMakeScale(1, 1);

//                [self.contentView removeGestureRecognizer:_panGestureReconginzer];
            }
        }else
         {
            if (fabs(currentTranslate)<ContentOffset-ContentMinOffset) {
                [self moveAnimationWithDirection:SideBarShowDirectionNone duration:MoveAnimationDuration];
//                self.navBackView.transform=CGAffineTransformMakeScale(0.961, 0.961);

            
            }else if(currentTranslate>ContentOffset-ContentMinOffset)
            {
                
                [self moveAnimationWithDirection:SideBarShowDirectionLeft duration:MoveAnimationDuration];
//self.navBackView.transform=CGAffineTransformMakeScale(0.961, 0.961);         
            }else
            {
                [self moveAnimationWithDirection:SideBarShowDirectionRight duration:MoveAnimationDuration];
//self.navBackView.transform=CGAffineTransformMakeScale(0.961, 0.961);
            }
         }
        
        
	}
    
   
}

#pragma mark - nav con delegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([navigationController.viewControllers count]>1) {
        [self removepanGestureReconginzerWhileNavConPushed:YES];
    }else
    {
        [self removepanGestureReconginzerWhileNavConPushed:NO];
    }

}

- (void)removepanGestureReconginzerWhileNavConPushed:(BOOL)push
{
    if (push) {
        if (_panGestureReconginzer) {
            [self.contentView removeGestureRecognizer:_panGestureReconginzer];
            _panGestureReconginzer = nil;
        }
    }else
    {
        if (!_panGestureReconginzer) {
            _panGestureReconginzer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panInContentView:)];
            [self.contentView addGestureRecognizer:_panGestureReconginzer];
        }
    }
}
#pragma mark - side bar select delegate
- (void)leftSideBarSelectWithController:(UIViewController *)controller
{
    if ([controller isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)controller setDelegate:self];
    }
    if (_currentMainController == nil) {
		controller.view.frame = self.contentView.bounds;
		_currentMainController = controller;
		[self addChildViewController:_currentMainController];
		[self.contentView addSubview:_currentMainController.view];
		[_currentMainController didMoveToParentViewController:self];
	} else if (_currentMainController != controller && controller !=nil) {
		controller.view.frame = self.contentView.bounds;
		[_currentMainController willMoveToParentViewController:nil];
		[self addChildViewController:controller];
		self.view.userInteractionEnabled = NO;
		[self transitionFromViewController:_currentMainController
						  toViewController:controller
								  duration:0
								   options:UIViewAnimationOptionTransitionNone
								animations:^{}
								completion:^(BOOL finished){
									self.view.userInteractionEnabled = YES;
									[_currentMainController removeFromParentViewController];
									[controller didMoveToParentViewController:self];
									_currentMainController = controller;
								}
         ];
	}
    
    [self showSideBarControllerWithDirection:SideBarShowDirectionNone];
//    SecondViewController *sec=[[[SecondViewController alloc] init] autorelease];
//    [self.navigationController pushViewController:sec animated:YES];
 }


- (void)rightSideBarSelectWithController:(UIViewController *)controller
{
    
}

- (void)showSideBarControllerWithDirection:(SideBarShowDirection)direction
{
    
    if (direction!=SideBarShowDirectionNone) {
        UIView *view ;
        if (direction == SideBarShowDirectionLeft)
        {
            view = self.leftSideBarViewController.view;
        }else
        {
            view = self.rightSideBarViewController.view;
        }
        [self.navBackView bringSubviewToFront:view];
    }
    [self moveAnimationWithDirection:direction duration:MoveAnimationDuration];
}



#pragma animation

- (void)moveAnimationWithDirection:(SideBarShowDirection)direction duration:(float)duration
{
    void (^animations)(void) = ^{
		switch (direction) {
            case SideBarShowDirectionNone:
            {
                self.contentView.transform  = CGAffineTransformMakeTranslation(0, 0);
                self.navBackView.transform=CGAffineTransformMakeScale(0.95, 0.95);

            }
                break;
            case SideBarShowDirectionLeft:
            {
                self.contentView.transform  = CGAffineTransformMakeTranslation(ContentOffset, 0);
                self.navBackView.transform=CGAffineTransformMakeScale(1, 1);

            }
                break;
            case SideBarShowDirectionRight:
            {
                self.contentView.transform  = CGAffineTransformMakeTranslation(-ContentOffset, 0);
                self.navBackView.transform=CGAffineTransformMakeScale(1, 1);

            }
                break;
            default:
                break;
        }
	};
    void (^complete)(BOOL) = ^(BOOL finished) {
        self.contentView.userInteractionEnabled = YES;
        self.navBackView.userInteractionEnabled = YES;
        
        if (direction == SideBarShowDirectionNone) {
           
            if (_tapGestureRecognizer) {
                [self.contentView removeGestureRecognizer:_tapGestureRecognizer];
                _tapGestureRecognizer = nil;
            }
            sideBarShowing = NO;
            
            
        }else
        {
            [self contentViewAddTapGestures];
            
             sideBarShowing = YES;
        }
        currentTranslate = self.contentView.transform.tx;
	};
    self.contentView.userInteractionEnabled = NO;
    self.navBackView.userInteractionEnabled = NO;
    [UIView animateWithDuration:duration animations:animations completion:complete];
}

@end
