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
            [[TopicListVC alloc]init]];
    vc2.title=@"发现";

    UINavigationController *vc3= [[UINavigationController alloc] initWithRootViewController:
            [[PhoneBindFVC alloc]init]];
    vc3.title=@"活动";

    UINavigationController *vc4= [[UINavigationController alloc] initWithRootViewController:
            [[MyIndexVC alloc] init]];
    vc4.title=@"我的";

//
//    //[vc1.tabBarController.tabBarItem setImage:[SYLSession imageWithColor:UIColorFromRGB(0xcccccc)]];
//    [vc2.tabBarController.tabBarItem setImage:[SYLSession imageWithColor:UIColorFromRGB(0x777777)]];


    tabBarController.viewControllers = @[vc1,vc2,vc3,vc4];
    vc1.tabBarItem= [[UITabBarItem alloc] initWithTitle:@"伴美"
                                                  image:[UIImage imageNamed:@"black.png"]
                                          selectedImage:[UIImage imageNamed:@"blue.png"]];
    vc2.tabBarItem= [[UITabBarItem alloc] initWithTitle:@"发现"
                                                  image:[UIImage imageNamed:@"black.png"]
                                          selectedImage:[UIImage imageNamed:@"blue.png"]];
    vc3.tabBarItem= [[UITabBarItem alloc] initWithTitle:@"活动"
                                                  image:[UIImage imageNamed:@"black.png"]
                                          selectedImage:[UIImage imageNamed:@"blue.png"]];
    vc4.tabBarItem= [[UITabBarItem alloc] initWithTitle:@"我的"
                                                  image:[UIImage imageNamed:@"black.png"]
                                          selectedImage:[UIImage imageNamed:@"blue.png"]];

    AppDelegate *testAppDelegate = [UIApplication sharedApplication].delegate;




    testAppDelegate.window.rootViewController = tabBarController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
