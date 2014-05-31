//
//  APIResponse.h
//  TollCollector
//
//  Created by loufq on 14-4-26.
//  Copyright (c) 2014年 loufq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIResponse : NSObject

@property(assign) int PageCount;
@property(assign) int PageSize;
@property(assign) int RecordCount;
@property(retain)NSArray* Entities;

+(id)create:(NSDictionary*)dict;


@end
