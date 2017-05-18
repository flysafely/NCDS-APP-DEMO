//
//  PayMentViewController.m
//  NCDS-SJGO
//
//  Created by Mofioso on 13-5-1.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import "PayMentViewController.h"

@interface PayMentViewController ()

@end

@implementation PayMentViewController
@synthesize toolBar=_toolBar;
@synthesize BankImage=_BankImage;
@synthesize CardView=_CardView;
@synthesize PayPrice=_PayPrice;
@synthesize price=_price;

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

    UIImage *toolBarIMG = [UIImage imageNamed: @"navbar-first"];
    if ([self.toolBar respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)]) {
        [self.toolBar setBackgroundImage:toolBarIMG forToolbarPosition:0 barMetrics:0];}
    self.toolBar.layer.shadowPath=[UIBezierPath bezierPathWithRect:self.toolBar.bounds].CGPath;
    self.toolBar.layer.shadowOffset = CGSizeMake(0, 0);
    self.toolBar.layer.shadowColor = [UIColor blackColor].CGColor;
    self.toolBar.layer.shadowOpacity = 0.8;
    self.PayPrice.text=self.price;
    
    [self initImages];
    
    
    [self.collectionView registerClass:[RVCollectionViewCell class] forCellWithReuseIdentifier:@"ItemIdentifier"];
    self.collectionView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.collectionView.delegate = self;
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    self.collectionViewLayout = [[RVCollectionViewLayout alloc] init];
    self.collectionViewLayout.superView = self.view;
    [self.collectionView setCollectionViewLayout:self.collectionViewLayout];
    // Do any additional setup after loading the view from its nib.
}

- (void) initImages {
    self.imagesArray = [NSMutableArray array];
    
    
    UIImageView * image1 = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bl_ABC_card@2x"]] autorelease];
    image1.backgroundColor=[UIColor clearColor];
    UIImageView * image2 = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bl_BOC_card@2x"]] autorelease];
    image2.backgroundColor=[UIColor clearColor];

    UIImageView * image3 = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bl_CCB_card@2x"]] autorelease];
    image3.backgroundColor=[UIColor clearColor];

    UIImageView * image4 = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bl_CITIC_card@2x"]] autorelease];
    image4.backgroundColor=[UIColor clearColor];

    UIImageView * image5 = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bl_CMB_card@2x"]] autorelease];
    image5.backgroundColor=[UIColor clearColor];

    UIImageView * image6 = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bl_CMBC_card@2x"]] autorelease];
    image6.backgroundColor=[UIColor clearColor];

    UIImageView * image7 = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bl_SPDB_card@2x"]] autorelease];
    image7.backgroundColor=[UIColor clearColor];

    UIImageView * image8 = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bl_ICBC_card@2x"]] autorelease];
    image8.backgroundColor=[UIColor clearColor];

    
    
    [self.imagesArray addObject:image1];
    [self.imagesArray addObject:image2];
    [self.imagesArray addObject:image3];
    [self.imagesArray addObject:image4];
    [self.imagesArray addObject:image5];
    [self.imagesArray addObject:image6];
    [self.imagesArray addObject:image7];
    [self.imagesArray addObject:image8];
    

}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.imagesArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RVCollectionViewCell *cell = (RVCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ItemIdentifier" forIndexPath:indexPath];
    cell.imageView = self.imagesArray[indexPath.item];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // implement your cell selected logic here
    switch (indexPath.item) {
        case 0:
            self.BankImage.image=[UIImage imageNamed:@"bl_ABC"];
            break;
        case 1:
            self.BankImage.image=[UIImage imageNamed:@"bl_BOC"];
            break;
        case 2:
            self.BankImage.image=[UIImage imageNamed:@"bl_CCB"];
            break;
        case 3:
            self.BankImage.image=[UIImage imageNamed:@"bl_CITIC"];
            break;
        case 4:
            self.BankImage.image=[UIImage imageNamed:@"bl_CMB"];
            break;
        case 5:
            self.BankImage.image=[UIImage imageNamed:@"bl_CMBC"];
            break;
        case 6:
            self.BankImage.image=[UIImage imageNamed:@"bl_SPDB"];
            break;
        case 7:
            self.BankImage.image=[UIImage imageNamed:@"bl_ICBC"];
            break;
        default:
            break;
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.CardAccount resignFirstResponder];
    [self.CardPassword resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_collectionView release];
    [_toolBar release];
    [_BankImage release];
    [_CardView release];
    [_CardAccount release];
    [_CardPassword release];
    [_CardView release];
    [_PayPrice release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setCollectionView:nil];
    [self setToolBar:nil];
    [self setBankImage:nil];
    [self setCardView:nil];
    [self setCardAccount:nil];
    [self setCardPassword:nil];
    [self setCardView:nil];
    [self setPayPrice:nil];
    [super viewDidUnload];
}
- (IBAction)Back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showcards:(UIButton *)sender {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];//动画时间长度，单位秒，浮点数
    self.collectionView.frame=CGRectMake(-20, 328, 360, 310);
    self.CardView.frame=CGRectMake(11, 131,300, 182);
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];

}

- (IBAction)hidecards:(UIButton *)sender {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];//动画时间长度，单位秒，浮点数
    self.collectionView.frame=CGRectMake(-20, 570, 360, 310);
    self.CardView.frame=CGRectMake(320, 131,300, 182);
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
}

- (IBAction)Confirm:(UIButton *)sender {
}


@end
