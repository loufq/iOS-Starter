//
//  UIDevice_Helper.m
//  FileShare
//
//  Created by loufq on 12-4-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIDevice_Helper.h"

@implementation UIDevice (Helper)  
+ (BOOL)isJailbroken {  
    BOOL jailbroken = NO;  
    NSString *cydiaPath = @"/Applications/Cydia.app";  
    NSString *aptPath = @"/private/var/lib/apt/";  
    if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath]) {  
        jailbroken = YES;  
    }  
    if ([[NSFileManager defaultManager] fileExistsAtPath:aptPath]) {  
        jailbroken = YES;  
    }  
    return jailbroken;  
}  

+(BOOL)isRetina{
    return ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0))?YES:NO;
}

+(BOOL)isPad{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
}

+ (BOOL) isTallScreen {
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat scale = 1;
    if ([ [UIScreen mainScreen] respondsToSelector: @selector(scale)] == YES) {
        scale = [ [UIScreen mainScreen] scale];
    }
    BOOL res = ( (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) && ( (height * scale) >= 1136) );
    return res;
}

+ (BOOL) isIOS7{
    return [[[UIDevice currentDevice] systemVersion] floatValue] >=7;
}

+(BOOL)isSIMULATOR{
    return TARGET_IPHONE_SIMULATOR;
}


@end  