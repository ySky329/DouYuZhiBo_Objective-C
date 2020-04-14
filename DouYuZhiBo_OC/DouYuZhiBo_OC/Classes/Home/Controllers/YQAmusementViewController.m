//
//  YQAmusementViewController.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/11/10.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import "YQAmusementViewController.h"
#import "YQAmusementViewModal.h"
#import "YQAmuseMenuView.h"
#import "YQHeaderGameDataModalSingle.h"

#define AMUSEMENTHEADER_HEIGHT 200

@interface YQAmusementViewController ()

@property(nonatomic, strong) YQAmuseMenuView * menuView;

@end

@implementation YQAmusementViewController

- (void)loadData {
    [super loadData];
    [YQAmusementViewModal requestAmusementDataWithFinishedBlock:^(NSArray * _Nonnull resultArray) {
        self.anchorGroupArray = resultArray;
        [self.collectionView reloadData];
        
        [self stopAnimate];
        self.collectionView.hidden = NO;
    }];
}

- (void)setupUI {
    [super setupUI];
    self.collectionView.contentInset = UIEdgeInsetsMake(AMUSEMENTHEADER_HEIGHT, 0, 0, 0);
    [self.collectionView addSubview:self.menuView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.menuView.menusArray = [YQHeaderGameDataModalSingle shareHeaderGameDataModal].anchorGroups;
}

#pragma mark --懒加载
- (YQAmuseMenuView *)menuView {
    if (!_menuView) {
        _menuView = [YQAmuseMenuView creatAmuseMenuView];
        _menuView.frame = CGRectMake(0, -AMUSEMENTHEADER_HEIGHT, SCREEN_WIDTH, AMUSEMENTHEADER_HEIGHT);
    }
    return _menuView;
}
@end
