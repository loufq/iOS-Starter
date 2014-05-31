//
//  BaseVC.m
//  Dispatch
//
//  Created by loufq on 14-3-9.
//  Copyright (c) 2014年 loufq. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()
@end

@implementation BaseVC{

}

+(id)create{
    return [self new];
}

+(id)createWithBlock:(NormalBlock)block{
    id obj =[[self alloc] initWithBlock:block];
    return obj;
}

- (id)initWithBlock:(NormalBlock)block {
    if (self = [super initWithNibName:nil bundle:nil]) {
		_normalBlock = [block copy]; 
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)isLandscape{
    BOOL isLands =  UIInterfaceOrientationIsLandscape(self.interfaceOrientation);
    return isLands;
}
-(BOOL)hasVC:(Class)aClass{
    NSArray* list =self.navigationController.viewControllers;
    BOOL hasIT =NO;
    for (UIViewController* vc in list) {
        if ([vc isKindOfClass:aClass]) {
            hasIT =YES;
            break;
        }
    }
    return hasIT;
}
@end
