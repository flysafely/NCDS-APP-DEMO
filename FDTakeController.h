//
//  FDTakeController.h
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//

#import <Foundation/Foundation.h>

@class FDTakeController;

@protocol FDTakeDelegate <NSObject>

@optional
- (void)takeController:(FDTakeController *)controller didCancelAfterAttempting:(BOOL)madeAttempt;
- (void)takeController:(FDTakeController *)controller didFailAfterAttempting:(BOOL)madeAttempt;
- (void)takeController:(FDTakeController *)controller gotPhoto:(UIImage *)photo withInfo:(NSDictionary *)info;
- (void)takeController:(FDTakeController *)controller gotVideo:(NSURL *)video withInfo:(NSDictionary *)info;
@end

@interface FDTakeController : NSObject <UIImagePickerControllerDelegate>

- (void)takePhotoOrChooseFromLibrary;
- (void)takeVideoOrChooseFromLibrary;
- (void)takePhotoOrVideoOrChooseFromLibrary;
-(void)getviewcontroller:(UIViewController *)viewcontroller;

@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (nonatomic, unsafe_unretained) id <FDTakeDelegate> delegate;
@property (nonatomic, unsafe_unretained) UIViewController *viewControllerForPresentingImagePickerController;
@property (nonatomic, readwrite) CGRect popOverPresentRect; // used in presentPopoverFromRect on iPads
@property (strong, nonatomic) UIViewController *createview;
@end
