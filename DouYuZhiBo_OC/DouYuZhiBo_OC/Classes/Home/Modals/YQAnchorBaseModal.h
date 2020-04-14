//
//  YQAnchorBaseModal.h
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2020/2/8.
//  Copyright © 2020 杨乾. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YQAnchorBaseModal : NSObject

@property(nonatomic, strong) NSString * tag_name;
@property(nonatomic, strong) NSString * icon_url;

+ (instancetype)baseModalWithDictionary: (NSDictionary *) dict;

@end

NS_ASSUME_NONNULL_END
