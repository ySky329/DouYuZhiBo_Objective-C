//
//  YQGameViewModal.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2020/2/8.
//  Copyright © 2020 杨乾. All rights reserved.
//

#import "YQGameViewModal.h"
#import "YQNetworkManager.h"
#import "YQGameModal.h"

@implementation YQGameViewModal

+ (void)requstAllGameDataWithBlock:(void (^)(NSArray * _Nonnull))finishBlock {
    // http://capi.douyucdn.cn/api/v1/getColumnDetail?shortName=game
    [[YQNetworkManager shareInstance] GET:@"http://capi.douyucdn.cn/api/v1/getColumnDetail" params:@{@"shortName" : @"game"} progress:nil sucess:^(id  _Nonnull responseObject) {
        if (![responseObject[@"error"] isEqual: @0]) {
            YQLog(@"请求所有的游戏数据失败 -- %@", responseObject[@"data"]);
            return;
        }
        if (![self isValidForRequestDada:responseObject]) {
            YQLog(@"请求所有的游戏数据为空");
            return;
        }
        NSArray *responseArray = responseObject[@"data"];
        NSMutableArray * gameArray = [NSMutableArray arrayWithCapacity:responseArray.count];
        for (NSDictionary * dict in responseArray) {
            [gameArray addObject:[YQGameModal baseModalWithDictionary:dict]];
        }
        finishBlock(gameArray);
    } failure:^(NSError * _Nonnull error) {
        YQLog(@"请求所有的游戏数据失败 -- %@", error);
    }];
}

+ (BOOL)isValidForRequestDada: (id)responseObject {
    if (!responseObject || !responseObject[@"data"]) return NO;
    NSArray *responseArray = responseObject[@"data"];
    if (responseArray.count == 0) return NO;
    return YES;
}
@end
