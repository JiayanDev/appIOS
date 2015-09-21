//
// Created by zcw on 15/9/16.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIViewController (requireLogin)
+ (UIViewController *)currentViewController;

- (void)requireLogin;
@end