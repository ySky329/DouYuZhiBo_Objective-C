//
//  UIBarButtonItem+Extension.h
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/11/4.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (Extension)

+ (instancetype)barButtonWithImage:(nonnull NSString *)normalImage highlightedImage:(nullable NSString *)highlightedImage size:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
