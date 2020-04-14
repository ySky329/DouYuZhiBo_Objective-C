//
//  YQRecommentCycleView.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/12/29.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import "YQRecommentCycleView.h"
#import "YQCycleModal.h"
#import "YQCycleViewCell.h"

static NSString *reuseIdetifier = @"reuseIdetifier";

@interface YQRecommentCycleView() <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property(nonatomic, strong) NSTimer * timer;

@end

@implementation YQRecommentCycleView

+ (instancetype)recommentCycleView {
    return [[[NSBundle mainBundle] loadNibNamed:@"YQRecommentCycleView" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
    [self.collectionView registerNib:[UINib nibWithNibName:@"YQCycleViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdetifier];
}

- (void)layoutSubviews {
    UICollectionViewFlowLayout * flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    flowLayout.itemSize = self.collectionView.bounds.size;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;    
}

- (void)setCycleModals:(NSArray *)cycleModals {
    _cycleModals = cycleModals;
    self.pageControl.numberOfPages = cycleModals.count;
    [self.collectionView reloadData];
    
    //添加定时器前先移除再添加
    [self removeCycleTimer];
    [self addCycleTimer];
}

#pragma mark --UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.cycleModals.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YQCycleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdetifier forIndexPath:indexPath];
    cell.cycleModal = self.cycleModals[indexPath.item];
    return cell;
}

#pragma mark --UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger scrollNum = scrollView.contentOffset.x / SCREEN_WIDTH + 0.5;
    self.pageControl.currentPage = scrollNum;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeCycleTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self addCycleTimer];
}

#pragma mark --定时器
- (void)addCycleTimer {
    self.timer = [NSTimer timerWithTimeInterval:2.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        CGFloat offsetX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width;
        if (offsetX >= self.cycleModals.count * self.collectionView.bounds.size.width) {
            offsetX = 0;
        }
        [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)removeCycleTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)dealloc {
    [self removeCycleTimer];
}
@end
