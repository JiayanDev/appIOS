//
//  PhoneBindVC.m
//  meiLiTianShi
//
//  Created by zcw on 15/7/29.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "PhoneBindVC.h"
#import "TSMessage.h"
#import "RegExCategories.h"
#import "MLSession.h"
#import "PhoneRegisterSecondStepVC.h"

@interface PhoneBindVC ()
@property (weak, nonatomic) IBOutlet UITextField *phoneInput;
@property (weak, nonatomic) IBOutlet UIButton *sendCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *codeInput;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (nonatomic, strong)NSString *confirmId;
@property (nonatomic, strong)NSString *receipt;

@end

@implementation PhoneBindVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.type==PhoneBindVcType_registerFirstStep){
        self.title=@"注册";
    }else if (self.type==PhoneBindVcType_afterWechatLogin){

    }else if (self.type==PhoneBindVcType_forgetPasswordFirstStep){
        self.title=@"绑定";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sendCodeButtonPress:(id)sender {
    if(![self.phoneInput.text isMatch:RX(@"^1\\d{10}$")]){
        [TSMessage showNotificationInViewController:self.navigationController
                                              title:@"请输入正确的国内手机号码"
                                           subtitle:nil
                                               type:TSMessageNotificationTypeError];
        return;
    }

    [[MLSession current] sendConfirmCodeWithPhone:self.phoneInput.text
                                          success:^(NSString *confirmId) {

                                              [self.sendCodeButton setTitle:@"已发送"
                                                                   forState:UIControlStateDisabled];
                                              [self.sendCodeButton setEnabled:NO];
                                              self.confirmId=confirmId;
                                          } fail:^(NSInteger i, id o) {
                [TSMessage showNotificationInViewController:self.navigationController
                                                      title:@"出错了"
                                                   subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
                                                       type:TSMessageNotificationTypeError];
            }];


}
- (IBAction)submitButtonPress:(id)sender {
    if(!self.confirmId){
        [TSMessage showNotificationInViewController:self.navigationController
                                              title:@"请先发送验证码"
                                           subtitle:nil
                                               type:TSMessageNotificationTypeError];
    }
    [[MLSession current] validateConfirmCodeWithCode:self.codeInput.text
                                           confirmId:self.confirmId
                                             success:^(NSString *receipt) {
                                                 self.receipt=receipt;
                                                 [self gotoNextScene];
                                             } fail:^(NSInteger i, id o) {
                [TSMessage showNotificationInViewController:self.navigationController
                                                      title:@"出错了"
                                                   subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
                                                       type:TSMessageNotificationTypeError];
            }];

}


-(void)gotoNextScene{
    if (self.type==PhoneBindVcType_registerFirstStep){
        PhoneRegisterSecondStepVC *vc= [[PhoneRegisterSecondStepVC alloc] init];
        vc.receipt=self.receipt;
        vc.phoneNum=self.phoneInput.text;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (self.type==PhoneBindVcType_afterWechatLogin){

    }else if (self.type==PhoneBindVcType_forgetPasswordFirstStep){
        self.title=@"绑定";
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
