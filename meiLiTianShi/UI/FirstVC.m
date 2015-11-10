//
//  FirstVC.m
//  meiLiTianShi
//
//  Created by zcw on 15/7/3.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
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
#import "MLWebViewWithCommentTextBarViewController.h"
#import "NSString+MD5.h"

@interface FirstVC ()

@end

@implementation FirstVC
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


- (void)loadView {
    [super loadView];
    CGFloat h=SCREEN_HEIGHT;
    CGFloat t=133;
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")){
        t = 210;
    } else {
        if (h > 720) {
            t = 210;
        } else if (h > 560) {
            t = 171;
        }
    }

    self.view.backgroundColor=[UIColor whiteColor];
    self.logo=[UIImageView new];
    self.logo.image=[UIImage imageNamed:@"lanuch_logo.png"];
    [self.view addSubview:self.logo];
    [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo([UIImage imageNamed:@"lanuch_logo.png"].size);
        make.top.equalTo(self.view).offset(t);
    }];


    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:spinner];
    [spinner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30,30));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.logo.mas_bottom).offset(30);
    }];

    [spinner startAnimating];

}


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
            [[MLWebViewWithCommentTextBarViewController alloc]init]];
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

//    tabBarController.selectedViewController=vc2;
    AppDelegate *testAppDelegate = [UIApplication sharedApplication].delegate;




    testAppDelegate.window.rootViewController = tabBarController;
    [[NSURLCache sharedURLCache] removeAllCachedResponses];

    if(self.appLanuchOptions && self.appLanuchOptions[UIApplicationLaunchOptionsRemoteNotificationKey]){
        [MLWebRedirectPusher pushWithNotificationData:self.appLanuchOptions[UIApplicationLaunchOptionsRemoteNotificationKey] viewController:[UIViewController currentViewController]];
    }

    NSLog(@"MD5:%@", [@"jiayan123aaabbb" MD5String]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
