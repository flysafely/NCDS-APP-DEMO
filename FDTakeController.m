//
//  FDTakeController.m
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//

#import "FDTakeController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "CreateNewUserViewController.h"

#define kPhotosActionSheetTag 1
#define kVideosActionSheetTag 2
#define kVideosOrPhotosActionSheetTag 3

@interface FDTakeController() <UIActionSheetDelegate, UIAlertViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) NSMutableArray *sources;
@property (strong, nonatomic) NSMutableArray *buttonTitles;
@property (strong, nonatomic) UIActionSheet *actionSheet;
@property (strong, nonatomic) UIPopoverController *popover;


// Returns either optional view control for presenting or main window
- (UIViewController*)presentingViewController;

// encapsulation of actionsheet creation
- (void)_setUpActionSheet;
@end

@implementation FDTakeController
@synthesize sources = _sources;
@synthesize buttonTitles = _buttonTitles;
@synthesize actionSheet = _actionSheet;
@synthesize imagePicker = _imagePicker;
@synthesize popover = _popover;
@synthesize viewControllerForPresentingImagePickerController = _viewControllerForPresenting;
@synthesize popOverPresentRect = _popOverPresentRect;
@synthesize createview=_createview;
- (NSMutableArray *)sources
{
    if (!_sources) _sources = [[NSMutableArray alloc] init];
    return _sources;
}

- (NSMutableArray *)buttonTitles
{
    if (!_buttonTitles) _buttonTitles = [[NSMutableArray alloc] init];
    return _buttonTitles;
}

- (CGRect)popOverPresentRect
{
    if (_popOverPresentRect.size.height == 0 || _popOverPresentRect.size.width == 0)
        _popOverPresentRect = CGRectMake(0, 0, 1, 1);
    return _popOverPresentRect;
}

- (UIImagePickerController *)imagePicker
{
    if (!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
        
        _imagePicker.allowsEditing = YES;
    }
    return _imagePicker;
}

- (UIPopoverController *)popover
{
    if (!_popover) _popover = [[UIPopoverController alloc] initWithContentViewController:self.imagePicker];
    return _popover;
}

- (void)takePhotoOrChooseFromLibrary
{
    self.sources = nil;
    self.buttonTitles = nil;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self.sources addObject:[NSNumber numberWithInteger:UIImagePickerControllerSourceTypeCamera]];
        [self.buttonTitles addObject:NSLocalizedStringFromTable(@"照一张", @"FDTake", @"Option to take photo using camera")];
    }
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        [self.sources addObject:[NSNumber numberWithInteger:UIImagePickerControllerSourceTypePhotoLibrary]];
        [self.buttonTitles addObject:NSLocalizedStringFromTable(@"从相册里面选取", @"FDTake", @"Option to select photo/video from library")];
    }
    else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        [self.sources addObject:[NSNumber numberWithInteger:UIImagePickerControllerSourceTypeSavedPhotosAlbum]];
        [self.buttonTitles addObject:NSLocalizedStringFromTable(@"chooseFromPhotoRoll", @"FDTake", @"Option to select photo from photo roll")];
    }
    [self _setUpActionSheet];
    [self.actionSheet setTag:kPhotosActionSheetTag];
}

- (void)takeVideoOrChooseFromLibrary
{
    self.sources = nil;
    self.buttonTitles = nil;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self.sources addObject:[NSNumber numberWithInteger:UIImagePickerControllerSourceTypeCamera]];
        [self.buttonTitles addObject:NSLocalizedStringFromTable(@"takeVideo", @"FDTake", @"Option to take video using camera")];
    }
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        [self.sources addObject:[NSNumber numberWithInteger:UIImagePickerControllerSourceTypePhotoLibrary]];
        [self.buttonTitles addObject:NSLocalizedStringFromTable(@"chooseFromLibrary", @"FDTake", @"Option to select photo/video from library")];
    }
    else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        [self.sources addObject:[NSNumber numberWithInteger:UIImagePickerControllerSourceTypeSavedPhotosAlbum]];
        [self.buttonTitles addObject:NSLocalizedStringFromTable(@"chooseFromPhotoRoll", @"FDTake", @"Option to select photo from photo roll")];
    }
    [self _setUpActionSheet];
    [self.actionSheet setTag:kVideosActionSheetTag];
}

- (void)takePhotoOrVideoOrChooseFromLibrary
{
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    UIViewController *aViewController = [self _topViewController:[[[UIApplication sharedApplication] keyWindow] rootViewController] ];
    if (buttonIndex == self.actionSheet.cancelButtonIndex) {
        if ([self.delegate respondsToSelector:@selector(takeController:didCancelAfterAttempting:)])
            [self.delegate takeController:self didCancelAfterAttempting:NO];
    } else {
        self.imagePicker.sourceType = [[self.sources objectAtIndex:buttonIndex] integerValue];
        
        // set the media type: photo or video
        if (actionSheet.tag == kPhotosActionSheetTag) {
            self.imagePicker.mediaTypes = [[[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil] autorelease];
        } else if (actionSheet.tag == kVideosActionSheetTag) {
            self.imagePicker.mediaTypes = [[[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil] autorelease];
        }
        
        // On iPad use pop-overs.
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [self.popover presentPopoverFromRect:self.popOverPresentRect
                                          inView:aViewController.view
                        permittedArrowDirections:UIPopoverArrowDirectionAny
                                        animated:YES];
        }
        else {
            // On iPhone use full screen presentation.
            [self.createview presentViewController:self.imagePicker animated:YES completion:nil];
        }        
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if ([self.delegate respondsToSelector:@selector(takeController:didCancelAfterAttempting:)])
        [self.delegate takeController:self didCancelAfterAttempting:NO];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage, *imageToSave;
    
    // Handle a still image capture
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0)
        == kCFCompareEqualTo) {
        
        editedImage = (UIImage *) [info objectForKey:
                                   UIImagePickerControllerEditedImage];
        originalImage = (UIImage *) [info objectForKey:
                                     UIImagePickerControllerOriginalImage];
        
        if (editedImage) {
            imageToSave = editedImage;
        } else if (originalImage) {
            imageToSave = originalImage;
        } else {
            if ([self.delegate respondsToSelector:@selector(takeController:didFailAfterAttempting:)])
                [self.delegate takeController:self didFailAfterAttempting:YES];
            return;
        }
        
        if ([self.delegate respondsToSelector:@selector(takeController:gotPhoto:withInfo:)])
            [self.delegate takeController:self gotPhoto:imageToSave withInfo:info];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            [self.popover dismissPopoverAnimated:YES];
    }
    // Handle a movie capture
    else if (CFStringCompare ((CFStringRef) mediaType, kUTTypeMovie, 0)
        == kCFCompareEqualTo) {
        if ([self.delegate respondsToSelector:@selector(takeController:gotVideo:withInfo:)])
            [self.delegate takeController:self gotVideo:[info objectForKey:UIImagePickerControllerMediaURL] withInfo:info];
    }

    if ([self respondsToSelector:@selector(dismissViewControllerAnimated:completion:)])
        [picker dismissViewControllerAnimated:YES completion:nil];
    else
        [picker dismissModalViewControllerAnimated:YES];
    

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
    if ([self.delegate respondsToSelector:@selector(takeController:didCancelAfterAttempting:)])
        [self.delegate takeController:self didCancelAfterAttempting:YES];
}

#pragma mark - Private methods
-(void)getviewcontroller:(UIViewController *)viewcontroller{
    self.createview=viewcontroller;
}

- (UIViewController*)presentingViewController
{
    // Use optional view controller for presenting the image picker if set
    UIViewController *presentingViewController = nil;
    if (self.viewControllerForPresentingImagePickerController!=nil) {
        presentingViewController = self.viewControllerForPresentingImagePickerController;
    }
    else {
        // Otherwise do this stuff (like in original source code)
        
        presentingViewController =self.createview;
    }
    return presentingViewController;
}

- (void)_setUpActionSheet
{
    if ([self.sources count]) {
        self.actionSheet = [[[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:nil
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:nil] autorelease];
        for (NSString *title in self.buttonTitles)
            [self.actionSheet addButtonWithTitle:title];
        [self.actionSheet addButtonWithTitle:NSLocalizedStringFromTable(@"cancel", @"FDTake", @"Decline to proceed with operation")];
        self.actionSheet.cancelButtonIndex = self.sources.count;
        
        // If on iPad use the present rect and pop over style.
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [self.actionSheet showFromRect:self.popOverPresentRect inView:[self presentingViewController].view animated:YES];
        }
        else {
            // Otherwise use iPhone style action sheet presentation.
            [self.actionSheet showInView:[[[UIApplication sharedApplication] keyWindow] rootViewController].view];
        }
    } else {
        NSString *str = NSLocalizedStringFromTable(@"noSources", @"FDTake", @"There are no sources available to select a photo");
        [[[[UIAlertView alloc] initWithTitle:nil
                                    message:str
                                   delegate:self
                          cancelButtonTitle:nil
                          otherButtonTitles:nil] autorelease] show];
    }
}

- (UIViewController *)_topViewController:(UIViewController *)rootViewController
{
    if (rootViewController.presentedViewController == nil)
        return rootViewController;
    
    if ([rootViewController.presentedViewController isMemberOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController.presentedViewController;
        UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
        return [self _topViewController:lastViewController];
    }
    
    UIViewController *presentedViewController = (UIViewController *)rootViewController.presentedViewController;
    return [self _topViewController:presentedViewController];
}


@end
