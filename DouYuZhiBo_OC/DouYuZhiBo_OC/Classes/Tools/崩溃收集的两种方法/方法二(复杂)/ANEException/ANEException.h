//
//  ANEException.h
//  VMAppWithKonylib
//
//  Created by issuser on 2019/12/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ANEException : NSObject


@end

void ANERegisterSignalHandler(void);
void ANERegisterUncaughtExceptionHandler(void);

NS_ASSUME_NONNULL_END
