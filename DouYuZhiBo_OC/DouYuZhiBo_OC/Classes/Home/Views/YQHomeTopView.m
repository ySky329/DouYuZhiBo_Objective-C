//
//  YQHomeTopView.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/11/9.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import "YQHomeTopView.h"

@interface YQHomeTopView()

@property (nonatomic, strong) NSArray * titleArray;
@property (nonatomic, strong) NSMutableArray * titleLabelArray;
@property (nonatomic, assign) NSInteger lastLabelTag;
@property (nonatomic, weak) UIView * orangeLineView;

@end

@implementation YQHomeTopView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles {
    if (self = [super initWithFrame:frame]) {
        self.titleArray = titles;
        [self setupUI];
    }
    return self;
}

- (NSMutableArray *)titleLabelArray {
    if (!_titleLabelArray) {
        _titleLabelArray = [NSMutableArray arrayWithCapacity:_titleArray.count];
    }
    return _titleLabelArray;
}

- (void) setupUI {
    
    CGFloat labelWidth = self.bounds.size.width / 4;
    CGFloat viewHeight = self.bounds.size.height;

    // 设置 scrollView
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    scrollView.contentSize = CGSizeMake(labelWidth * _titleArray.count, viewHeight);
    scrollView.bounces = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrollView];
    
    // 设置 Labels
    for (NSInteger i=0,len=_titleArray.count; i<len; i++) {
        CGFloat labelX = i * labelWidth;
        [scrollView addSubview:({
            UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, 0, labelWidth, viewHeight - 2)];
            titleLabel.text = _titleArray[i];
            titleLabel.textColor = [UIColor darkGrayColor];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = [UIFont systemFontOfSize:17];
            titleLabel.tag = i;
            
            titleLabel.userInteractionEnabled = YES;
            UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTabGestureMethod:)];
            [titleLabel addGestureRecognizer:tapGesture];
            
            if (i == 0) {
                titleLabel.textColor = [UIColor orangeColor];
                titleLabel.font = [UIFont systemFontOfSize:18];
                self.lastLabelTag = i;
            }
            
            [self.titleLabelArray addObject:titleLabel];
            
            titleLabel;
        })];
    }
    
    // 设置 浮标 和 横线
    [self addSubview:({
        UIView * bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, viewHeight - 0.5, self.bounds.size.width, 0.5)];
        bottomLine.backgroundColor = [UIColor lightGrayColor];
        bottomLine;
    })];
    
    UIView * orangeLineView = [[UIView alloc] initWithFrame:CGRectMake(0, viewHeight - 2, labelWidth, 2)];
    orangeLineView.backgroundColor = [UIColor orangeColor];
    [scrollView addSubview:orangeLineView];
    
    self.orangeLineView = orangeLineView;
}


- (void)labelTabGestureMethod: (UIGestureRecognizer *)gesture {
    NSInteger tag = gesture.view.tag;
    CGFloat labelWidth = self.orangeLineView.bounds.size.width;
    
    [self changeLabelStateWithIndex:tag];
    [UIView animateWithDuration:0.5 animations:^{
        self.orangeLineView.frame = CGRectMake(labelWidth * tag, self.bounds.size.height - 2, labelWidth, 2);
    }];
    
    if ([self.delegate respondsToSelector:@selector(homeTopView:didTapLabelTag:)]) {
        [self.delegate homeTopView:self didTapLabelTag:tag];
    }
}

- (void)contentViewScrollOffsetY:(CGFloat)offsetX {
    CGFloat lineWidth = self.orangeLineView.bounds.size.width;
    CGFloat diffScale = lineWidth / SCREEN_WIDTH;
    CGFloat scrollOffset = diffScale * offsetX;
    self.orangeLineView.frame = CGRectMake(scrollOffset, self.bounds.size.height - 2, lineWidth, 2);
    
    NSInteger index = floor(offsetX / SCREEN_WIDTH + 0.5);
    [self changeLabelStateWithIndex:index];
}

- (void)changeLabelStateWithIndex: (NSInteger)index {
    if (self.lastLabelTag == index) {
        return;
    }
    
    UILabel * titleLabel = self.titleLabelArray[index];
    UILabel * lastTitleLabel = self.titleLabelArray[self.lastLabelTag];
    
    titleLabel.textColor = [UIColor orangeColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    
    lastTitleLabel.textColor = [UIColor darkGrayColor];
    lastTitleLabel.font = [UIFont systemFontOfSize:17];
    
    self.lastLabelTag = index;
}

@end
