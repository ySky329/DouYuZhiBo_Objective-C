//
//  YQAnchorGroup.h
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/12/15.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YQAnchor.h"
#import "YQAnchorBaseModal.h"

NS_ASSUME_NONNULL_BEGIN

@interface YQAnchorGroup : YQAnchorBaseModal

@property(nonatomic, strong) NSString * small_icon_url;
@property(nonatomic, strong) NSString * icon_name;
@property(nonatomic, strong) NSArray * room_list;
@property(nonatomic, strong) NSMutableArray<YQAnchor *> * anchors;
@property(nonatomic, assign) BOOL isMoreBtnShow;

@end

NS_ASSUME_NONNULL_END
