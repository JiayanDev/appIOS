//
// Created by zcw on 15/8/12.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MLWebRedirectPusher : NSObject
+ (BOOL)pushWithUrl:(NSURL *)url viewController:(UIViewController *)vc;
@end