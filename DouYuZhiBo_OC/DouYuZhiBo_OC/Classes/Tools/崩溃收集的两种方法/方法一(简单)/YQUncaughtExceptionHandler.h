//
//  YQUncaughtExceptionHandler.h
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/12/7.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 功能: 收集iOS崩溃信息, 保存沙盒并上传至服务器流程
@interface YQUncaughtExceptionHandler : NSObject

+ (void)setDefaultHandler;

@end

NS_ASSUME_NONNULL_END
