//
//  YQFunnyViewController.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/11/10.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import "YQFunnyViewController.h"
#import "YQFunnyViewModal.h"

@interface YQFunnyViewController ()

@end

@implementation YQFunnyViewController

- (void)loadData {
    [YQFunnyViewModal requestFunnyDataWithFinishedBlock:^(NSArray * _Nonnull resultArray) {
        self.anchorGroupArray = resultArray;
        [self.collectionView reloadData];
        
        [self stopAnimate];
        self.collectionView.hidden = NO;
    }];
}

@end
