//
// Created by zcw on 15/8/20.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "ForgetPasswordFVC.h"
#import "MLStyleManager.h"
#import "FloatCellOfPhoneAndButton.h"
#import "FloatCellOfNumber.h"
#import "XLform_getAndSetValue.h"
#import "TSMessage.h"
#import "RegExCategories.h"
#import "MLSession.h"
#import "FloatCellOfPassword.h"
#import "UIAlertView+Blocks.h"


@interface ForgetPasswordFVC()
@property (nonatomic, strong)NSString *confirmId;
@property (nonatomic, strong)NSString *receipt;
@property (nonatomic, strong)UIButton *submitButton;
@end

@implementation ForgetPasswordFVC

#define kPhone @"phone"
#define kCode @"code"
#define kPass1 @"password1"
#define kPass2 @"password2"


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"找回密码";
//    [MLStyleManager styleTheNavigationBar:self.navigationController.navigationBar];
    [MLStyleManager removeBackTextForNextScene:self];




    self.submitButton=[self addStyledBigButtonAtTableFooter_title:@"立即找回"];
    [self.submitButton addTarget:self action:@selector(submitButtonPress:) forControlEvents:UIControlEventTouchUpInside];
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}




-(id)init
{
    XLFormDescriptor * formDescriptor = [XLFormDescriptor formDescriptor];
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;

    section = [XLFormSectionDescriptor formSectionWithTitle:@""];

    [formDescriptor addFormSection:section];





    row = [XLFormRowDescriptor formRowDescriptorWithTag:kPhone rowType:XLFormRowDescriptorTypeFloatLabeledTextField_phoneAndButton];
    row.title=@"手机号";
    [section addFormRow:row];



    row = [XLFormRowDescriptor formRowDescriptorWithTag:kCode rowType:XLFormRowDescriptorTypeFloatLabeledTextField_number];
    row.title=@"短信验证码";
    [section addFormRow:row];



    section = [XLFormSectionDescriptor formSectionWithTitle:@""];

    [formDescriptor addFormSection:section];


    row = [XLFormRowDescriptor formRowDescriptorWithTag:kPass1 rowType:XLFormRowDescriptorTypeFloatLabeledTextField_password];
    row.title=@"设置新密码";
    [section addFormRow:row];


    row = [XLFormRowDescriptor formRowDescriptorWithTag:kPass2 rowType:XLFormRowDescriptorTypeFloatLabeledTextField_password];
    row.title=@"确认新密码";
    [section addFormRow:row];



    return [super initWithForm:formDescriptor];

}



- (void)postfixButtonPressed:(UIButton *)button rowDescrptor:(XLFormRowDescriptor *)rowDescriptor {

    NSLog(@"::%@::",getValue(kPhone));
    if(![getValue(kPhone) isMatch:RX(@"^1\\d{10}$")]){
        [TSMessage showNotificationInViewController:self.navigationController
                                              title:@"请输入正确的国内手机号码"
                                           subtitle:nil
                                               type:TSMessageNotificationTypeError];
        return;
    }

    [[MLSession current] sendConfirmCodeWithPhone:getValue(kPhone)
                                          success:^(NSString *confirmId) {

                                              ((FloatCellOfPhoneAndButton *)[rowDescriptor cellForFormController:self]).postfixButton.enabled=NO;
                                              self.confirmId=confirmId;
                                          } fail:^(NSInteger i, id o) {
                [TSMessage showNotificationInViewController:self.navigationController
                                                      title:@"出错了"
                                                   subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
                                                       type:TSMessageNotificationTypeError];
                ((FloatCellOfPhoneAndButton *)[rowDescriptor cellForFormController:self]).postfixButton.enabled=YES;

            }];

}


- (IBAction)submitButtonPress:(UIButton *)sender {
    [self.view endEditing:YES];
    //    [sender becomeFirstResponder];
    if(!self.confirmId){
        [TSMessage showNotificationInViewController:self.navigationController
                                              title:@"请先发送验证码"
                                           subtitle:nil
                                               type:TSMessageNotificationTypeError];
        return;
    }
    if(!getValue(kCode)){
        [TSMessage showNotificationInViewController:self.navigationController
                                              title:@"请填写验证码"
                                           subtitle:nil
                                               type:TSMessageNotificationTypeError];
        return;
    }






    [[MLSession current] validateConfirmCodeWithCode:getValue(kCode)
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

    if(getValueS(kPass1).length>0 &&getValueS(kPass2).length>0 && [getValueS(kPass1) isEqualToString:getValueS(kPass2)]){
        [[MLSession current] forgetAndChangePasswordWithPhoneNum:getValue(kPhone)
                                                         receipt:self.receipt
                                                     rawPassword:getValue(kPass1)
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
    }else{
        [TSMessage showNotificationInViewController:self.navigationController
                                              title:@"请填写密码,并保持两次相同"
                                           subtitle:nil
                                               type:TSMessageNotificationTypeError];
        return;
    }


}
@end