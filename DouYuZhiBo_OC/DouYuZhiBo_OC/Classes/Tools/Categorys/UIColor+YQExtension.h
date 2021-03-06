//
//  UIColor+YQExtension.h
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/11/10.
//  Copyright © 2019 杨乾. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (YQExtension)

+ (instancetype)colorWithRed: (CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue andAlpha:(CGFloat)alpha;
+ (instancetype)randomColor;

@end

NS_ASSUME_NONNULL_END
