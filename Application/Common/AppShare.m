//
//  AppShare.m
//  TollCollector
//
//  Created by loufq on 14-3-25.
//  Copyright (c) 2014年 loufq. All rights reserved.
//

#import "AppShare.h"

@implementation AppShare
static id obj;

+(id)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj =[[AppShare alloc] init];
    });
    return obj;
}


@end
