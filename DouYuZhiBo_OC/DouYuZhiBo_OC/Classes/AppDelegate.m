//
//  AppDelegate.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/10/27.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "YQUncaughtExceptionHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
        
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIStoryboard * homeStoryboard = [UIStoryboard storyboardWithName:@"MainViewController" bundle:nil];
    MainViewController * homeVC =  [homeStoryboard instantiateInitialViewController];
    
    self.window.rootViewController = homeVC;
    [self.window makeKeyAndVisible];
    
    [YQUncaughtExceptionHandler setDefaultHandler];
    
    return YES;
}



@end
