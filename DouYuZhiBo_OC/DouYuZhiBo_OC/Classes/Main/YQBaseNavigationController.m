//
//  YQBaseNavigationController.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2020/2/18.
//  Copyright © 2020 杨乾. All rights reserved.
//

#import "YQBaseNavigationController.h"
#import <objc/message.h>
#import <objc/runtime.h>

@interface YQBaseNavigationController ()

@end

@implementation YQBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 全屏 pop手势的实现...
    // 先获取系统的手势
    UIGestureRecognizer *systemGesture = self.interactivePopGestureRecognizer;
    
    // 获取手势添加到的 view 中
    UIView *gestureView = systemGesture.view;
    
    // 获取 target / action
    NSArray *targets = [systemGesture valueForKey:@"_targets"];
    id targetObj = targets[0];
    
    // 取出 target
    id target = [targetObj valueForKey:@"target"];
    
    // 取出 action
//    id action = [targetObj valueForKey:@"action"];
    SEL action = NSSelectorFromString(@"handleNavigationTransition:");
    
    // 创建自己的 pan 手势
    UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:target action:action];
    [gestureView addGestureRecognizer:panGesture];
    
    // 打印一个对象的类名
    // YQLog(@"%@",[NSString stringWithCString:object_getClassName(targetObj) encoding:NSUTF8StringEncoding]);
    
    
    /* 利用运行时机制 打印 UIGestureRecognizer 中的所有属性
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList([UIGestureRecognizer self], &count);
    for (NSInteger i=0; i<count; i++) {
        Ivar property = ivarList[i];
        const char *name = ivar_getName(property);
        NSString * propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        YQLog(@"%@", propertyName);
    }
     */
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 当push时 隐藏底部的bottom
    viewController.hidesBottomBarWhenPushed = YES;
    
    
    
    [super pushViewController:viewController animated:animated];
    
}

@end
