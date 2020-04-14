//
//  YQCycleModal.h
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2020/1/4.
//  Copyright © 2020 杨乾. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YQAnchor.h"

NS_ASSUME_NONNULL_BEGIN

@interface YQCycleModal : NSObject

@property(nonatomic, strong) NSString * title;
@property(nonatomic, strong) NSString * pic_url;
@property(nonatomic, strong) NSDictionary * room;
@property(nonatomic, strong) YQAnchor * anchor;

+ (instancetype)cycleModalWithDictionary: (NSDictionary *)dict;


@end

NS_ASSUME_NONNULL_END
