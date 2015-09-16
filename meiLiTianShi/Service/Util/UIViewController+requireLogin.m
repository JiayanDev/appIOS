//
// Created by zcw on 15/9/16.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "UIViewController+requireLogin.h"
#import "LoginWaySelectVC.h"


@implementation UIViewController (requireLogin)
-(void)requireLogin{
    LoginWaySelectVC *vc= [[LoginWaySelectVC alloc] init];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc]
                       animated:YES
                     completion:^{

                     }];
}
@end