//
//  APIResponse.m
//  TollCollector
//
//  Created by loufq on 14-4-26.
//  Copyright (c) 2014年 loufq. All rights reserved.
//

#import "APIResponse.h"
#import "IBase.h"

@implementation APIResponse

+(id)create:(NSDictionary*)dict{
    APIResponse* res =[APIResponse new];
    return  res;
}

@end
