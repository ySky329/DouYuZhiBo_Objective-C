//
//  YQAmusementViewModal.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2020/2/10.
//  Copyright © 2020 杨乾. All rights reserved.
//

#import "YQAmusementViewModal.h"
#import "YQNetworkManager.h"
#import "YQAnchorGroup.h"

@implementation YQAmusementViewModal

+ (void)requestAmusementDataWithFinishedBlock:(void (^)(NSArray * _Nonnull))finishedBlock {
    [[YQNetworkManager shareInstance] GET:@"http://capi.douyucdn.cn/api/v1/getHotRoom/2" params:nil progress:nil sucess:^(id  _Nonnull responseObject) {
        if (![responseObject[@"error"] isEqual: @0]) {
            YQLog(@"请求娱乐游戏数据失败 -- %@", responseObject[@"data"]);
            return;
        }
        if (![self isValidForRequestDada:responseObject]) {
            YQLog(@"请求娱乐数据为空");
            return;
        }
        NSMutableArray * anchorGroupArr = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"data"]) {
            [anchorGroupArr addObject:[YQAnchorGroup baseModalWithDictionary:dict]];
        }
        finishedBlock(anchorGroupArr);
    } failure:^(NSError * _Nonnull error) {
        YQLog(@"请求娱乐数据失败 -- %@", error);
    }];
}

+ (BOOL)isValidForRequestDada: (id)responseObject {
    if (!responseObject || !responseObject[@"data"]) return NO;
    NSArray *responseArray = responseObject[@"data"];
    if (responseArray.count == 0) return NO;
    return YES;
}

@end
