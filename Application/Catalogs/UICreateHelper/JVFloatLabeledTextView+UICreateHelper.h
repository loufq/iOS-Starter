//
//  JVFloatLabeledTextView+UICreateHelper.h
//  Inspection
//
//  Created by loufq on 13-11-27.
//  Copyright (c) 2013年 loufq. All rights reserved.
//

#import "JVFloatLabeledTextView.h"

@interface JVFloatLabeledTextView (UICreateHelper)
+(id)createWithSize:(CGSize)aSize;
+(id)createWithSize:(CGSize)aSize placeholder:(NSString*)placeholder;
+(id)createWithSize:(CGSize)aSize placeholder:(NSString*)placeholder fontSize:(float)fontSize;

@end
