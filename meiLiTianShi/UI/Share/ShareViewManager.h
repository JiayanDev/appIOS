//
// Created by zcw on 15/8/22.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ShareViewManager : NSObject
+ (ShareViewManager *)showSharePanelOnto:(UIView *)view;

- (void)disappearAll;

- (void)showSharePanelOnto:(UIView *)view;
@end