//
// Created by zcw on 15/9/15.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "UITabBarController+statusBar.h"


@implementation UITabBarController (statusBar)
-(UIStatusBarStyle)preferredStatusBarStyle{

    return self.selectedViewController.preferredStatusBarStyle;

}
@end