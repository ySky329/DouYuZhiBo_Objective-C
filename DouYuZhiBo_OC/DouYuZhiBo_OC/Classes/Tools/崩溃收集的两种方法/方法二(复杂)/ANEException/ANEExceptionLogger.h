//
//  ANEExceptionLogger.h
//  VMAppWithKonylib
//
//  Created by issuser on 2019/12/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ANEExceptionLogger : NSObject

+ (BOOL)existLoggerFile;

+ (BOOL)saveLogger:(NSString *)logContent withExceptionName:(NSString *)exceptionName;
+ (void)uploadLogger;
+ (BOOL)deleteLogger:(NSString *)fileName;

@end

NS_ASSUME_NONNULL_END
