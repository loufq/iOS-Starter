//
//  RootVC.m
//  TollCollector
//
//  Created by loufq on 14-3-23.
//  Copyright (c) 2014年 loufq. All rights reserved.
//

#import "RootVC.h"
#import "LoginVC.h"
#import "SettingVC.h"

@interface RootVC (){
}
@end

@implementation RootVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (![LoginVC isLogin]) {
        LoginVC* vc =[LoginVC createWithBlock:^(id obj) {
            [self afterLoginLoad];
        }];
        UINavigationController* nvc =[[UINavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:nvc animated:YES completion:nil];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([LoginVC isLogin]) [self afterLoginLoad];
    self.title = @"首页";
}

-(void)afterLoginLoad{
    MBProgressHUD* hud =[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setLabelText:@"获取信息..."];
    [hud hide:YES];
    UIBarButtonItem* btn =[FRDLivelyButtonExt createBarItemWithStyle:kFRDLivelyButtonStyleHamburger tapped:^(id obj) {
        SettingVC* vc =[SettingVC create];
        pushVC(vc);
    }];
    self.navigationItem.rightBarButtonItem = btn;
    
}

@end
