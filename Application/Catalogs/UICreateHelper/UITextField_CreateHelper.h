//
//  UITextField_CreateHelper.h
//  iMenuPod
//
//  Created by loufq on 11-9-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UITextFieldAssistDelegate<NSObject>

@end

@interface UITextField(CreateHelp)

-(void)addInputAccessoryCustomView:(UIView*)aView;

+(id)createWithSize:(CGSize)aSize;


@end
