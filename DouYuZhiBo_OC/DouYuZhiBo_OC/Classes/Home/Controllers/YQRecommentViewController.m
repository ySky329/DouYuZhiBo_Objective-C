//
//  YQRecommentViewController.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/11/10.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import "YQRecommentViewController.h"
#import "YQCollectionHeaderView.h"
#import "YQNormalCollectionViewCell.h"
#import "YQPrettyCollectionViewCell.h"

#define MARGIN 10
#define ROW_NUM 2
#define ITEM_WIDTH (SCREEN_WIDTH - MARGIN * (ROW_NUM + 1)) / ROW_NUM
#define NORMAL_HEIGHT ITEM_WIDTH * 3 / 4
#define PERTTY_HEIGHT ITEM_WIDTH * 4 / 3
#define COLLECTIONVIEW_HEADER_HEIGHT 50

static NSString *normalColletionViewCellIdentifier = @"normalColletionViewCellIdentifier";
static NSString *prettyColletionViewCellIdentifier = @"prettyColletionViewCellIdentifier";
static NSString *collectionViewHeaderIndentifier = @"collectionViewHeaderIndentifier";

@interface YQRecommentViewController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property(nonatomic, strong) UICollectionView * collectionView;

@end

@implementation YQRecommentViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.collectionView];
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
    return 12;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 8;
    }
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell;
    if (indexPath.section == 1) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:prettyColletionViewCellIdentifier forIndexPath:indexPath];
    } else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:normalColletionViewCellIdentifier forIndexPath:indexPath];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView * reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:collectionViewHeaderIndentifier forIndexPath:indexPath];
    return reusableView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return CGSizeMake(ITEM_WIDTH, PERTTY_HEIGHT);
    }
    return CGSizeMake(ITEM_WIDTH, NORMAL_HEIGHT);
}

@end
