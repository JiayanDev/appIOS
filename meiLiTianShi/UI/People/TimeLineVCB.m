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
    [self.view addSubview:self.mainView];

}
- (void)viewDidLoad {
    
}
@end