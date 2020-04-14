//
//  YQCollectionHeaderView.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/11/23.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import "YQCollectionHeaderView.h"
#import <SDWebImage.h>

@interface YQCollectionHeaderView()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *headerNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;


@end

@implementation YQCollectionHeaderView

+ (instancetype)createCollectionHeaderView {
    return [[[NSBundle mainBundle] loadNibNamed:@"YQCollectionHeaderView" owner:nil options:nil] firstObject];
}

- (void)setAnchorGroup:(YQAnchorGroup *)anchorGroup {
    _anchorGroup = anchorGroup;
    
    self.headerNameLabel.text = anchorGroup.tag_name;
    if (anchorGroup.small_icon_url) {
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:anchorGroup.small_icon_url]];
    } else {
        self.headerImageView.image = [UIImage imageNamed:anchorGroup.icon_name];
    }
    
    self.moreBtn.hidden = anchorGroup.isMoreBtnShow;
}
@end
