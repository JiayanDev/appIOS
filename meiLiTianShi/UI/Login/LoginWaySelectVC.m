//
//  LoginWaySelectVC.m
//  meiLiTianShi
//
//  Created by zcw on 15/7/28.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "LoginWaySelectVC.h"
#import "PhoneLoginVC.h"
#import "PhoneBindVC.h"

@interface LoginWaySelectVC ()
@property (weak, nonatomic) IBOutlet UIButton *wxLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *otherLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation LoginWaySelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(cancel)];
}

-(void)cancel{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)otherLoginPress:(id)sender {
    [self.navigationController pushViewController:[[PhoneLoginVC alloc] init]
                                         animated:YES];
}
- (IBAction)registButtonPress:(id)sender {
    PhoneBindVC *vc= [[PhoneBindVC alloc] init];
    vc.type=PhoneBindVcType_registerFirstStep;
    [self.navigationController pushViewController:vc
                                         animated:YES];
}


@end
