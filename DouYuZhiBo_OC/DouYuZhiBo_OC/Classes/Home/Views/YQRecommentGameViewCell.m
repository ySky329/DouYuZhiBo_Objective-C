//
//  YQRecommentGameViewCell.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2020/1/4.
//  Copyright © 2020 杨乾. All rights reserved.
//

#import "YQRecommentGameViewCell.h"
#import <SDWebImage.h>

@interface YQRecommentGameViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation YQRecommentGameViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.imageView.layer.cornerRadius = 22.5;
    self.imageView.layer.masksToBounds = YES;
    
    self.layer.masksToBounds = NO;
}

- (void)setAnchorGroup:(YQAnchorBaseModal *)anchorGroup {
    _anchorGroup = anchorGroup;
    self.titleLabel.text = anchorGroup.tag_name;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:anchorGroup.icon_url] placeholderImage:[UIImage imageNamed:@"home_more_btn"]];
}

@end
