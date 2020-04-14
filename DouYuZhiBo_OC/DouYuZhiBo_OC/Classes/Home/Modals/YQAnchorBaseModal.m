//
//  YQAnchorBaseModal.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2020/2/8.
//  Copyright © 2020 杨乾. All rights reserved.
//

#import "YQAnchorBaseModal.h"

@implementation YQAnchorBaseModal

+ (instancetype)baseModalWithDictionary:(NSDictionary *)dict {
    YQAnchorBaseModal * baseModal = [[self alloc] init];
    [baseModal setValuesForKeysWithDictionary:dict];
    return baseModal;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

@end
