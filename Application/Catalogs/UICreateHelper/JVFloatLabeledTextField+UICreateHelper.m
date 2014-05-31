//
//  JVFloatLabeledTextField+UICreateHelper.m
//  Inspection
//
//  Created by loufq on 13-11-22.
//  Copyright (c) 2013年 loufq. All rights reserved.
//

#import "JVFloatLabeledTextField+UICreateHelper.h"

@implementation JVFloatLabeledTextField (UICreateHelper)


+(id)createWithSize:(CGSize)aSize{
    return [self createWithSize:aSize placeholder:nil fontSize:16.0f];
}

+(id)createWithSize:(CGSize)aSize placeholder:(NSString*)placeholder{
    return [self createWithSize:aSize placeholder:placeholder fontSize:16.0f];
}

+(id)createWithSize:(CGSize)aSize placeholder:(NSString*)placeholder fontSize:(float)fontSize{

    JVFloatLabeledTextField *titleField = [[JVFloatLabeledTextField alloc] initWithFrame:
                                           CGRectMake(0, 0, aSize.width  , aSize.height)];
    titleField.placeholder = placeholder;
    titleField.font = [UIFont systemFontOfSize:fontSize];
    titleField.floatingLabel.font = [UIFont boldSystemFontOfSize:fontSize-4];
    titleField.floatingLabelTextColor = [UIColor grayColor];
    titleField.clearButtonMode = UITextFieldViewModeWhileEditing;
    return titleField;
}


@end
