//
//  YQRecommentHeaderGameView.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2020/1/4.
//  Copyright © 2020 杨乾. All rights reserved.
//

#import "YQRecommentHeaderGameView.h"
#import "YQRecommentGameViewCell.h"
#import "YQAnchorGroup.h"

static NSString * recommentGameIdentifier = @"recommentGameIdentifier";

@interface YQRecommentHeaderGameView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation YQRecommentHeaderGameView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"YQRecommentGameViewCell" bundle:nil] forCellWithReuseIdentifier:recommentGameIdentifier];
}

- (void)layoutSubviews {
    UICollectionViewFlowLayout * flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    flowLayout.itemSize = CGSizeMake(80, 90);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
}

+ (instancetype)recommentHeaderGameView {
    return [[[NSBundle mainBundle] loadNibNamed:@"YQRecommentHeaderGameView" owner:nil options:nil] firstObject];
}

- (void)setAnchorGroups:(NSMutableArray *)anchorGroups {
    _anchorGroups = anchorGroups;
    [_anchorGroups removeObjectAtIndex:0];
    [_anchorGroups removeObjectAtIndex:0];
    
    YQAnchorGroup * anchorGroup = [[YQAnchorGroup alloc] init];
    anchorGroup.tag_name = @"更多";
    [_anchorGroups addObject:anchorGroup];
    
    [self.collectionView reloadData];
}

#pragma mark --UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.anchorGroups.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YQRecommentGameViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:recommentGameIdentifier forIndexPath:indexPath];
    cell.anchorGroup = self.anchorGroups[indexPath.item];
    return cell;
}

@end
