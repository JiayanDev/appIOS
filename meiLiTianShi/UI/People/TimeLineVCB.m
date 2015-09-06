//
// Created by zcw on 15/9/6.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "TimeLineVCB.h"
#import "MLBlurImageHeaderedWebview.h"


@implementation TimeLineVCB {

}
- (void)loadView {
    [super loadView];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.mainView= [[MLBlurImageHeaderedWebview alloc] init];
    [self.mainView setupVC:self];
    [self.view addSubview:self.mainView];

}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNeedsStatusBarAppearanceUpdate];
}
@end