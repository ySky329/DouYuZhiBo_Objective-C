//
//  YQHomeTopView.h
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/11/9.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YQHomeTopView;

@protocol YQHomeTopViewDelegate <NSObject>

@optional
- (void)homeTopView: (YQHomeTopView *)topView didTapLabelTag: (NSInteger)tag;

@end

@interface YQHomeTopView : UIView

@property (nonatomic, weak) id<YQHomeTopViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame titles: (NSArray *)titles;

- (void) contentViewScrollOffsetY: (CGFloat) offsetX;

@end

NS_ASSUME_NONNULL_END
