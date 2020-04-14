//
//  YQUncaughtExceptionHandler.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/12/7.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import "YQUncaughtExceptionHandler.h"
#import "YQNetworkManager.h"

// 内联函数的定义必须在调用之前
static inline NSString* YQApplicationDocumentsDirectory() {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

void UncaughtExceptionHandler(NSException *exception) {
    NSArray *arr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSString * urlStr = [NSString stringWithFormat:@"========异常错误报告========\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@",name,reason,[arr componentsJoinedByString:@"\n"]];
    NSLog(@"%@", urlStr);
    
    // 将崩溃日志写到沙盒中
//    NSString * pathStr = [YQApplicationDocumentsDirectory() stringByAppendingPathComponent:@"Exception.txt"];
//    [urlStr writeToFile:pathStr atomically:YES encoding:NSUTF8StringEncoding error:nil];
}



@implementation YQUncaughtExceptionHandler

+ (void)setDefaultHandler {
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
}

// 获取沙盒的崩溃日志
- (void)getCaughtExceptionMessage {
    NSString * pathStr = [YQApplicationDocumentsDirectory() stringByAppendingPathComponent:@"Exception.txt"];
    NSData * data = [NSData dataWithContentsOfFile:pathStr];
    if (data != nil) {
        [self sendExceptionMessageWithData:data path:pathStr];
    }
}

// 发送崩溃日志
- (void)sendExceptionMessageWithData: (NSData *)data path:(NSString *)path{
    NSString * urlStr = @"后台地址";
    NSString * params = @"请求体";
    [[YQNetworkManager shareInstance] POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:@"Exception.txt" mimeType:@"txt"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 上传文件后 删除
        NSFileManager * fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:path error:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败");
    }];
}

@end
