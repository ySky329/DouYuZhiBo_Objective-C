//
//  YQGameViewController.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/11/10.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import "YQGameViewController.h"
#import "YQRecommentGameViewCell.h"
#import "YQGameViewModal.h"
#import "YQRecommentViewModal.h"
#import "YQCollectionHeaderView.h"
#import "YQAnchorGroup.h"
#import "YQRecommentHeaderGameView.h"
#import "YQHeaderGameDataModalSingle.h"

#define ITEM_WIDTH (SCREEN_WIDTH - 2 * MARGIN) / 3
#define ITEM_HEIGHT ITEM_WIDTH * 6 / 5

static NSString * kGameCollectionViewIdentifier = @"gameCollectionViewIdentifier";
static NSString * kGameCollectionHeaderViewIdentifier = @"kGameCollectionHeaderViewIdentifier";


@interface YQGameViewController ()<UICollectionViewDataSource>

@property(nonatomic, strong) UICollectionView * collectionView;
@property(nonatomic, strong) NSArray * gameArray;
@property(nonatomic, strong) YQCollectionHeaderView * gameTopView;
@property(nonatomic, strong) YQRecommentHeaderGameView * headerGameView;

@end

@implementation YQGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView addSubview:self.gameTopView];
    [self.collectionView addSubview:self.headerGameView];
    /*
    // 这个没有数据了
    [YQGameViewModal requstAllGameDataWithBlock:^(NSArray * _Nonnull resultArray) {
        self.gameArray = resultArray;
        [self.collectionView reloadData];
    }];
     */
    [YQRecommentViewModal requestDataWithFinishBlock:^(NSArray * _Nonnull resultArr) {
        self.gameArray = resultArr;
        [self.collectionView reloadData];
        
        [self stopAnimate];
        self.collectionView.hidden = NO;
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.headerGameView.anchorGroups = [YQHeaderGameDataModalSingle shareHeaderGameDataModal].anchorGroups;
}
#pragma mark --懒加载
- (YQCollectionHeaderView *)gameTopView {
    if (!_gameTopView) {
        _gameTopView = [YQCollectionHeaderView createCollectionHeaderView];
        _gameTopView.frame = CGRectMake(0, -(COLLECTIONVIEW_HEADER_HEIGHT + HEADERGAMEVIEW_HEIGHT), SCREEN_WIDTH, COLLECTIONVIEW_HEADER_HEIGHT);
        YQAnchorGroup * anchor = [[YQAnchorGroup alloc] init];
        anchor.tag_name = @"常用";
        anchor.icon_name = @"Img_orange";
        anchor.isMoreBtnShow = YES;
        _gameTopView.anchorGroup = anchor;
    }
    return _gameTopView;
}

- (YQRecommentHeaderGameView *)headerGameView {
    if (_headerGameView == nil) {
        _headerGameView = [YQRecommentHeaderGameView recommentHeaderGameView];
        _headerGameView.frame = CGRectMake(0, -HEADERGAMEVIEW_HEIGHT, SCREEN_WIDTH, HEADERGAMEVIEW_HEIGHT);
    }
    return _headerGameView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, MARGIN, 0, MARGIN);
        flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, COLLECTIONVIEW_HEADER_HEIGHT);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"YQRecommentGameViewCell" bundle:nil] forCellWithReuseIdentifier:kGameCollectionViewIdentifier];
        [_collectionView registerNib:[UINib nibWithNibName:@"YQCollectionHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kGameCollectionHeaderViewIdentifier];
        
        // 设置UICollectionView 随着父控件的拉伸而拉伸, 随着父控件的缩小而缩小
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        _collectionView.contentInset = UIEdgeInsetsMake(COLLECTIONVIEW_HEADER_HEIGHT + HEADERGAMEVIEW_HEIGHT, 0, 0, 0);
    }
    return _collectionView;
}

#pragma mark --UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.gameArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YQRecommentGameViewCell * gameCell = (YQRecommentGameViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kGameCollectionViewIdentifier forIndexPath:indexPath];
    gameCell.anchorGroup = self.gameArray[indexPath.item];
    return gameCell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    YQCollectionHeaderView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kGameCollectionHeaderViewIdentifier forIndexPath:indexPath];
    YQAnchorGroup * anchor = [[YQAnchorGroup alloc] init];
    anchor.tag_name = @"全部";
    anchor.icon_name = @"Img_orange";
    anchor.isMoreBtnShow = YES;
    headerView.anchorGroup = anchor;
    return headerView;
}
@end
