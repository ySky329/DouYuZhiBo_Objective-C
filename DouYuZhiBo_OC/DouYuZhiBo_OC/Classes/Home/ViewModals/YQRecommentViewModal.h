//
//  YQRecommentViewModal.h
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/12/15.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YQRecommentViewModal : NSObject


/// 请求热门及推荐的数据
/// @param fiishBlock 回调
+ (void)requestDataWithFinishBlock: (void(^)(NSArray *resultArr))fiishBlock;


/// 请求顶部轮播的数据
/// @param finishBlock 回调
+ (void)requestCycleDataWithFinishBlock: (void(^)(NSArray *resultArray))finishBlock;

@end

NS_ASSUME_NONNULL_END
