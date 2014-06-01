//
//  APIResponse.h
//  TollCollector
//
//  Created by loufq on 14-4-26.
//  Copyright (c) 2014年 loufq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIResponse : NSObject

@property(assign) int code;
@property(retain) NSString* msg;
@property(retain) id data;

+(id)create:(NSDictionary*)dict;


@end
