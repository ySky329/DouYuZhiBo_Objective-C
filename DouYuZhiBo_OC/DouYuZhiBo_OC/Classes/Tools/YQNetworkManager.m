//
//  YQNetworkManager.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/11/24.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import "YQNetworkManager.h"

@implementation YQNetworkManager

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static YQNetworkManager * _instance = nil;
    dispatch_once(&onceToken, ^{
        _instance = [YQNetworkManager manager];
        _instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",@"text/html", nil];
        _instance.requestSerializer.timeoutInterval = 15.0f;
    });
    return _instance;
}

- (void)GET:(NSString *)urlString params:(nullable id)params progress:(nullable ProgressBlock)progress sucess:(SuccessBlock)success failure:(nullable FailureBlock)failure {
    [self GET:urlString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            progress(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)POST:(NSString *)urlString params:(id)params progress:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlock)failure {
    [self POST:urlString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)upload:(NSString *)urlString params:(id)params uploadFile:(NSArray *)imageArray progress:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlock)failure {
    [self POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (UIImage *image in imageArray) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            NSString *fileName = [NSString stringWithFormat:@"%@.png", [formatter stringFromDate:[NSDate date]]];
            NSData *data = UIImagePNGRepresentation(image);
            [formData appendPartWithFileData:data name:@"uploadImage" fileName:fileName mimeType:@"image/png"];  // mimeType: 上传文件时得指定上传文件的类型
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)download:(NSString *)urlString destination:(DestinationBlock)destination progress:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlock)failure {
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSURLSessionDownloadTask * downloadTask = [self downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            progress(downloadProgress);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *fullPath = [caches stringByAppendingPathComponent:response.suggestedFilename];
        NSURL *filePathUrl = [NSURL fileURLWithPath:fullPath];
        return filePathUrl;  // 返回一个url 地址, 用来告诉AFN文件下载的目标地址
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            failure(error);
        }
        if (filePath) {
            destination(filePath);
        }
    }];
    
    // 执行下载 task
    [downloadTask resume];
}

- (void)reachabilityStatus:(NetworkStatus)status {
    
    // 创建网络状态检测管理者
    AFNetworkReachabilityManager * reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    //2.监听状态的改变
   /*
    AFNetworkReachabilityStatusUnknown          = -1, 未知
    AFNetworkReachabilityStatusNotReachable     = 0,  没有网络
    AFNetworkReachabilityStatusReachableViaWWAN = 1,  蜂窝网络
    AFNetworkReachabilityStatusReachableViaWiFi = 2   Wifi
    */
   [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
       switch (status) {
           case AFNetworkReachabilityStatusReachableViaWWAN:
               NSLog(@"蜂窝网络");
               break;
           case AFNetworkReachabilityStatusReachableViaWiFi:
               NSLog(@"WIFI");
               break;
           case AFNetworkReachabilityStatusNotReachable:
               NSLog(@"没有网络");
               break;
           case AFNetworkReachabilityStatusUnknown:
               NSLog(@"未知");
               break;
           default:
               break;
       }
   }];

   //3.开始监听
   [reachabilityManager startMonitoring];
}

@end
