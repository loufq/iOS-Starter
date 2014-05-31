//
//  ImageSourceHelper.m
//  ChinaCycling
//
//  Created by loufq on 13-10-12.
//  Copyright (c) 2013年 loufq. All rights reserved.
//

#import "ImageSourceHelper.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
@interface ImageSourceHelper(){
    UIPopoverController *popover;
    
}

@property(assign) UIView* targetView;

@end

@implementation ImageSourceHelper

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//#define IS_IPHONE (YES)(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define IS_IPHONE (YES)

+(id)showViewController:(UIViewController*)controller
                   type:(UIImagePickerControllerSourceType)type
                 finish:(void (^)(UIImage* image))finish
                 cancel:(void (^)(void))cancel{
    ImageSourceHelper* helper = [[self alloc] init];
    helper.targetVC = controller;
    helper.finishblock = finish;
    helper.cancelblock = cancel;
    [helper snapImageWithType:type];
    return helper;
}

+(id)showViewController:(UIViewController*)controller
                 target:(UIControl*)targetView
                   type:(UIImagePickerControllerSourceType)type
                 finish:(void (^)(UIImage* image))finish
                 cancel:(void (^)(void))cancel{
    ImageSourceHelper* helper = [[self alloc] init];
    helper.targetVC = controller;
    helper.finishblock = finish;
    helper.cancelblock = cancel;
    helper.targetView = targetView;
    [helper snapImageWithType:type];
    return helper;
}

- (void) snapImageWithType:(UIImagePickerControllerSourceType)type
{
    if (popover) return;
    
    // Create and initialize the picker
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    if (type==UIImagePickerControllerSourceTypeCamera) {
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            type = UIImagePickerControllerSourceTypePhotoLibrary;
        }
    }
    picker.sourceType =  type;
    BOOL allowEdit = [NSUserDefaults floatForKey:@"setting_image_allowEdit"];
    picker.allowsEditing = allowEdit;
    picker.delegate = self;
    [self presentViewController:picker];
}

#pragma mark - Utility
- (void) performDismiss
{
    if (IS_IPHONE)
        [self.targetVC dismissViewControllerAnimated:YES completion:nil];
    else
        [popover dismissPopoverAnimated:YES];
}

- (void) presentViewController:(UIViewController *)viewControllerToPresent
{
    
    if (IS_IPHONE)
	{
        [self.targetVC presentViewController:viewControllerToPresent animated:YES completion:nil];
	}
	else
	{
        popover = [[UIPopoverController alloc] initWithContentViewController:viewControllerToPresent];
        popover.delegate = self;
        if (self.targetView&&[self.targetView isKindOfClass:[UIBarButtonItem class]]) {
            [popover presentPopoverFromBarButtonItem:(UIBarButtonItem*)self.targetView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
        else{
            [popover presentPopoverFromBarButtonItem:self.targetVC.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
	}
}

// Popover was dismissed
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)aPopoverController
{
    popover = nil;
}

- (void) loadImageFromAssetURL: (NSURL *) assetURL into: (UIImage **) image
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    ALAssetsLibraryAssetForURLResultBlock resultsBlock = ^(ALAsset *asset)
    {
        ALAssetRepresentation *assetRepresentation = [asset defaultRepresentation];
        CGImageRef cgImage = [assetRepresentation CGImageWithOptions:nil];
        CFRetain(cgImage); // Thanks Oliver Drobnik
        if (image) *image = [UIImage imageWithCGImage:cgImage];
        CFRelease(cgImage);
    };
    
    ALAssetsLibraryAccessFailureBlock failure = ^(NSError *__strong error)
    {
        NSLog(@"Error retrieving asset from url: %@", error.localizedFailureReason);
    };
    
    [library assetForURL:assetURL resultBlock:resultsBlock failureBlock:failure];
}

// Finished saving
- (void)image:(UIImage *)image didFinishSavingWithError: (NSError *)error contextInfo:(void *)contextInfo;
{
    // Handle the end of the image write process
    if (!error)
        NSLog(@"Image written to photo album");
    else
        NSLog(@"Error writing to photo album: %@", error.localizedFailureReason);
}

// Update image and for iPhone, dismiss the controller
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Use the edited image if available
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    // If not, grab the original image
    if (!image) image = info[UIImagePickerControllerOriginalImage];
    
    NSURL *assetURL = info[UIImagePickerControllerReferenceURL];
    if (!image && !assetURL)
    {
        NSLog(@"Cannot retrieve an image from the selected item. Giving up.");
    }
    else if (!image)
    {
        NSLog(@"Retrieving from Assets Library");
        [self loadImageFromAssetURL:assetURL into:&image];
    }
    
    if (image)
    {
        BOOL isCam =picker.sourceType==UIImagePickerControllerSourceTypeCamera;
        if (isCam&&[NSUserDefaults boolForKey:@"setting_image_saveToAlbum"]) {
            
            //addAssetsGroupAlbumWithName:resultBlock:failureBlock
            ALAssetsLibrary* library = [[ALAssetsLibrary alloc] init];
            [library addAssetsGroupAlbumWithName:@"Inspection" resultBlock:^(ALAssetsGroup *group) {
                DebugLog(@"%@",@"addAssetsGroupAlbumWithName");
            } failureBlock:^(NSError *error) {
                DebugLog(@"%@",error);
            }];
            
            [library saveImage:image toAlbum:@"Inspection" completion:^(NSURL *assetURL, NSError *error) {
                if (error) {
                    NSLog(@"Save image fail：%@",error);
                }else{
                    NSLog(@"Save image succeed.");
                }
                if (self.finishblock) {
                    self.finishblock([self resizeImageToNewSize:image]);
                    [self performDismiss];
                }
            } failure:^(NSError *error) {
                
            }];
        }else{
            if (self.finishblock) {
                self.finishblock([self resizeImageToNewSize:image]);
                [self performDismiss];
            }
        }
    }
    
}
-(UIImage*)resizeImageToNewSize:(UIImage*)image{
    UIImage* newImage = nil;
    CGSize oriSize =image.size;
    CGSize newSize =CGSizeZero;
    if (oriSize.width>1000||oriSize.height>1000) {
        if (image.size.width>image.size.height) {
            int w = 1000;
            int h = oriSize.height * w / oriSize.width;
            newSize = CGSizeMake(w, h);
        }else{
            int h = 1000;
            int w = oriSize.width * h / oriSize.height;
            newSize = CGSizeMake(w, h);
        }
        newImage =  [image resizedImage:newSize interpolationQuality:kCGInterpolationHigh];
        return newImage;
    }else{
        return image;
    }
}



// Dismiss picker
- (void) imagePickerControllerDidCancel: (UIImagePickerController *)picker
{
    [self performDismiss];
    if (self.cancelblock) {
        self.cancelblock();
    }
}


@end
