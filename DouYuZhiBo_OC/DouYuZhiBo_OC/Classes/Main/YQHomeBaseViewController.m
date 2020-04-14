//
//  YQHomeBaseViewController.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2020/2/10.
//  Copyright © 2020 杨乾. All rights reserved.
//

#import "YQHomeBaseViewController.h"
#import "YQNormalCollectionViewCell.h"
#import "YQPrettyCollectionViewCell.h"
#import "YQAnchorGroup.h"
#import "YQCollectionHeaderView.h"
#import "YQRoomPushViewController.h"
#import "YQRoomPresentViewController.h"


static NSString *collectionViewHeaderIndentifier = @"collectionViewHeaderIndentifier";


@interface YQHomeBaseViewController ()<UICollectionViewDelegate>


@end

@implementation YQHomeBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self loadData];
}

- (void)setupUI {
    [self.view addSubview:self.collectionView];
    self.collectionView.hidden = YES;
}

- (void)loadData {
    
}

#pragma mark --懒加载
- (NSArray *)anchorGroupArray {
    if (!_anchorGroupArray) {
        _anchorGroupArray = [NSArray array];
    }
    return _anchorGroupArray;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(ITEM_WIDTH, NORMAL_HEIGHT);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = MARGIN;
        flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, COLLECTIONVIEW_HEADER_HEIGHT);
        
        flowLayout.sectionInset = UIEdgeInsetsMake(0, MARGIN, 0, MARGIN);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        
        [_collectionView registerNib:[UINib nibWithNibName:@"YQNormalCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:normalColletionViewCellIdentifier];
        [_collectionView registerNib:[UINib nibWithNibName:@"YQPrettyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:prettyColletionViewCellIdentifier];
        [_collectionView registerNib:[UINib nibWithNibName:@"YQCollectionHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionViewHeaderIndentifier];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
         // 设置UICollectionView 随着父控件的拉伸而拉伸, 随着父控件的缩小而缩小
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _collectionView;
}

#pragma mark --UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.anchorGroupArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    YQAnchorGroup * group = self.anchorGroupArray[section];
    return group.anchors.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YQAnchorGroup * group = self.anchorGroupArray[indexPath.section];
    YQCollectionBaseCell * cell = nil;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:normalColletionViewCellIdentifier forIndexPath:indexPath];
    
    cell.anchor = group.anchors[indexPath.item];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    YQCollectionHeaderView * reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:collectionViewHeaderIndentifier forIndexPath:indexPath];
    reusableView.anchorGroup = self.anchorGroupArray[indexPath.section];
    return reusableView;
}

#pragma mark ----UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    YQAnchorGroup * group = self.anchorGroupArray[indexPath.section];
    NSInteger isVertical = group.anchors[indexPath.item].isVertical;
    
    if (isVertical == 0) {
        [self.navigationController pushViewController:[[YQRoomPushViewController alloc] init] animated:YES];
    } else {
        YQRoomPresentViewController * presentVc = [[YQRoomPresentViewController alloc] init];
        presentVc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:presentVc animated:YES completion:nil];
    }
}

@end
