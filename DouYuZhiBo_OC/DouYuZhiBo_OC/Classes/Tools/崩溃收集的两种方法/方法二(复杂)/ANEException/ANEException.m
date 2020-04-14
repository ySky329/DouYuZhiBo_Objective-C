//
//  ANEException.m
//  VMAppWithKonylib
//
//  Created by issuser on 2019/12/31.
//

#import "ANEException.h"

#include <execinfo.h>
#import "ANEExceptionLogger.h"

@implementation ANEException


+ (NSString *)signalNameByNo:(int)signo {
    
    NSString *signalName = @"";
    
    switch (signo) {
        case 1:
            signalName = @"SIGHUP";
            break;
        case 2:
            signalName = @"SIGINT";
            break;
        case 3:
            signalName = @"SIGQUIT";
            break;
        case 4:
            signalName = @"SIGILL";
            break;
        case 5:
            signalName = @"SIGTRAP";
            break;
        case 6:
            signalName = @"SIGABRT";
            break;
        case 7:
        {
            #if  (defined(_POSIX_C_SOURCE) && !defined(_DARWIN_C_SOURCE))
            signalName = @"SIGPOLL";
            #else   /* (!_POSIX_C_SOURCE || _DARWIN_C_SOURCE) */
            signalName = @"SIGEMT";
            #endif  /* (!_POSIX_C_SOURCE || _DARWIN_C_SOURCE) */
        }
            break;
        case 8:
            signalName = @"SIGFPE";
            break;
        case 9:
            signalName = @"SIGKILL";
            break;
        case 10:
            signalName = @"SIGBUS";
            break;
        case 11:
            signalName = @"SIGSEGV";
            break;
        case 12:
            signalName = @"SIGSYS";
            break;
        case 13:
            signalName = @"SIGPIPE";
            break;
        case 14:
            signalName = @"SIGALRM";
            break;
        case 15:
            signalName = @"SIGTERM";
            break;
        case 16:
            signalName = @"SIGURG";
            break;
        case 17:
            signalName = @"SIGSTOP";
            break;
        case 18:
            signalName = @"SIGTSTP";
            break;
        case 19:
            signalName = @"SIGCONT";
            break;
        case 20:
            signalName = @"SIGCHLD";
            break;
        case 21:
            signalName = @"SIGTTIN";
            break;
        case 22:
            signalName = @"SIGTTOU";
            break;
        case 23:
            signalName = @"SIGIO";
            break;
        case 24:
            signalName = @"SIGXCPU";
            break;
        case 25:
            signalName = @"SIGXFSZ";
            break;
        case 26:
            signalName = @"SIGVTALRM";
            break;
        case 27:
            signalName = @"SIGPROF";
            break;
        case 28:
            signalName = @"SIGWINCH";
            break;
        case 29:
            signalName = @"SIGINFO";
            break;
        case 30:
            signalName = @"SIGUSR1";
            break;
        case 31:
            signalName = @"SIGUSR2";
            break;
        default:
            break;
    }
    
    return signalName;
}

@end


void ANEExceptionHandler(NSException *exception) {
    
    // 异常的堆栈信息
    NSArray *stackArray = [exception callStackSymbols];
    // 出现异常的原因
    NSString *reason = [exception reason];
    // 异常名称
    NSString *name = [exception name];
    NSString *exceptionInfo = [NSString stringWithFormat:@"Exception name：%@\nException reason：%@\nException stack：%@",name, reason, stackArray];
    NSLog(@"%@", exceptionInfo);
    [ANEExceptionLogger saveLogger:exceptionInfo withExceptionName:name];
}

void ANERegisterUncaughtExceptionHandler() {
    NSSetUncaughtExceptionHandler(&ANEExceptionHandler);
}

void ANESingalHandler(int signo) {
    NSMutableString *mstr = [[NSMutableString alloc] init];
    [mstr appendString:@"Stack:(\n"];
    void* callstack[128];
    int i, frames = backtrace(callstack, 128);
    char** strs = backtrace_symbols(callstack, frames);
    for (i = 0; i <frames; ++i) {
        [mstr appendFormat:@"%s\n", strs[i]];
    }
    [mstr appendFormat:@"\n)"];
    NSLog(@"ANESingalHandler: %@", mstr);
//    NSString *exceptionInfo = [NSString stringWithCString:strs encoding:<#(NSStringEncoding)#>];
    
//    NSLog(@"%@", exceptionInfo);
    [ANEExceptionLogger saveLogger:mstr withExceptionName:[ANEException signalNameByNo:signo]];
}

void ANERegisterSignalHandler () {
    
    signal(SIGHUP, ANESingalHandler);
    signal(SIGINT, ANESingalHandler);
    signal(SIGQUIT, ANESingalHandler);
    
    signal(SIGABRT, ANESingalHandler);
    signal(SIGILL, ANESingalHandler);
    signal(SIGSEGV, ANESingalHandler);
    signal(SIGFPE, ANESingalHandler);
    signal(SIGBUS, ANESingalHandler);
    signal(SIGPIPE, ANESingalHandler);
}
