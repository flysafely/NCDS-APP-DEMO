//
//  XYAlertView.m
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//

#import "XYAlertView.h"

@implementation XYAlertView

@synthesize title = _title;
@synthesize message = _message;
@synthesize buttons = _buttons;
@synthesize buttonsStyle = _buttonsStyle;
@synthesize blockAfterDismiss = _blockAfterDismiss;

+(id)alertViewWithTitle:(NSString*)title
            message:(NSString*)message
            buttons:(NSArray*)buttonTitles
       afterDismiss:(XYAlertViewBlock)block
{
    return [[[XYAlertView alloc] initWithTitle:title message:message buttons:buttonTitles afterDismiss:block] autorelease];
}

-(id)initWithTitle:(NSString*)title
           message:(NSString*)message
           buttons:(NSArray*)buttonTitles
      afterDismiss:(XYAlertViewBlock)block
{
    self = [self init];
    if(self)
    {
        self.title = title;
        self.message = message;
        self.buttons = buttonTitles;
        self.blockAfterDismiss = block;
        
    }
    
    return self;
    
}

-(void)setButtonStyle:(XYButtonStyle)style atIndex:(int)index
{
    if(index < [_buttonsStyle count])
        [_buttonsStyle replaceObjectAtIndex:index withObject:[NSNumber numberWithInt:style]];
}

-(void)setButtons:(NSArray *)buttons
{
    _buttons = buttons;
    _buttonsStyle = nil;
    _buttonsStyle = [NSMutableArray arrayWithCapacity:buttons.count];
    for (int i = 0; i < buttons.count; i++)
        [_buttonsStyle addObject:[NSNumber numberWithInt:XYButtonStyleDefault]];
}

-(void)show
{
    [[XYAlertViewManager sharedAlertViewManager] show:self];
}

-(void)dismiss:(int)buttonIndex
{
    [[XYAlertViewManager sharedAlertViewManager] dismiss:self button:buttonIndex];
}

@end
