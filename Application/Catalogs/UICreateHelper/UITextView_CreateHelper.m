//
//  UITextView_CreateHelper.m
//  iMenu
//
//  Created by loufq on 12-4-16.
//  Copyright (c) 2012年 hotel3g.com. All rights reserved.
//

#import "UITextView_CreateHelper.h"

#import "UIView+Size.h"
#import <QuartzCore/QuartzCore.h>
@interface UITextView ()

- (id)styleString;

@end

@implementation MBTextView
- (id)styleString {
    return [[super styleString] stringByAppendingString:@"; line-height: 2.2em"];
}
@end

@implementation UITextView(CreateHelp)
 
+(id)createWithSize:(CGSize)aSize{
    UITextView* tf =[[self alloc] initWithFrame:CGRectMake(0, 0, aSize.width, aSize.height)] ;

   // tf.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    tf.keyboardType = UIKeyboardTypeDefault;
//    tf.layer.borderWidth = 1;
//    tf.layer.cornerRadius = 8;
    [tf setAutocorrectionType:UITextAutocorrectionTypeNo];
    [tf setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    return tf;
}

-(void)addInputAccessoryCustomView:(UIView*)aView{
    self.inputAccessoryView = aView;
}

//键盘辅助类
-(void)addInputAccessoryView{
    UIView* view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 35)] ;
    view.backgroundColor =[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]; 
    UIButton* btn =nil;
    btn.centerY = view.height/2;
    btn.right = view.right - 5;
    [btn addTarget:self action:@selector(hideKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];  
    self.inputAccessoryView = view;
}

-(void)hideKeyboard:(UIButton*)sender{
    [self resignFirstResponder];
}

@end