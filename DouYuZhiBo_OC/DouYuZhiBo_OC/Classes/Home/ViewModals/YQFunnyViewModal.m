//
//  YQFunnyViewModal.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2020/2/15.
//  Copyright © 2020 杨乾. All rights reserved.
//

#import "YQFunnyViewModal.h"
#import "YQNetworkManager.h"
#import "NSDate+YQExtension.h"
#import "YQAnchorGroup.h"

@implementation YQFunnyViewModal

+ (void)requestFunnyDataWithFinishedBlock:(void (^)(NSArray * resultArray))finishedBlock {
    NSDictionary *params = @{@"limit" : @"4", @"offset" : @"0", @"time" : [NSDate getCurrentDateInterval]};
    [[YQNetworkManager shareInstance] GET:@"http://capi.douyucdn.cn/api/v1/getHotCate" params:params progress:nil sucess:^(id  _Nonnull responseObject) {
            if (![responseObject[@"error"] isEqual: @0]) {
                YQLog(@"请求趣玩数据失败 -- %@", responseObject[@"data"]);
                return;
            }
            if (![self isValidForRequestDada:responseObject]) {
                YQLog(@"请求趣玩数据为空");
                return;
            }
            NSMutableArray * anchorGroupArr = [NSMutableArray array];
            for (NSDictionary *dict in responseObject[@"data"]) {
                [anchorGroupArr addObject:[YQAnchorGroup baseModalWithDictionary:dict]];
            }
            finishedBlock(anchorGroupArr);
        } failure:^(NSError * _Nonnull error) {
            YQLog(@"请求趣玩数据失败 -- %@", error);
        }];
    }

    + (BOOL)isValidForRequestDada: (id)responseObject {
        if (!responseObject || !responseObject[@"data"]) return NO;
        NSArray *responseArray = responseObject[@"data"];
        if (responseArray.count == 0) return NO;
        return YES;
    }

@end
