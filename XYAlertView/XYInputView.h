//
//  XYInputView.h
//
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import "XYAlertViewManager.h"

typedef void (^XYInputViewBlock)(int buttonIndex, NSString *text);

@interface XYInputView : NSObject

@property (copy, nonatomic) NSString *initialText;
@property (copy, nonatomic) NSString *placeholder;
@property (retain, nonatomic) NSArray *buttons;
@property (readonly, nonatomic) NSMutableArray *buttonsStyle;
@property (copy, nonatomic) XYInputViewBlock blockAfterDismiss;

+(id)inputViewWithPlaceholder:(NSString*)placeholder
            initialText:(NSString*)initialText
            buttons:(NSArray*)buttonTitles
       afterDismiss:(XYInputViewBlock)block;

-(id)initWithPlaceholder:(NSString*)placeholder
       initialText:(NSString*)initialText
           buttons:(NSArray*)buttonTitles
      afterDismiss:(XYInputViewBlock)block;

-(void)setButtonStyle:(XYButtonStyle)style atIndex:(int)index;

-(void)show;
-(void)dismiss:(int)buttonIndex;

@end
