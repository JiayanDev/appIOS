//
// Created by zcw on 15/8/17.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MLStyleManager : NSObject
+ (void)styleSetsWhenFinishiLaunching;

+ (void)styleSetsWhenFinishiLaunchingWithWindow:(UIWindow *)window;

+ (void)styleTheNavigationBar:(UINavigationBar *)navigationBar;

+ (void)removeBackTextForNextScene:(UIViewController *)viewController;
@end