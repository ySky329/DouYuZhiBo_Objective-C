//
//  YQAmusementViewModal.h
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2020/2/10.
//  Copyright © 2020 杨乾. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YQAmusementViewModal : NSObject


/// 请求娱乐的数据
/// @param finishedBlock 请求完成后的回调
+ (void)requestAmusementDataWithFinishedBlock: (void(^)(NSArray * resultArray))finishedBlock;

@end

NS_ASSUME_NONNULL_END
