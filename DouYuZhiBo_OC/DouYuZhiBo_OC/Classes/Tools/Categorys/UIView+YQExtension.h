//
//  UIView+YQExtension.h
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/12/29.
//  Copyright © 2019 杨乾. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (YQExtension)

@property CGFloat origin_x;
@property CGFloat origin_y;

@property CGFloat width;
@property CGFloat height;

@property (readonly) CGFloat toLeftMargin;       //origin_x+width
@property (readonly) CGFloat toTopMargin;        //origin_y+height


/// 获取当前view的ViewController
- (UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
