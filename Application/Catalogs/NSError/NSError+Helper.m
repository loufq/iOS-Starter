//
//  NSError+Helper.m
//  AirMenu
//
//  Created by yangxh yang on 11-8-18.
//  Copyright 2011年 codans. All rights reserved.
//

#import "NSError+Helper.h"
//#import "AllHeader.h"
@implementation NSError (NSError_Helper)

+ (NSError *)errorWithMsg:(NSString *)msg
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg?:@"发生错误!", NSLocalizedDescriptionKey, nil];
    return [NSError errorWithDomain:@"ERROR DOMAIN" code:-1000 userInfo:userInfo];
}
+ (NSError *)errorWithNoResult{
    return [self errorWithMsg:@"没有了" code:-1];
}

+ (NSError *)errorWithMsg:(NSString *)msg code:(int)aCode;
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg?:@"发生错误!", NSLocalizedDescriptionKey, nil];
    return [NSError errorWithDomain:@"ERROR DOMAIN" code:aCode userInfo:userInfo];
}

@end
