//
//  AppDelegate.h
//  meiLiTianShi
//
//  Created by zcw on 15/7/1.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

