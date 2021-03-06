//
//  YQCollectionHeaderView.h
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/11/23.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQAnchorGroup.h"

NS_ASSUME_NONNULL_BEGIN

@interface YQCollectionHeaderView : UICollectionReusableView

@property(nonatomic, strong) YQAnchorGroup * anchorGroup;

+ (instancetype)createCollectionHeaderView;

@end

NS_ASSUME_NONNULL_END
