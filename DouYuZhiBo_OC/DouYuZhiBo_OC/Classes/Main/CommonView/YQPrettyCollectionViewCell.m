//
//  YQPrettyCollectionViewCell.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/11/23.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import "YQPrettyCollectionViewCell.h"

@interface YQPrettyCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIButton *cityBtn;

@end

@implementation YQPrettyCollectionViewCell

- (void)setAnchor:(YQAnchor *)anchor {
    [super setAnchor:anchor];
    [self.cityBtn setTitle:anchor.anchor_city forState:UIControlStateNormal];
}

@end
