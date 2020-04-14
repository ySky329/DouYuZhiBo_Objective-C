//
//  YQAnchorGroup.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/12/15.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import "YQAnchorGroup.h"

@implementation YQAnchorGroup

- (NSMutableArray<YQAnchor *> *)anchors {
    if (!_anchors) {
        _anchors = [NSMutableArray array];
    }
    return _anchors;
}

- (void)setRoom_list:(NSArray *)room_list {
    for (NSDictionary *dict in room_list) {
        [self.anchors addObject:[YQAnchor anchorWithDict:dict]];
    }
}

@end
