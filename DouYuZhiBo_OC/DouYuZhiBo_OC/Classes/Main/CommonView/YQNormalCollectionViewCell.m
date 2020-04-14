//
//  YQNormalCollectionViewCell.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/11/23.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import "YQNormalCollectionViewCell.h"

@interface YQNormalCollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *roomNameLabel;


@end

@implementation YQNormalCollectionViewCell

- (void)setAnchor:(YQAnchor *)anchor {
    [super setAnchor:anchor];
    self.roomNameLabel.text = anchor.room_name;
}

@end
