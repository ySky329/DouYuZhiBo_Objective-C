//
//  NSMutableArray+YQCrashExtection.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/12/7.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import <objc/runtime.h>


/// 对可变数据添加元素的异常捕获
@implementation NSMutableArray (YQCrashExtection)

+ (void)load {
    Class arrayMClass = NSClassFromString(@"__NSArrayM");
    
    // 获取系统添加元素的方法
    Method addObject = class_getInstanceMethod(arrayMClass, @selector(addObject:));
    
    // 获取自定义添加元素的方法
    Method avoidCrashAddObject = class_getInstanceMethod(arrayMClass, @selector(avoidCrashAddObject:));
    
    // 交换两个方法
    method_exchangeImplementations(addObject, avoidCrashAddObject);
}

- (void)avoidCrashAddObject:(id)objct {
    @try {
        [self avoidCrashAddObject:objct];
    } @catch (NSException *exception) {
        // 捕捉到异常后 对异常进行处理
        NSLog(@"\n异常名称: %@\n异常原因: %@", exception.name, exception.reason);
    }
}

@end
