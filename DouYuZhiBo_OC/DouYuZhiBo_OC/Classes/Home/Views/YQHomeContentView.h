//
//  YQHomeContentView.h
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/11/9.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YQHomeContentView;

@protocol YQHomeContentViewDelegate <NSObject>

@optional
- (void)homeContentView: (YQHomeContentView *)contentView scrollOffsetX: (CGFloat)offsetX;

@end

@interface YQHomeContentView : UIView

@property (nonatomic, weak) id<YQHomeContentViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame childControlls: (NSArray<UIViewController *> *)childControlls parentViewController: (UIViewController *)parent;

- (void)selectedTopViewWithLabelTab: (NSInteger)tag;

@end

NS_ASSUME_NONNULL_END
