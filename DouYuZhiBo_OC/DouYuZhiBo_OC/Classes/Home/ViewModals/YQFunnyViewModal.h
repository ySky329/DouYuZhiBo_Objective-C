//
//  YQFunnyViewModal.h
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2020/2/15.
//  Copyright © 2020 杨乾. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YQFunnyViewModal : NSObject

+ (void)requestFunnyDataWithFinishedBlock: (void(^)(NSArray *resultArray))finishedBlock;

@end

NS_ASSUME_NONNULL_END
