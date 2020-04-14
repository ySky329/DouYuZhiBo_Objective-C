//
//  YQAnchor.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/12/15.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import "YQAnchor.h"

@implementation YQAnchor

+ (instancetype)anchorWithDict:(NSDictionary *)dict {
    YQAnchor * anchor = [[YQAnchor alloc] init];
    [anchor setValuesForKeysWithDictionary:dict];
    return anchor;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

@end
