//
//  YQCycleViewCell.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2020/1/4.
//  Copyright © 2020 杨乾. All rights reserved.
//

#import "YQCycleViewCell.h"
#import <SDWebImage.h>

@interface YQCycleViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation YQCycleViewCell

- (void)setCycleModal:(YQCycleModal *)cycleModal {
    _cycleModal = cycleModal;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:cycleModal.pic_url] placeholderImage:[UIImage imageNamed:@"Img_default"]];
    self.titleLabel.text = cycleModal.title;
}
@end
