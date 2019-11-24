//
//  UIBarButtonItem+Extension.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/11/4.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (instancetype)barButtonWithImage:(nonnull NSString *)normalImage highlightedImage:(nullable NSString *)highlightedImage size:(CGSize)size {
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    
    if (highlightedImage) {
        [button setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    }
    if (size.width == CGSizeZero.width && size.height == CGSizeZero.height) {
        [button sizeToFit];
    } else {
        button.frame = CGRectMake(0, 0, size.width, size.height);
    }
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
