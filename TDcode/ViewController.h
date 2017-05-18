//
//  ViewController.h
//  QR code
//
//  Created by 徐 on 12-12-10.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface ViewController : UIViewController< ZBarReaderDelegate,UIAlertViewDelegate >
@property (retain, nonatomic) IBOutlet UILabel *label;

@property (retain, nonatomic) IBOutlet UIImageView *imageview;
@property (retain, nonatomic) IBOutlet UITextField *text;

- (IBAction)button:(id)sender;
- (IBAction)button2:(id)sender;
- (IBAction)Responder:(id)sender;


@end
