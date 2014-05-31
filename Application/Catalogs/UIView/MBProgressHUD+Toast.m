//
//  MBProgressHUD+Toast.m
//  tour
//
//  Created by yangxh on 13-4-11.
//  Copyright (c) 2013年 loufq. All rights reserved.
//

#import "MBProgressHUD+Toast.h"

@implementation MBProgressHUD (Toast)

+ (MBProgressHUD *)showToastWithText:(NSString *)text {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow; 
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    hud.labelText = text;
    hud.mode = MBProgressHUDModeText;
    [hud hide:YES afterDelay:1.1f];
    return hud;
}

@end
