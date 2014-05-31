//
//  UIButton_CreateHelper.h
//  iPodMenuPlus
//
//  Created by loufq on 11-8-24.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "UIButton+Additions.h"

@interface UIButton(CreateHelp)
+(id)create;
+(id)createWithTitle:(NSString*)aTitle;
+(id)createWithImage:(UIImage*)aImage;
+(id)createWithTitle:(NSString*)aTitle image:(UIImage*)image;
+(id)createWithOnImage:(UIImage*)onImage offImage:(UIImage*)offImage;
+(id)createWithTitle:(NSString *)aTitle onImage:(UIImage*)onImage offImage:(UIImage*)offImage;

-(NSString*)title;


-(void)addTarget:(id)target action:(SEL)action;


@end