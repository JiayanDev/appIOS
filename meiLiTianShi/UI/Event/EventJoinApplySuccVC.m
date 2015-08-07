//
//  EventJoinApplySuccVC.m
//  meiLiTianShi
//
//  Created by zcw on 15/8/7.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "EventJoinApplySuccVC.h"
#import "EventDetailVC.h"

@interface EventJoinApplySuccVC ()

@end

@implementation EventJoinApplySuccVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goBack:(id)sender {
    for (UIViewController *one in [[self.navigationController viewControllers] reverseObjectEnumerator]) {
        if ([one isKindOfClass:[EventDetailVC class]]) {
            [self.navigationController popToViewController:one animated:YES];
            break;
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
