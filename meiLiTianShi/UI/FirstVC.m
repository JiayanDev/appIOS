//
//  FirstVC.m
//  meiLiTianShi
//
//  Created by zcw on 15/7/3.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "FirstVC.h"
#import "MLSession.h"
#import "AppDelegate.h"
#import "TSMessage.h"
#import "TopicListVC.h"
#import "MyIndexVC.h"
#import "EventListTVC.h"
#import "IndexTVC.h"
#import "PhoneBindFVC.h"
#import "PhoneRegisterSecondStepFVC.h"
#import "EventJoinApplyVC.h"
#import "EventJoinApplyFVC.h"
#import "TimeLineVCB.h"
#import "EventRatingFVC.h"
#import "CreateDiaryFVC.h"
#import "UIViewController+requireLogin.h"
#import "MLWebRedirectPusher.h"

@interface FirstVC ()

@end

@implementation FirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[MLSession current] restoreLoginOrAppinit_Success:^{
        [self gotoMainInterface];
    }                                             fail:^(NSInteger i, id o) {
        [TSMessage showNotificationWithTitle:@"出错了"
                                    subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
                                        type:TSMessageNotificationTypeError];
    }];
}

-(void)gotoMainInterface{
    UITabBarController* tabBarController = [[UITabBarController alloc] init];
    //tabBarController.delegate = self;
    UINavigationController* vc1=[[UINavigationController alloc]
            initWithRootViewController:[[IndexTVC alloc]init]];
    vc1.title=@"伴美";

    UINavigationController *vc2= [[UINavigationController alloc] initWithRootViewController:
            [[TopicListVC alloc] initWithStyle:UITableViewStyleGrouped]];
    vc2.title=@"发现";

    UINavigationController *vc3= [[UINavigationController alloc] initWithRootViewController:
            [[CreateDiaryFVC alloc]init]];
    vc3.title=@"活动";

    UINavigationController *vc4= [[UINavigationController alloc] initWithRootViewController:
            [[MyIndexVC alloc] init]];
    vc4.title=@"我的";

//
//    //[vc1.tabBarController.tabBarItem setImage:[SYLSession imageWithColor:UIColorFromRGB(0xcccccc)]];
//    [vc2.tabBarController.tabBarItem setImage:[SYLSession imageWithColor:UIColorFromRGB(0x777777)]];


    tabBarController.viewControllers = @[vc1,vc2,vc4];
    tabBarController.tabBar.tintColor=THEME_COLOR;
    vc1.tabBarItem= [[UITabBarItem alloc] initWithTitle:@"伴美"
                                                  image:[[UIImage imageNamed:@"home－灰.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                          selectedImage:[[UIImage imageNamed:@"首页－亮.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    vc2.tabBarItem= [[UITabBarItem alloc] initWithTitle:@"发现"
                                                  image:[[UIImage imageNamed:@"发现－灰.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                          selectedImage:[[UIImage imageNamed:@"发现－亮.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    vc3.tabBarItem= [[UITabBarItem alloc] initWithTitle:@"活动"
//                                                  image:[UIImage imageNamed:@"black.png"]
//                                          selectedImage:[UIImage imageNamed:@"blue.png"]];
    vc4.tabBarItem= [[UITabBarItem alloc] initWithTitle:@"我的"
                                                  image:[[UIImage imageNamed:@"我的－灰.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                          selectedImage:[[UIImage imageNamed:@"我的－亮.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

    AppDelegate *testAppDelegate = [UIApplication sharedApplication].delegate;




    testAppDelegate.window.rootViewController = tabBarController;
    [[NSURLCache sharedURLCache] removeAllCachedResponses];

    if(self.appLanuchOptions && self.appLanuchOptions[UIApplicationLaunchOptionsRemoteNotificationKey]){
        [MLWebRedirectPusher pushWithNotificationData:self.appLanuchOptions[UIApplicationLaunchOptionsRemoteNotificationKey] viewController:[UIViewController currentViewController]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
