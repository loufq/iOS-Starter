//
//  ImageSourceHelper.h
//  ChinaCycling
//
//  Created by loufq on 13-10-12.
//  Copyright (c) 2013年 loufq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageSourceHelper : NSObject<
UINavigationControllerDelegate,
UIImagePickerControllerDelegate,
UIPopoverControllerDelegate>

@property(assign)UIViewController* targetVC;

//http://fuckingblocksyntax.com/

@property (nonatomic, copy) void (^finishblock)(UIImage *image);
@property (nonatomic, copy) void (^cancelblock)(void);

+(id)showViewController:(UIViewController*)controller
                   type:(UIImagePickerControllerSourceType)type
                 finish:(void (^)(UIImage* image))finish
                 cancel:(void (^)(void))cancel;


+(id)showViewController:(UIViewController*)controller
                 target:(UIControl*)targetView
                   type:(UIImagePickerControllerSourceType)type
                 finish:(void (^)(UIImage* image))finish
                 cancel:(void (^)(void))cancel;

@end
