//
//  Single.h
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/12/3.
//  Copyright © 2019 杨乾. All rights reserved.
//

// name 为带的参数
#define SingleH(name) +(instancetype)share##name;
#define SingleM(name) + (instancetype)share##name {\
    static id _instance = nil;\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _instance = [[super allocWithZone:NULL] init];\
    });\
    return _instance;\
}\
+ (instancetype)allocWithZone:(struct _NSZone *)zone {\
return [self share##name];\
}\
- (id)copyWithZone:(NSZone *)zone {\
    return [[self class] share##name];\
}\
- (id)mutableCopyWithZone:(NSZone *)zone {\
    return [[self class] share##name];\
}

#define macro
