//
//  YQHomeAnimateViewController.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2020/2/15.
//  Copyright © 2020 杨乾. All rights reserved.
//

#import "YQHomeAnimateViewController.h"
#import "UIColor+YQExtension.h"

@interface YQHomeAnimateViewController ()

@end

@implementation YQHomeAnimateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:250 andGreen:250 andBlue:250 andAlpha:1];
    [self.view addSubview:self.imageView];
    [self.imageView startAnimating];
}

#pragma mark --懒加载
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image_loading_player01"]];
        _imageView.center = self.view.center;
        [_imageView sizeToFit];
        
        NSMutableArray *imagesArr = [NSMutableArray array];
        for (int i=1; i<=4; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"image_loading_player0%d", i]];
            [imagesArr addObject:image];
        }
        _imageView.animationImages = imagesArr;
        _imageView.animationDuration = 0.5;
        _imageView.animationRepeatCount = 0;
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    }
    return _imageView;
}

- (void)stopAnimate {
    [self.imageView stopAnimating];
    [self.imageView removeFromSuperview];
}

@end
