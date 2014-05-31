//
//  JVFloatLabeledTextView+UICreateHelper.m
//  Inspection
//
//  Created by loufq on 13-11-27.
//  Copyright (c) 2013年 loufq. All rights reserved.
//

#import "JVFloatLabeledTextView+UICreateHelper.h"

@implementation JVFloatLabeledTextView (UICreateHelper)
+(id)createWithSize:(CGSize)aSize{
    return [self createWithSize:aSize placeholder:nil fontSize:16.0f];
}

+(id)createWithSize:(CGSize)aSize placeholder:(NSString*)placeholder{
    return [self createWithSize:aSize placeholder:placeholder fontSize:16.0f];
}

+(id)createWithSize:(CGSize)aSize placeholder:(NSString*)placeholder fontSize:(float)fontSize{
    
    JVFloatLabeledTextView *titleField = [[JVFloatLabeledTextView alloc] initWithFrame:
                                           CGRectMake(0, 0, aSize.width  , aSize.height)];
    titleField.placeholder = placeholder;
    titleField.font = [UIFont systemFontOfSize:fontSize];
    titleField.floatingLabel.font = [UIFont boldSystemFontOfSize:fontSize-4];
    titleField.floatingLabelTextColor = [UIColor grayColor];
    return titleField;
}
@end
