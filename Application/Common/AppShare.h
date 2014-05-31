//
//  AppShare.h
//  TollCollector
//
//  Created by loufq on 14-3-25.
//  Copyright (c) 2014年 loufq. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kLeftMenuShowWidth 60
@interface AppShare : NSObject

@property(retain)NSString* curFolder;

@property(retain)NSArray* curFiles;

+(AppShare*)sharedManager;





@end
