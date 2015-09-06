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
    self.mainView.backgroundImageOrigin=[UIImage imageNamed:@"Y80Y09B4Y73E.jpg"];
    [self.view addSubview:self.mainView];

}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [self setNeedsStatusBarAppearanceUpdate];
//    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"timeline_分享.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                             style:UIBarButtonItemStylePlain target:self
                                                                            action:@selector(sharePress)];
}

-(void)sharePress{

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNeedsStatusBarAppearanceUpdate];
}
@end