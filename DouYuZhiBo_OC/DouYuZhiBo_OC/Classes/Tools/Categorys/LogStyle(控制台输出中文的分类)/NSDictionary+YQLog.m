//
//  NSDictionary+YQLog.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/12/21.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import "NSDictionary+YQLog.h"
#import <objc/runtime.h>

static inline void yq_swizzleSelector(Class theClass, SEL originSelector, SEL swizzSelector) {
    Method originMethod = class_getInstanceMethod(theClass, originSelector);
    Method swizzMethod = class_getInstanceMethod(theClass, swizzSelector);
    
    /*
     *  didAddMethod 若为true, 则表示替换的方法不存在, 得先添加这个方法的实现, 再替换方法
                     若为false, 则直接交换方法
     */
    
    BOOL didAddMethod = class_addMethod(theClass, originSelector, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
    
    if (didAddMethod) {
        class_replaceMethod(theClass, swizzSelector, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(swizzMethod, originMethod);
    }
}

@implementation NSDictionary (YQLog)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        yq_swizzleSelector([self class], @selector(descriptionWithLocale:indent:), @selector(yq_descriptionWithLocale:indent:));
    });
}

- (NSString *)yq_descriptionWithLocale: (id)locale indent: (NSUInteger)level {
    return [self stringByReplaceUnicode:[self yq_descriptionWithLocale:locale indent:level]];
}

- (NSString *)stringByReplaceUnicode:(NSString *)unicodeString
{
    NSMutableString *convertedString = [unicodeString mutableCopy];
    [convertedString replaceOccurrencesOfString:@"\\U" withString:@"\\u" options:0 range:NSMakeRange(0, convertedString.length)];
    CFStringRef transform = CFSTR("Any-Hex/Java");
    CFStringTransform((__bridge CFMutableStringRef)convertedString, NULL, transform, YES);
    
    return convertedString;
}

@end
