//
// Created by zcw on 15/8/18.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "PhoneBindFVC.h"
#import "XLForm.h"
#import "FloatCellOfPhoneAndButton.h"
#import "FloatCellOfNumber.h"
#import "RegExCategories.h"
#import "TSMessage.h"
#import "MLSession.h"
#import "XLform_getAndSetValue.h"
#import "UIScrollView+MJRefresh.h"
#import "UIImage+Color.h"
#import "PhoneRegisterSecondStepVC.h"
#import "ForgetPasswordSecondStepVC.h"
#import "ChangePasswordSecondStepFTV.h"
#import "MLStyleManager.h"


@interface PhoneBindFVC()
@property (nonatomic, strong)NSString *confirmId;
@property (nonatomic, strong)NSString *receipt;
@property (nonatomic, strong)UIButton *submitButton;
@end
@implementation PhoneBindFVC

#define kPhone @"phone"
#define kCode @"code"


- (void)viewDidLoad {
    [super viewDidLoad];
    [MLStyleManager styleTheNavigationBar:self.navigationController.navigationBar];

    if (self.type==PhoneBindVcType_registerFirstStep){
        self.title=@"注册";
    }else if (self.type==PhoneBindVcType_afterWechatLogin){
        self.title=@"忘记密码";
    }else if (self.type==PhoneBindVcType_forgetPasswordFirstStep){
        self.title=@"绑定手机";
    }else if (self.type==PhoneBindVcType_bindWechatFirstStep){
        self.title=@"微信绑定";
    }else if (self.type==PhoneBindVcType_changePasswordFirstStep){
        self.title=@"更改密码";
    }



    self.submitButton=[self addStyledBigButtonAtTableFooter_title:@"完成验证"];
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


//
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kcates rowType:XLFormRowDescriptorTypeSelectorPush title:@"项目"];
//    row.required = YES;
//    row.action.viewControllerClass=[ProjectSelectVC class];
//    //row.value=
//    [section addFormRow:row];
//
//
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kDate rowType:XLFormRowDescriptorTypeDate title:@"手术日期"];
//    row.value = [NSDate new];
//    [row.cellConfigAtConfigure setObject:[NSDate new] forKey:@"maximumDate"];
//    [section addFormRow:row];



    row = [XLFormRowDescriptor formRowDescriptorWithTag:kPhone rowType:XLFormRowDescriptorTypeFloatLabeledTextField_phoneAndButton];
    row.title=@"手机号";
//    row.cellConfigAtConfigure[@"textView.placeholder"] = @"日记内容";
    [section addFormRow:row];



    row = [XLFormRowDescriptor formRowDescriptorWithTag:kCode rowType:XLFormRowDescriptorTypeFloatLabeledTextField_number];
    row.title=@"短信验证码";
//    row.cellConfigAtConfigure[@"textView.placeholder"] = @"日记内容";
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
    [sender becomeFirstResponder];
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
    if (self.type==PhoneBindVcType_registerFirstStep){
//        PhoneRegisterSecondStepVC *vc= [[PhoneRegisterSecondStepVC alloc] init];
//        vc.receipt=self.receipt;
//        vc.phoneNum=self.phoneInput.text;
//        [self.navigationController pushViewController:vc animated:YES];
    }else if (self.type==PhoneBindVcType_afterWechatLogin){
        [[MLSession current] registerWithParam:@{
                        @"wxReceipt":self.wxReceipt_afterWechatLogin,
                        @"receipt":self.receipt,
                        @"phoneNum":getValue(kPhone),
                } password:nil
                                       success:^(UserModel *model) {
                                           [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];

                                       } fail:^(NSInteger i, id o) {
                    [TSMessage showNotificationInViewController:self.navigationController
                                                          title:@"出错了"
                                                       subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
                                                           type:TSMessageNotificationTypeError];
                }];
    }else if (self.type==PhoneBindVcType_forgetPasswordFirstStep){
//        ForgetPasswordSecondStepVC *vc= [[ForgetPasswordSecondStepVC alloc] init];
//        vc.receipt=self.receipt;
//        vc.phoneNum=self.phoneInput.text;
//        [self.navigationController pushViewController:vc animated:YES];
    }else if (self.type==PhoneBindVcType_bindWechatFirstStep){
//        [MLSession current].presentingWxLoginVC=self;
//        SendAuthReq *req= [[SendAuthReq alloc] init];
//        req.scope=@"snsapi_userinfo" ;
//        req.state = @"meilitianshi_weixindenglu" ;
//        [WXApi sendReq:req];
    }else if (self.type==PhoneBindVcType_changePasswordFirstStep){
//        ChangePasswordSecondStepFTV *vc= [[ChangePasswordSecondStepFTV alloc] init];
//        vc.receipt=self.receipt;
//        vc.phoneNum=self.phoneInput.text;
//        [self.navigationController pushViewController:vc animated:YES];

    }

}

@end