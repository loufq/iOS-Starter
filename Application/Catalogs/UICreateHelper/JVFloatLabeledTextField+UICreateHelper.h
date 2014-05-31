//
//  JVFloatLabeledTextField+UICreateHelper.h
//  Inspection
//
//  Created by loufq on 13-11-22.
//  Copyright (c) 2013年 loufq. All rights reserved.
//

#import "JVFloatLabeledTextField.h"

@interface JVFloatLabeledTextField (UICreateHelper)

+(id)createWithSize:(CGSize)aSize;
+(id)createWithSize:(CGSize)aSize placeholder:(NSString*)placeholder;
+(id)createWithSize:(CGSize)aSize placeholder:(NSString*)placeholder fontSize:(float)fontSize;

@end
