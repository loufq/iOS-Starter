//
//  NSError+Helper.h
//  AirMenu
//
//  Created by yangxh yang on 11-8-18.
//  Copyright 2011年 codans. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kError_NoResult (-1)

@interface NSError (NSError_Helper)

+ (NSError *)errorWithMsg:(NSString *)msg;
+ (NSError *)errorWithNoResult;

+ (NSError *)errorWithMsg:(NSString *)msg code:(int)aCode;

@end
