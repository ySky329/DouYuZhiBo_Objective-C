//
//  YQHomeBaseViewController.h
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2020/2/10.
//  Copyright © 2020 杨乾. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQHomeAnimateViewController.h"

#define ROW_NUM 2
#define ITEM_WIDTH (SCREEN_WIDTH - MARGIN * (ROW_NUM + 1)) / ROW_NUM
#define NORMAL_HEIGHT ITEM_WIDTH * 3 / 4
#define PERTTY_HEIGHT ITEM_WIDTH * 4 / 3


NS_ASSUME_NONNULL_BEGIN

static NSString *normalColletionViewCellIdentifier = @"normalColletionViewCellIdentifier";
static NSString *prettyColletionViewCellIdentifier = @"prettyColletionViewCellIdentifier";

@interface YQHomeBaseViewController : YQHomeAnimateViewController<UICollectionViewDataSource>

@property(nonatomic, strong) UICollectionView * collectionView;
@property(nonatomic, strong) NSArray * anchorGroupArray;

- (void)loadData;
- (void)setupUI;
@end

NS_ASSUME_NONNULL_END
