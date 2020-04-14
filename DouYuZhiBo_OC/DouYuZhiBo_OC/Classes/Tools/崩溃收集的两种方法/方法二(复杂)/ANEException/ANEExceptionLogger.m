//
//  ANEExceptionLogger.m
//  VMAppWithKonylib
//
//  Created by issuser on 2019/12/31.
//

#import "ANEExceptionLogger.h"

#import "UIDevice+Platform.h"

#define EXCEPTION_DEBUG 1

#define LOGGER_PATH [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Crash"]

#if EXCEPTION_DEBUG
#define ANEException_UPLOAD_HOST @"https://newecard-qa.amwaynet.com.cn/NewEcard-api"
#else
#define ANEException_UPLOAD_HOST @"https://newecard.amwaynet.com.cn/NewEcard-api"
#endif

#define ANEExcepotion_UPLOAD_URL @"/setting/uploadExceptionLog"

#define ANEAppName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]
#define ANEAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

static NSString *uploadLoggerFile = nil;
static dispatch_queue_t uploadExceptionQueue = nil;
static NSString *_uploadLoggerTag = nil;

@interface ANEExceptionLogger() <NSURLSessionTaskDelegate>

@end

@implementation ANEExceptionLogger

+ (instancetype)logger {
    
    static ANEExceptionLogger *logger = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        logger = [[ANEExceptionLogger alloc] init];
    });
    
    return logger;
}

+ (dispatch_queue_t) ANEUploadExceptionQueue {
    
    if (uploadExceptionQueue == nil) {
        uploadExceptionQueue = dispatch_queue_create("ANEUploadExceptionQueue", DISPATCH_QUEUE_SERIAL);
    }
    
    return uploadExceptionQueue;
}

+ (NSString *)getLoggerBasicInfo {
    
    NSMutableString *loggerBasicInfo = [NSMutableString string];
    
    NSString *appInfo = [NSString stringWithFormat:@"AppName:%@ %@", ANEAppName, ANEAppVersion];
    NSString *UUIDString = [NSString stringWithFormat:@"UUID:%@", [[UIDevice currentDevice] identifierForVendor].UUIDString];
    NSString *deviceName = [NSString stringWithFormat:@"Device Model:%@", [[UIDevice currentDevice] getDevicePlatform]];
    NSString *OSVersion = [NSString stringWithFormat:@"OS Version:%@ %@", [[UIDevice currentDevice] systemName], [[UIDevice currentDevice] systemVersion]];
    
    [loggerBasicInfo appendFormat:@"%@\n", appInfo];
    [loggerBasicInfo appendFormat:@"%@\n", UUIDString];
    [loggerBasicInfo appendFormat:@"%@\n", deviceName];
    [loggerBasicInfo appendFormat:@"%@\n\n", OSVersion];
    
    return loggerBasicInfo;
}

+ (BOOL)existLoggerFile {
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:LOGGER_PATH]) {
        NSError *error = nil;
        NSArray *fileList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:LOGGER_PATH error:&error];
        if (![fileList count] || fileList == nil || error != nil) {
            return NO;
        } else {
            return YES;
        }
    }
    
    return NO;
}

+ (BOOL)saveLogger:(NSString *)logContent withExceptionName:(nonnull NSString *)exceptionName {
    NSError *error = nil;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:LOGGER_PATH]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:LOGGER_PATH withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"创建目录失败:%@", error);
            return NO;
        }
    }
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *exceptionTime = [formatter stringFromDate:date];
    
    NSString *fileName = [NSString stringWithFormat:@"iOS_EXCEPTION_%@_%@.txt", exceptionName, exceptionTime];
    
    NSString *exceptionContent = [NSString stringWithFormat:@"%@%@", [ANEExceptionLogger getLoggerBasicInfo], logContent];
    
    BOOL result = [exceptionContent writeToFile:[LOGGER_PATH stringByAppendingPathComponent:fileName] atomically:YES encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"SAVE_LOGGER_RESULT:%u", result);
    NSLog(@"SAVE_LOGGER_ERROR:%@", error);
    
    return result;
}

+ (BOOL)deleteLogger:(NSString *)fileName {
    if ([[NSFileManager defaultManager] fileExistsAtPath:LOGGER_PATH]) {
        NSError *error = nil;
        NSArray *fileList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:LOGGER_PATH error:&error];
        NSLog(@"fileList: %@", fileList);
        if ([fileList count] && fileList != nil) {
            
            BOOL result = [[NSFileManager defaultManager] removeItemAtPath:[LOGGER_PATH stringByAppendingPathComponent:fileName] error:&error];
            NSLog(@"DELETE_LOGGER_REMOVE:%u", result);
            if (error) {
                NSLog(@"DELETE_LOGGER_REMOVE:%@", error);
                return NO;
            }
            return result;
        } else if(error != nil) {
            NSLog(@"DELETE_LOGGER_CONTENTLIST:%@", error);
            return NO;
        }
    }
    
    return NO;
}

+ (void)uploadLogger {
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:LOGGER_PATH]) {
        
        NSError *error = nil;
        NSArray *fileList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:LOGGER_PATH error:&error];
        NSLog(@"uploadLogger fileList:%@", fileList);
        if ([fileList count]) {
            
            dispatch_semaphore_t semphore = dispatch_semaphore_create(1);
            for (NSInteger i = 0; i < [fileList count]; i++) {
                NSString *filePath = fileList[i];
                if ([filePath isEqualToString:@".DS_Store"]) {
                    continue ;
                }
                dispatch_async([self ANEUploadExceptionQueue], ^{
                    dispatch_semaphore_wait(semphore, DISPATCH_TIME_FOREVER);
                    //os=iphone os 12.4&uuid=123&appVersion=v1.0.0&exceptionName=nullException&file=文件
                    
                    __block NSString *fileName = [[filePath componentsSeparatedByString:@"/"] lastObject];
                    
//                    NSLog(@"bodyString: %@", bodyString);
                    
                    NSString *URLString = [NSString stringWithFormat:@"%@%@", ANEException_UPLOAD_HOST, ANEExcepotion_UPLOAD_URL];
                    
                    _uploadLoggerTag = [[ANEExceptionLogger logger] getRandomString];
                    
                    NSMutableURLRequest *uploadRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
                    NSString *header = [NSString stringWithFormat:@"multipart/form-data;boundary=%@", _uploadLoggerTag];
                    // 设置本次请求的提交数据格式
                    [uploadRequest setValue:header forHTTPHeaderField:@"Content-Type"];
                    uploadRequest.HTTPMethod = @"POST";
                    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:[ANEExceptionLogger logger] delegateQueue:[NSOperationQueue mainQueue]];
                    NSData *formData = [[ANEExceptionLogger logger] uploadDataFromFilePath:filePath];
                    [uploadRequest setHTTPBody:formData];
                    NSLog(@"formdata: %@", formData);
                    NSLog(@"formdata: %@", [[NSString alloc] initWithData:formData encoding:NSUTF8StringEncoding]);
                    [uploadRequest setHTTPBody:formData];
                    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:uploadRequest fromData:formData completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                        NSLog(@"fileName:%@", fileName);
                        NSLog(@"data:%@", data);
                        NSLog(@"data encoding:%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                        NSLog(@"response:%@", response);
                        NSLog(@"error:%@", error);
                        NSLog(@"rr:%@", uploadTask.response);
                        if (!error) {

                            [ANEExceptionLogger deleteLogger:fileName];
                        }

                        fileName = nil;
                        dispatch_semaphore_signal(semphore);
                    }];
                    [uploadTask resume];
                    
                });
            }
        }
    }
}

- (NSString *)getRandomString {

    char data[30];
    
    for (int x = 0; x < 30; data[x++] = (char)('A' + (arc4random_uniform(26))));
    
    NSString *randomStr = [[NSString alloc] initWithBytes:data length:30 encoding:NSUTF8StringEncoding];
    
    NSString *string = [NSString stringWithFormat:@"%@",randomStr];
    
    NSLog(@"获取随机字符串 %@",string);
    
    return string;
}

- (NSData *)uploadDataFromFilePath:(NSString *)filePath {
    NSMutableData *uData = [NSMutableData data];
    
    NSString *OSVersion = [NSString stringWithFormat:@"%@ %@", [[UIDevice currentDevice] systemName], [[UIDevice currentDevice] systemVersion]];
    NSString *UUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *fileName = [[filePath componentsSeparatedByString:@"/"] lastObject];
    NSString *exceptionName = [fileName componentsSeparatedByString:@"_"][2];
    
    /// 上传标志
    NSString *uploadMark = [NSString stringWithFormat:@"--%@\r\n", _uploadLoggerTag];

    
    NSString *os_disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"os\"\r\nContent-Length:%lu\r\n\r\n%@", (unsigned long)OSVersion.length, OSVersion];
    
    NSString *uuid_disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"uuid\"\r\nContent-Length:%lu\r\n\r\n%@", (unsigned long)UUID.length, UUID];
    NSString *exception_disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"exceptionName\"\r\nContent-Length:%lu\r\n\r\n%@", (unsigned long)exceptionName.length, exceptionName];
    NSString *appVersion_disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"appVersion\"\r\nContent-Length:%lu\r\n\r\n%@", (unsigned long)[(NSString *)ANEAppVersion length], ANEAppVersion];
  
    NSData *fileData = [NSData dataWithContentsOfFile:[LOGGER_PATH stringByAppendingPathComponent:filePath]];
    NSString *file_disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"; \"Content-Type:multipart/form-data\";\"Content-Length:%lu\"\r\n\r\n%@", fileName, (unsigned long)fileData.length, fileData];
    
    [uData appendData:[uploadMark dataUsingEncoding:NSUTF8StringEncoding]];
    [uData appendData:[os_disposition dataUsingEncoding:NSUTF8StringEncoding]];
    [uData appendData:[@"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [uData appendData:[uploadMark dataUsingEncoding:NSUTF8StringEncoding]];
    [uData appendData:[uuid_disposition dataUsingEncoding:NSUTF8StringEncoding]];
    [uData appendData:[@"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [uData appendData:[uploadMark dataUsingEncoding:NSUTF8StringEncoding]];
    [uData appendData:[appVersion_disposition dataUsingEncoding:NSUTF8StringEncoding]];
    [uData appendData:[@"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [uData appendData:[uploadMark dataUsingEncoding:NSUTF8StringEncoding]];
    [uData appendData:[exception_disposition dataUsingEncoding:NSUTF8StringEncoding]];
    [uData appendData:[@"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [uData appendData:[uploadMark dataUsingEncoding:NSUTF8StringEncoding]];
    [uData appendData:[file_disposition dataUsingEncoding:NSUTF8StringEncoding]];
    [uData appendData:[@"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [uData appendData:[uploadMark dataUsingEncoding:NSUTF8StringEncoding]];
    [uData appendData:[@"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

    return uData;
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend {
    
    NSLog(@"uploadException: %lld/%lld", totalBytesSent, totalBytesExpectedToSend);
}


- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    NSLog(@"上传完成");
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didFinishCollectingMetrics:(NSURLSessionTaskMetrics *)metrics {
    
}

@end
