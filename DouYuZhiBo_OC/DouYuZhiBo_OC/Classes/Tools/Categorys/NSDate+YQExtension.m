//
//  NSDate+YQExtension.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/12/15.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import "NSDate+YQExtension.h"

@implementation NSDate (YQExtension)

+ (NSString *)getCurrentDateInterval {
    NSDate *date = [NSDate date];
    NSInteger interval = [date timeIntervalSince1970];
    return [NSString stringWithFormat:@"%ld",(long)interval];
}

@end
