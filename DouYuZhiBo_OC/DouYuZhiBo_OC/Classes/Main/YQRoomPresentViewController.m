//
//  YQRoomPresentViewController.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2020/2/18.
//  Copyright © 2020 杨乾. All rights reserved.
//

#import "YQRoomPresentViewController.h"

@interface YQRoomPresentViewController ()

@end

@implementation YQRoomPresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    
    [self.view addSubview:({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.center = self.view.center;
        
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:25];
        [btn sizeToFit];
        [btn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        btn;
    })];
}

- (void)backAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
