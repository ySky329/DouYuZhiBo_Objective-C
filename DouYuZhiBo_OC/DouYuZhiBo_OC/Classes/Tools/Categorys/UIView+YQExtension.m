//
//  UIView+YQExtension.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/12/29.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import "UIView+YQExtension.h"

@implementation UIView (YQExtension)

@dynamic origin_x;
@dynamic origin_y;
@dynamic width;
@dynamic height;
@dynamic toLeftMargin;
@dynamic toTopMargin;

- (CGFloat)origin_x {
    return self.frame.origin.x;
}
- (CGFloat)origin_y {
    return self.frame.origin.y;
}
- (CGFloat)width {
    return self.frame.size.width;
}
- (CGFloat)height {
    return self.frame.size.height;
}
- (CGFloat)toLeftMargin {
    return self.frame.origin.x+self.frame.size.width;
}
- (CGFloat)toTopMargin {
    return self.frame.origin.y+self.frame.size.height;
}

- (void)setWidth:(CGFloat)width {
    //重置view的宽
    if (width != self.frame.size.width) {
        CGRect newframe = self.frame;
        newframe.size.width = width;
        self.frame = newframe;
    }
}
- (void)setHeight:(CGFloat)height {
    //重置view的高
    if (height != self.frame.size.height)
    {
        CGRect newframe = self.frame;
        newframe.size.height = height;
        self.frame = newframe;
    }
}
- (void)setOrigin_x:(CGFloat)origin_x {
    //重设view的origin_x
    if (origin_x != self.frame.origin.x)
    {
        CGRect newframe = self.frame;
        newframe.origin.x = origin_x;
        self.frame = newframe;
    }
}

- (UIViewController *)viewController {
    //拿到下一个响应者
    UIResponder * nextRes = self.nextResponder;
    
    do {
        if ([nextRes isKindOfClass:[UIViewController class]]) {
            //如果响应者是viewController则返回
            return (UIViewController *)nextRes;
        }
    } while (nextRes != nil);
    
    return nil;
}

@end
