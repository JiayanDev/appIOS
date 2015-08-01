//
//  ForgetPasswordSecondStepVC.m
//  meiLiTianShi
//
//  Created by zcw on 15/7/29.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <TSMessages/TSMessage.h>
#import "ForgetPasswordSecondStepVC.h"
#import "UIAlertView+Blocks.h"
#import "MLSession.h"

@interface ForgetPasswordSecondStepVC ()
@property (weak, nonatomic) IBOutlet UITextField *password1;
@property (weak, nonatomic) IBOutlet UITextField *password2;

@end

@implementation ForgetPasswordSecondStepVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"请输入新密码";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submitButtonPress:(id)sender {
    if(self.password1.text.length>0 &&self.password2.text.length>0 && [self.password2.text isEqualToString:self.password1.text]){
        [[MLSession current] forgetAndChangePasswordWithPhoneNum:self.phoneNum
                                                         receipt:self.receipt
                                                     rawPassword:self.password1.text
                                                         success:^{
                                                                     [UIAlertView showWithTitle:@"提示"
                                                                                        message:@"重置密码成功，请重新登录。"
                                                                              cancelButtonTitle:@"确定" otherButtonTitles:nil tapBlock:^(UIAlertView * alertView, NSInteger buttonIndex) {

                                                                                 [self.navigationController popToRootViewControllerAnimated:YES];
                                                                             }];

                                                         } fail:^(NSInteger i, id o) {
                    [TSMessage showNotificationInViewController:self.navigationController
                                                          title:@"出错了"
                                                       subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
                                                           type:TSMessageNotificationTypeError];
                }];
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
