//
//  YQGameViewModal.h
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2020/2/8.
//  Copyright © 2020 杨乾. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YQGameViewModal : NSObject


/// 请求所有的游戏数据
/// @param finishBlock 请求完成后的回调
+ (void)requstAllGameDataWithBlock: (void(^)(NSArray *resultArray))finishBlock;

@end

NS_ASSUME_NONNULL_END
