//
//  YQRecommentViewController.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/11/10.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import "YQRecommentViewController.h"
#import "YQRecommentViewModal.h"
#import "YQAnchor.h"
#import "YQAnchorGroup.h"
#import "YQCollectionHeaderView.h"
#import "YQCollectionBaseCell.h"
#import "YQRecommentCycleView.h"
#import "YQCycleModal.h"
#import "YQRecommentHeaderGameView.h"
#import "YQHeaderGameDataModalSingle.h"


#define CYCLEVIEW_HEIGHT SCREEN_WIDTH * 3 / 8


@interface YQRecommentViewController ()<UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) YQRecommentCycleView * cycleView;
@property(nonatomic, strong) YQRecommentHeaderGameView * headerGameView;

@end

@implementation YQRecommentViewController


- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.collectionView.contentInset = UIEdgeInsetsMake(CYCLEVIEW_HEIGHT + HEADERGAMEVIEW_HEIGHT, 0, 0, 0);
    [self.collectionView addSubview:self.cycleView];
    [self.collectionView addSubview:self.headerGameView];
    
}

- (void)loadData {
    [super loadData];
    [YQRecommentViewModal requestDataWithFinishBlock:^(NSArray * _Nonnull resultArr) {
        self.anchorGroupArray = resultArr;
        [self.collectionView reloadData];
        self.headerGameView.anchorGroups = [NSMutableArray arrayWithArray:resultArr];
        [YQHeaderGameDataModalSingle shareHeaderGameDataModal].anchorGroups = [NSMutableArray arrayWithArray:resultArr];
        
        [self stopAnimate];
        self.collectionView.hidden = NO;

    }];
    
    [YQRecommentViewModal requestCycleDataWithFinishBlock:^(NSArray * _Nonnull resultArray) {
        self.cycleView.cycleModals = resultArray;
    }];
}

#pragma mark --懒加载

- (YQRecommentCycleView *)cycleView {
    if (_cycleView == nil) {
        _cycleView = [YQRecommentCycleView recommentCycleView];
        _cycleView.frame = CGRectMake(0, -(CYCLEVIEW_HEIGHT + HEADERGAMEVIEW_HEIGHT), SCREEN_WIDTH, CYCLEVIEW_HEIGHT);
    }
    return _cycleView;
}

- (YQRecommentHeaderGameView *)headerGameView {
    if (_headerGameView == nil) {
        _headerGameView = [YQRecommentHeaderGameView recommentHeaderGameView];
        _headerGameView.frame = CGRectMake(0, -HEADERGAMEVIEW_HEIGHT, SCREEN_WIDTH, HEADERGAMEVIEW_HEIGHT);
    }
    return _headerGameView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YQAnchorGroup * group = self.anchorGroupArray[indexPath.section];
    YQCollectionBaseCell * cell = nil;
    
    if (indexPath.section == 1) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:prettyColletionViewCellIdentifier forIndexPath:indexPath];
    } else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:normalColletionViewCellIdentifier forIndexPath:indexPath];
    }
    
    cell.anchor = group.anchors[indexPath.item];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return CGSizeMake(ITEM_WIDTH, PERTTY_HEIGHT);
    }
    return CGSizeMake(ITEM_WIDTH, NORMAL_HEIGHT);
}

@end
