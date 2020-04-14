//
//  YQCycleModal.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2020/1/4.
//  Copyright © 2020 杨乾. All rights reserved.
//

#import "YQCycleModal.h"

@implementation YQCycleModal

+ (instancetype)cycleModalWithDictionary:(NSDictionary *)dict {
    YQCycleModal * modal = [[YQCycleModal alloc] init];
    [modal setValuesForKeysWithDictionary:dict];
    return modal;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

- (void)setRoom:(NSDictionary *)room {
    self.anchor = [YQAnchor anchorWithDict:room];
}

@end
