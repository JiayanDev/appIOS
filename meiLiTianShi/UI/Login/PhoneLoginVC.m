//
//  PhoneLoginVC.m
//  meiLiTianShi
//
//  Created by zcw on 15/7/29.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "PhoneLoginVC.h"
#import "RegExCategories.h"
#import "TSMessage.h"
#import "MLSession.h"

@interface PhoneLoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *phoneInput;
@property (weak, nonatomic) IBOutlet UITextField *passwordInput;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation PhoneLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"手机登陆";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginButtonPress:(id)sender {
    if(![self.phoneInput.text isMatch:RX(@"^1\\d{10}$")]){
        [TSMessage showNotificationWithTitle:@"请输入正确的国内手机号码"
                                        type:TSMessageNotificationTypeError];
        return;
    }

    if(self.passwordInput.text.length<1){
        [TSMessage showNotificationWithTitle:@"请输入密码"
                                        type:TSMessageNotificationTypeError];
        return;
    }

    [[MLSession current] loginWithPhone:self.phoneInput.text
                               password:self.passwordInput.text
                                success:^(UserDetailModel *model) {

                                    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
                                } fail:^(NSInteger i, id o) {
                [TSMessage showNotificationInViewController:self.navigationController
                                                      title:@"出错了"
                                                   subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
                                                       type:TSMessageNotificationTypeError];
//                [TSMessage showNotificationWithTitle:@"出错了"
//                                            subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
//                                                type:TSMessageNotificationTypeError];
            }];
}
- (IBAction)forgetPasswordPress:(id)sender {


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
