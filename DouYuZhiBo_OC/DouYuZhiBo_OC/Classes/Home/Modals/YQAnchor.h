//
//  YQAnchor.h
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/12/15.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YQAnchor : NSObject

/// 房间ID
@property(nonatomic, assign) NSInteger room_id;
/// 房间图片对应的URLString
@property(nonatomic, strong) NSString * vertical_src;
/// 判断是手机直播还是电脑直播
// 0 : 电脑直播(普通房间) 1 : 手机直播(秀场房间)
@property(nonatomic, assign) NSInteger isVertical;
/// 房间名称
@property(nonatomic, strong) NSString * room_name;
/// 主播昵称
@property(nonatomic, strong) NSString * nickname;
/// 观看人数
@property(nonatomic, assign) NSInteger online;
/// 所在城市
@property(nonatomic, strong) NSString * anchor_city;

+ (instancetype)anchorWithDict: (NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
