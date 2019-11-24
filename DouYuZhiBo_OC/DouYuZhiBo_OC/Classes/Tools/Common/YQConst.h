//
//  YQConst.h
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/11/5.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 4英寸 (iPhone5、iPhone5S、iPhone5C、iPhoneSE )
    逻辑分辨率pt：320x568
    物理分辨率：640x1136 二倍
 
 4.7英寸 (iPhone6、iPhone 6S、iPhone7、iPhone8)
    逻辑分辨率pt：375x667
    物理分辨率px：750*1334 二倍
 
 5.5英寸 (iPhone 6 Plus、iPhone 6S Plus 、iPhone 7 Plus、iPhone 8 Plus)
    逻辑分辨率pt：414x736
    物理分辨率px：1080×1920 大约2.6倍
 
 5.8英寸 ( iPhone X、iPhone XS, iPhone 11 Pro)
    逻辑分辨率pt：375x812
    物理分辨率px：1125*2436 三倍
 
 6.1英寸(iPhone XR, iPhone 11)
    逻辑分辨率pt：414x896
    物理分辨率px：828x1792 二倍
 
 6.5英寸 ( iPhone XS Max, iPhone 11 pro)
    逻辑分辨率pt：414x896
    物理分辨率px：1242*2688 三倍
 */

#define BASE_SIZE 375

#ifndef SCREEN_WIDTH
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#endif

#ifndef SCREEN_HEIGHT
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#endif

// 判断是不是全面屏
#define IS_FULLSCREEN (SCREEN_WIDTH == [YQConst sizeFor65InchAnd61Inch].width || SCREEN_WIDTH == [YQConst sizeFor58Inch].width)

#define STATUSBAR_HEIGHT (IS_FULLSCREEN ? 44 : 20)
#define NAVIGATION_HEIGHT 44
#define TABBAR_HEIGHT 49
#define BOTTOM_SAFE_AREA_HEIHGT (IS_FULLSCREEN ? 34 : 0)

static inline CGFloat YQAdapter(CGFloat x) {
    // 屏幕宽度按比较适配
    CGFloat scale = SCREEN_WIDTH / BASE_SIZE;
    return x * scale;
}

static inline CGRect YQRectAdapter(CGFloat x, CGFloat y, CGFloat width, CGFloat height) {
    return CGRectMake(YQAdapter(x), YQAdapter(y), YQAdapter(width), YQAdapter(height));
}


/// 判断一个对象是否为空  YES : 为空
/// @param obj 判断的对象
static inline BOOL YQIsObjectEmpty(id obj) {
    return obj == nil ||
    [obj isEqual:[NSNull null]] ||
    ([obj respondsToSelector:@selector(count)] && [(NSArray *)obj count] == 0) ||
    ([obj respondsToSelector:@selector(length)] && [(NSData *)obj length] == 0) ||
    ([obj isKindOfClass:[NSDictionary class]] && [(NSDictionary *)obj allKeys] == 0);
}


/// 判断字符串是否为空  YES: 为空
/// @param string 判断的p字符串
static inline BOOL YQIsStringEmpty(NSString *string) {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isEqualToString:@"<null>"] || [string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

@interface YQConst : NSObject

// iPhone XS Max, iPhone 11 pro,  iPhone 11和 iPhone XR
+ (CGSize)sizeFor65InchAnd61Inch;

// iPhone X、iPhone XS, iPhone 11 Pro
+ (CGSize)sizeFor58Inch;

@end

NS_ASSUME_NONNULL_END
