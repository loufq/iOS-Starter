//
//  AppDelegate.m
//  Application
//
//  Created by loufq on 14-5-31.
//  Copyright (c) 2014年 loufq. All rights reserved.
//

#import "AppDelegate.h"
#import "RootVC.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    RootVC* vc =[RootVC create];
    UINavigationController* nvc =[[UINavigationController alloc] initWithRootViewController:vc];
    UIImage* image = [UIImage imageFromColor:MF_ColorFromRGB(0, 139, 202)];
    [nvc.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.window.rootViewController = nvc;
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  
}

@end
