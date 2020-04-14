//
//  YQCollectionBaseCell.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/12/15.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import "YQCollectionBaseCell.h"
#import <SDWebImage.h>

@interface YQCollectionBaseCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIButton *onlineBtn;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;

@end

@implementation YQCollectionBaseCell

- (void)setAnchor:(YQAnchor *)anchor {
    _anchor = anchor;
    
    self.nickNameLabel.text = anchor.nickname;
    if (anchor.online > 10000) {
        NSInteger onlineNum = anchor.online / 10000;
        [self.onlineBtn setTitle:[NSString stringWithFormat:@"%ld万人在线", onlineNum] forState:UIControlStateNormal];
    } else {
        [self.onlineBtn setTitle:[NSString stringWithFormat:@"%ld人在线", anchor.online] forState:UIControlStateNormal];
    }
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:anchor.vertical_src]];

}

@end
