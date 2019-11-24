//
//  YQNetworkManager.h
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/11/24.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MethodType) {
    MethodTypeGET = 0,
    MethodTypePOST
};

typedef void(^SuccessBlock)(NSDictionary * resultDic);
typedef void(^ErrorBlock)(NSError * error);

@interface YQNetworkManager : NSObject

+ (void)requestDataWithMethodType: (MethodType)type urlString: (NSString *)urlStr params: (NSDictionary *)paramsDic success: (SuccessBlock)successBlock failure: (ErrorBlock)errorBlock;

@end

NS_ASSUME_NONNULL_END
