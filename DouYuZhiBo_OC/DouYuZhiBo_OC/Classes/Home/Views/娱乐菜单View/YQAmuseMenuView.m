//
//  YQAmuseMenuView.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2020/2/11.
//  Copyright © 2020 杨乾. All rights reserved.
//

#import "YQAmuseMenuView.h"
#import "YQAmuseMenuViewCell.h"

static NSString * kAmuseMenuViewCellIdetifier = @"kAmuseMenuViewCellIdetifier";

@interface YQAmuseMenuView()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation YQAmuseMenuView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 取消自动布局, 不让其随着父控制的拉伸而拉伸...
    self.autoresizingMask = UIViewAutoresizingNone;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"YQAmuseMenuViewCell" bundle:nil] forCellWithReuseIdentifier:kAmuseMenuViewCellIdetifier];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UICollectionViewFlowLayout * flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    flowLayout.itemSize = self.collectionView.bounds.size;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

+ (instancetype)creatAmuseMenuView {
    return [[[NSBundle mainBundle] loadNibNamed:@"YQAmuseMenuView" owner:nil options:nil] lastObject];
}

- (void)setMenusArray:(NSArray *)menusArray {
    _menusArray = menusArray;
    [self.collectionView reloadData];
    
    self.pageControl.numberOfPages = (self.menusArray.count - 1) / 8 + 1;
}

#pragma mark --UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger pageNum = (self.menusArray.count - 1) / 8 + 1;
    return pageNum;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YQAmuseMenuViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAmuseMenuViewCellIdetifier forIndexPath:indexPath];
    
    // 1 8 16
    NSInteger startIndex = indexPath.item * 8;
    NSInteger endIndex = (indexPath.item + 1) * 8;
    if (endIndex > self.menusArray.count) {
        endIndex = self.menusArray.count;
    }
    cell.anchorArray = [self.menusArray subarrayWithRange:NSMakeRange(startIndex, (endIndex - startIndex))];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.pageControl.currentPage = scrollView.contentOffset.x / SCREEN_WIDTH + 0.5;
}
@end
