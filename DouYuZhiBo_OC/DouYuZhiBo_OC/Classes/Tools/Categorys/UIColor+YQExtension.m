//
//  UIColor+YQExtension.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/11/10.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import "UIColor+YQExtension.h"

@implementation UIColor (YQExtension)

+ (instancetype)colorWithRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue andAlpha:(CGFloat)alpha {
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpha];
}

+ (instancetype)randomColor {
    return [UIColor colorWithRed:arc4random_uniform(256) andGreen:arc4random_uniform(256) andBlue:arc4random_uniform(256) andAlpha:1];
}

@end
