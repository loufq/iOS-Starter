//
//  FRDLivelyButtonExt.m
//  ShopReport
//
//  Created by loufq on 14-6-1.
//  Copyright (c) 2014年 loufq. All rights reserved.
//

#import "FRDLivelyButtonExt.h"

@implementation FRDLivelyButtonExt

+(id)createWithStyle:(kFRDLivelyButtonStyle)style tapped:(NormalBlock)block{
    FRDLivelyButtonExt *button = [[self alloc] initWithFrame:CGRectMake(0,0,36,28) style:style tapped:block ];
    return button;
}

- (id)initWithFrame:(CGRect)frame style:(kFRDLivelyButtonStyle)style tapped:(NormalBlock)block
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.normalBlock = block;
        [self setStyle:style animated:NO];
        [self addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

+(id)createBarItemWithStyle:(kFRDLivelyButtonStyle)style tapped:(NormalBlock)block{
    FRDLivelyButtonExt *button = [self createWithStyle:style tapped:block];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return buttonItem;
}

-(void)buttonAction:(id)obj{
    if (self.normalBlock) {
        self.normalBlock(obj);
    }
}

@end
