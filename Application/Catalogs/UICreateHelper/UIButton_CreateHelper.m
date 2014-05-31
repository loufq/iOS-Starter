//
//  UIButton_CreateHelper.m
//  iPodMenuPlus
//
//  Created by loufq on 11-8-24.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "UIButton_CreateHelper.h"
//#import "UIButton+Additions.h"
#import "UIView+Size.h"

@implementation UIButton(CreateHelp)

+(id)create{
    return [self buttonWithType:UIButtonTypeCustom];
}
+(id)createWithTitle:(NSString*)aTitle{
    return [self createWithTitle:aTitle onImage:nil offImage:nil];
}

+(id)createWithImage:(UIImage*)aImage{
    return [self createWithTitle:nil onImage:nil offImage:aImage];
}


+(id)createWithOnImage:(UIImage*)onImage offImage:(UIImage*)offImage{
    return [self createWithTitle:nil onImage:onImage offImage:offImage];
}

+(id)createWithTitle:(NSString*)aTitle image:(UIImage*)image{
    return [self createWithTitle:aTitle onImage:nil offImage:image];
    
}
+(id)createWithTitle:(NSString*)aTitle onImage:(UIImage*)onImage offImage:(UIImage*)offImage{
    UIButton* btn = [self buttonWithType:UIButtonTypeCustom];
 
    btn.size = CGSizeMake(offImage.size.width, offImage.size.height);
    [btn setTitle:aTitle forState:UIControlStateNormal];
 
    [btn setTitle:aTitle forState:UIControlStateNormal];
	[btn setTitle:aTitle forState:UIControlStateSelected];
	[btn setTitle:aTitle forState:UIControlStateHighlighted];
	[btn setTitle:aTitle forState:UIControlStateDisabled];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    if (offImage) {
        [btn setBackgroundImage:offImage forState:UIControlStateNormal];
    }
    
    if (onImage) {
        [btn setBackgroundImage:onImage forState:UIControlStateSelected];     
        [btn setBackgroundImage:onImage forState:UIControlStateHighlighted];  
    } 
    return btn;
}

-(NSString*)title{
    return [self titleForState:UIControlStateNormal];
}


-(void)addTarget:(id)target action:(SEL)action{
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}


@end
