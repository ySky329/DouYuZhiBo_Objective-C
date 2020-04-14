//
//  YQRecommentViewModal.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/12/15.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import "YQRecommentViewModal.h"
#import "YQNetworkManager.h"
#import "NSDate+YQExtension.h"
#import "YQAnchorGroup.h"
#import "YQCycleModal.h"

@interface YQRecommentViewModal()

@end

@implementation YQRecommentViewModal

+ (void)requestDataWithFinishBlock:(void (^)(NSArray *resultArr))finishBlock {
    NSMutableArray * anchorGroupArr = [NSMutableArray array];
    YQAnchorGroup * prettyGroup = [[YQAnchorGroup alloc] init];
    YQAnchorGroup * recommentGroup = [[YQAnchorGroup alloc] init];
    
    NSDictionary *params = @{@"limit" : @"4", @"offset" : @"0", @"time" : [NSDate getCurrentDateInterval]};
    
    dispatch_group_t dispatchGroup = dispatch_group_create();
    
    // 请求第一部分推荐数据
    dispatch_group_enter(dispatchGroup);
    [[YQNetworkManager shareInstance] GET:@"http://capi.douyucdn.cn/api/v1/getbigDataRoom" params:@{@"time": [NSDate getCurrentDateInterval]} progress:nil sucess:^(id  _Nonnull responseObject) {
        if (![self isValidForRequestDada:responseObject]) {
            NSLog(@"请求第一部分推荐数据为空");
        } else {
            recommentGroup.tag_name = @"热门";
            recommentGroup.icon_name = @"home_header_hot";
            for (NSDictionary * dict in responseObject[@"data"]) {
                [recommentGroup.anchors addObject:[YQAnchor anchorWithDict:dict]];
            }
        }
        dispatch_group_leave(dispatchGroup);
        
    } failure:^(NSError * _Nonnull error) {
        dispatch_group_leave(dispatchGroup);
        NSLog(@"请求第一部分推荐数据 -- %@", error);
    }];
    
    // 请求第二部分颜值数据
    dispatch_group_enter(dispatchGroup);
    [[YQNetworkManager shareInstance] GET:@"http://capi.douyucdn.cn/api/v1/getVerticalRoom" params:params progress:nil sucess:^(id  _Nonnull responseObject) {
        if (![self isValidForRequestDada:responseObject]) {
            NSLog(@"请求第二部分颜值数据为空");
        } else {
            prettyGroup.tag_name = @"颜值";
            prettyGroup.icon_name = @"home_header_phone";
            for (NSDictionary *dict in responseObject[@"data"]) {
                [prettyGroup.anchors addObject:[YQAnchor anchorWithDict:dict]];
            }
        }
        dispatch_group_leave(dispatchGroup);
    } failure:^(NSError * _Nonnull error) {
        dispatch_group_leave(dispatchGroup);
        NSLog(@"请求第二部分颜值数据 -- %@", error);
    }];
    
    // 请求2-12部分游戏数据
    dispatch_group_enter(dispatchGroup);
    [[YQNetworkManager shareInstance] GET:@"http://capi.douyucdn.cn/api/v1/getHotCate" params:params progress:nil sucess:^(id  _Nonnull responseObject) {
        if (![self isValidForRequestDada:responseObject]) {
            NSLog(@"请求2-12部分游戏数据为空");
        } else {
            for (NSDictionary *dict in responseObject[@"data"]) {
                [anchorGroupArr addObject:[YQAnchorGroup baseModalWithDictionary:dict]];
            }
        }
        
        dispatch_group_leave(dispatchGroup);
        
    } failure:^(NSError * _Nonnull error) {
        dispatch_group_leave(dispatchGroup);
        NSLog(@"请求2-12部分游戏数据失败 -- %@", error);
    }];
    
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^{
        [anchorGroupArr insertObject:prettyGroup atIndex:0];
        [anchorGroupArr insertObject:recommentGroup atIndex:0];
        
        finishBlock(anchorGroupArr);
    });
}

+ (void)requestCycleDataWithFinishBlock:(void (^)(NSArray * _Nonnull))finishBlock {
    [[YQNetworkManager shareInstance] GET:@"http://www.douyutv.com/api/v1/slide/6" params:@{@"version" : @"2.300"} progress:nil sucess:^(id  _Nonnull responseObject) {
        if (![self isValidForRequestDada:responseObject]) {
            YQLog(@"请求轮播数据为空");
        }else {
            NSArray * datas = responseObject[@"data"];
            NSMutableArray * cycleModalArray = [NSMutableArray arrayWithCapacity:datas.count];
            for (NSDictionary *dict in datas) {
                [cycleModalArray addObject:[YQCycleModal cycleModalWithDictionary:dict]];
            }
            finishBlock(cycleModalArray);
        }
    } failure:^(NSError * _Nonnull error) {
        YQLog(@"请求轮播数据失败 -- %@", error);
    }];
}

+ (BOOL)isValidForRequestDada: (id)responseObject {
    if (!responseObject || !responseObject[@"data"]) return NO;
    NSArray *responseArray = responseObject[@"data"];
    if (responseArray.count == 0) return NO;
    return YES;
}

@end
