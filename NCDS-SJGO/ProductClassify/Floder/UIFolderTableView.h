//
//  UIFolderTableView.h
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//

#import <UIKit/UIKit.h>
#import "FolderCoverView.h"

@class CAMediaTimingFunction;
@class UIFolderTableView;

typedef void (^FolderCompletionBlock)(void);
typedef void (^FolderCloseBlock)(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction);
typedef void (^FolderOpenBlock)(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction);

@protocol UIFolderTableViewDelegate <NSObject>

@optional
- (CGFloat)tableView:(UIFolderTableView *)tableView xForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface UIFolderTableView : UITableView

@property (strong, nonatomic) UIView *subClassContentView;
@property (assign, nonatomic) IBOutlet id<UIFolderTableViewDelegate> folderDelegate;

- (void)openFolderAtIndexPath:(NSIndexPath *)indexPath
              WithContentView:(UIView *)subClassContentView
                    openBlock:(FolderOpenBlock)openBlock 
                   closeBlock:(FolderCloseBlock)closeBlock
              completionBlock:(FolderCompletionBlock)completionBlock;

@end
