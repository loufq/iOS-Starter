//
//  UIBarButtonItemExt.h
//  ShopReport
//
//  Created by loufq on 14-6-1.
//  Copyright (c) 2014年 loufq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItemExt : UIBarButtonItem

@property (copy) NormalBlock normalBlock;

+(id)createWithSysStyle:(UIBarButtonSystemItem)style tapped:(NormalBlock)block;

+(id)createWithTitle:(NSString*)title tapped:(NormalBlock)block;


@end
