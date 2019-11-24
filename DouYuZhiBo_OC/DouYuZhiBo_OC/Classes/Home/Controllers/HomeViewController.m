//
//  HomeViewController.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2019/11/3.
//  Copyright © 2019 杨乾. All rights reserved.
//

#import "HomeViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "YQHomeTopView.h"
#import "YQHomeContentView.h"
#import "YQRecommentViewController.h"
#import "YQGameViewController.h"
#import "YQAmusementViewController.h"
#import "YQFunnyViewController.h"


#define TOPVIEW_HEIGHT 44

@interface HomeViewController ()<YQHomeTopViewDelegate, YQHomeContentViewDelegate>

@property (nonatomic, weak) YQHomeContentView * contentView;
@property (nonatomic, weak) YQHomeTopView * topView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (void)setupUI {
    [self setNavigationItem];
    NSArray * titles = @[@"推荐",@"游戏",@"娱乐",@"趣玩"];
    [self.view addSubview:({
        YQHomeTopView * topView = [[YQHomeTopView alloc] initWithFrame:CGRectMake(0, STATUSBAR_HEIGHT + NAVIGATION_HEIGHT, SCREEN_WIDTH, TOPVIEW_HEIGHT) titles:titles];
        topView.delegate = self;
        self.topView = topView;
        topView;
    })];
    
    [self.view addSubview:({
        CGFloat contentViewY = STATUSBAR_HEIGHT + NAVIGATION_HEIGHT + TOPVIEW_HEIGHT;
        
        YQHomeContentView * contentView = [[YQHomeContentView alloc] initWithFrame:CGRectMake(0, contentViewY, SCREEN_WIDTH, SCREEN_HEIGHT - contentViewY - TABBAR_HEIGHT - BOTTOM_SAFE_AREA_HEIHGT) childControlls:@[[YQRecommentViewController new], [YQGameViewController new], [YQAmusementViewController new], [YQFunnyViewController new]] parentViewController:self];
        contentView.backgroundColor = [UIColor purpleColor];
        
        self.contentView = contentView;
        self.contentView.delegate = self;
        contentView;
    })];
}

- (void) setNavigationItem {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonWithImage:@"logo" highlightedImage:nil size:CGSizeZero];
    
    CGSize size = CGSizeMake(40, 40);
    UIBarButtonItem * qrcodeItem = [UIBarButtonItem barButtonWithImage:@"Image_scan" highlightedImage:@"Image_scan_click" size:size];
    UIBarButtonItem * searchItem = [UIBarButtonItem barButtonWithImage:@"btn_search" highlightedImage:@"btn_search_clicked" size:size];
    UIBarButtonItem * historyItem = [UIBarButtonItem barButtonWithImage:@"image_my_history" highlightedImage:@"Image_history" size:size];
    
    self.navigationItem.rightBarButtonItems = @[qrcodeItem,searchItem,historyItem];
}

#pragma mark --YQHomeTopViewDelegate
- (void)homeTopView:(YQHomeTopView *)topView didTapLabelTag:(NSInteger)tag {
    [self.contentView selectedTopViewWithLabelTab:tag];
}

#pragma mark --YQHomeContentViewDelegate
- (void)homeContentView:(YQHomeContentView *)contentView scrollOffsetX:(CGFloat)offsetX {
    [self.topView contentViewScrollOffsetY:offsetX];
}

@end
