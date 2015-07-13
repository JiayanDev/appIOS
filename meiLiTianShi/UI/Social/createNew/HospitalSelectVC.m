//
//  HospitalSelectVC.m
//  meiLiTianShi
//
//  Created by zcw on 15/7/13.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "HospitalSelectVC.h"

@interface HospitalSelectVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *onePixel;

@end

@implementation HospitalSelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.onePixel.constant = 1.f/[UIScreen mainScreen].scale;//enforces it to be a true 1 pixel line
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
