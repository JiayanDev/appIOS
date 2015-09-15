//
// Created by zcw on 15/9/15.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "UINavigationController+statusBar.h"


@implementation UINavigationController (statusBar)
-(UIStatusBarStyle)preferredStatusBarStyle{

    return self.topViewController.preferredStatusBarStyle;

}
@end