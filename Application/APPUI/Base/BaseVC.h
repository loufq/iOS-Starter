//
//  BaseVC.h
//  Dispatch
//
//  Created by loufq on 14-3-9.
//  Copyright (c) 2014年 loufq. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface BaseVC : UIViewController

@property (copy) NormalBlock normalBlock;
+(id)create;
+(id)createWithBlock:(NormalBlock)block;
-(BOOL)isLandscape;
-(BOOL)hasVC:(Class)aClass;
@end
