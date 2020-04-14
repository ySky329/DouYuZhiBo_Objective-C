//
//  YQNetworkManager.h
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/11/24.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MethodType) {
    MethodTypeGET = 0,
    MethodTypePOST
};

typedef void(^SuccessBlock)(id responseObject);
typedef void(^FailureBlock)(NSError * error);
typedef void(^ProgressBlock)(NSProgress * progress);
typedef void(^DestinationBlock)(NSURL * targetPathUrl);
typedef void(^NetworkStatus)(NSString *status);

@interface YQNetworkManager : AFHTTPSessionManager

+ (instancetype)shareInstance;


/// 发送 get 请求
/// @param urlString 请求url
/// @param params 请求参数
/// @param progress 网络请求进度
/// @param success 请求成功回调
/// @param failure 请求失败回调
- (void)GET:(NSString *)urlString params:(nullable id)params progress:(nullable ProgressBlock)progress sucess:(SuccessBlock)success failure:(nullable FailureBlock)failure;


/// 发送 post 请求
/// @param urlString 请求url
/// @param params 请求参数
/// @param progress 请求进度
/// @param success 请求成功回调
/// @param failure 请求失败回调
- (void)POST:(NSString *)urlString params:(nullable id)params progress:(nullable ProgressBlock)progress success:(SuccessBlock)success failure:(nullable FailureBlock)failure;


/// 上传文件 (eg: 上传一组图片)
/// @param urlString 请求url
/// @param params 请求参数
/// @param imageArray 要上传的一组图片
/// @param progress 进度
/// @param success 请求成功回调
/// @param failure 请求失败回调
- (void)upload:(NSString *)urlString params: (nullable id)params uploadFile:(NSArray *)imageArray progress:(nullable ProgressBlock)progress success:(SuccessBlock)success failure:(nullable FailureBlock)failure;


/// 下载文件
/// @param urlString 下载链接url
/// @param destination 下载完成后的文件存储地址
/// @param progress 下载进度
/// @param success 成功回调
/// @param failure 失败回调
- (void)download:(NSString *)urlString destination:(DestinationBlock)destination progress:(nullable ProgressBlock)progress success:(nullable SuccessBlock)success failure:(nullable FailureBlock)failure;


/// 监听网络状态
/// @param status 网络状态的回调
- (void)reachabilityStatus:(NetworkStatus)status;

@end

NS_ASSUME_NONNULL_END
