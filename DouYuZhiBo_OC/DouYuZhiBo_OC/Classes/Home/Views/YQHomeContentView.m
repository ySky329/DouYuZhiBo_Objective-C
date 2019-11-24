//
//  YQHomeContentView.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/11/9.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import "YQHomeContentView.h"


static NSString * kCollectionIdentifier = @"kCollectionIdentifier";

@interface YQHomeContentView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic,strong) NSArray *childControllArray;
@property (nonatomic, strong) UICollectionView * collectionView;

@end


@implementation YQHomeContentView

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCollectionIdentifier];
    }
    return _collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame childControlls:(nonnull NSArray<UIViewController *> *)childControlls parentViewController:(nonnull UIViewController *)parent{
    if (self = [super initWithFrame:frame]) {
        self.childControllArray = childControlls;
        for (UIViewController * vc in childControlls) {
            vc.view.backgroundColor = [UIColor randomColor];
            [parent addChildViewController:vc];
        }
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    // 设置 collectionView
    [self addSubview:self.collectionView];
    
}

- (void)selectedTopViewWithLabelTab:(NSInteger)tag {
    // 滚动到指定的 item: 两种方法
    // 方式一:
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:tag inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
    // 方式二:
//    [self.collectionView setContentOffset:CGPointMake(tag * self.collectionView.bounds.size.width, 0) animated:YES];
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.childControllArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionIdentifier forIndexPath:indexPath];
    
    for (UIView * view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    UIViewController * vc = self.childControllArray[indexPath.item];
    vc.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:vc.view];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    if ([self.delegate respondsToSelector:@selector(homeContentView:scrollOffsetX:)]) {
        [self.delegate homeContentView:self scrollOffsetX:offsetX];
    }
}

@end
