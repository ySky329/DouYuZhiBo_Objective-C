//
//  AppDelegate.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/10/27.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [UITabBar appearance].tintColor = [UIColor orangeColor];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIStoryboard * homeStoryboard = [UIStoryboard storyboardWithName:@"MainViewController" bundle:nil];
    MainViewController * homeVC =  [homeStoryboard instantiateInitialViewController];
    
//    HomeViewController * homeVC = [[HomeViewController alloc] init];
    self.window.rootViewController = homeVC;
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
