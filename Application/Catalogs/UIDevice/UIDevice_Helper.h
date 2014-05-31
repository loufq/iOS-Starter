//
//  UIDevice_Helper.h
//  FileShare
//
//  Created by loufq on 12-4-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIDevice (Helper)  
+ (BOOL)isJailbroken;
+ (BOOL)isRetina;
+ (BOOL)isPad;
+ (BOOL) isTallScreen;

+ (BOOL) isIOS7;

+(BOOL)isSIMULATOR;



@end  