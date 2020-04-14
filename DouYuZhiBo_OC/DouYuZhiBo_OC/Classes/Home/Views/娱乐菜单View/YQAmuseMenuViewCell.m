//
//  YQAmuseMenuViewCell.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2020/2/11.
//  Copyright © 2020 杨乾. All rights reserved.
//

#import "YQAmuseMenuViewCell.h"
#import "YQRecommentGameViewCell.h"

static NSString * kAmuseGameViewIdentifier = @"kAmuseGameViewIdentifier";

@interface YQAmuseMenuViewCell()<UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end

@implementation YQAmuseMenuViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 取消自动布局, 不让其随着父控制的拉伸而拉伸...
    self.autoresizingMask = UIViewAutoresizingNone;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"YQRecommentGameViewCell" bundle:nil] forCellWithReuseIdentifier:kAmuseGameViewIdentifier];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UICollectionViewFlowLayout * flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH / 4, self.bounds.size.height / 2);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
}

- (void)setAnchorArray:(NSArray<YQAnchorBaseModal *> *)anchorArray {
    _anchorArray = anchorArray;
    [self.collectionView reloadData];
}

#pragma mark --UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.anchorArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YQRecommentGameViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAmuseGameViewIdentifier forIndexPath:indexPath];
    
    cell.anchorGroup = self.anchorArray[indexPath.item];
    cell.layer.masksToBounds = YES;
    return cell;
}
@end
