//
//  UIBarButtonItemExt.m
//  ShopReport
//
//  Created by loufq on 14-6-1.
//  Copyright (c) 2014年 loufq. All rights reserved.
//

#import "UIBarButtonItemExt.h"

@implementation UIBarButtonItemExt
+(id)createWithSysStyle:(UIBarButtonSystemItem)style tapped:(NormalBlock)block{
    UIBarButtonItem *button = [[self alloc] initWithSysStyle:style tapped:block ];
    return button;
}

+(id)createWithTitle:(NSString*)title tapped:(NormalBlock)block{
    UIBarButtonItem *button = [[self alloc] initWithTitle:title tapped:block ];
    return button;
}

- (id)initWithTitle:(NSString*)title tapped:(NormalBlock)block
{
    self = [super initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(buttonAction:)];
    if (self) {
        self.normalBlock = block;
    }
    return self;
}


- (id)initWithSysStyle:(UIBarButtonSystemItem)style tapped:(NormalBlock)block
{
    self = [super initWithBarButtonSystemItem:style target:self action:@selector(buttonAction:)];
    if (self) {
        self.normalBlock = block;
    }
    return self;
}

-(void)buttonAction:(id)obj{
    if (self.normalBlock) {
        self.normalBlock(obj);
    }
}


@end
