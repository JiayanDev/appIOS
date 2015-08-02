//
//  ChangePasswordSecondStepFTV.m
//  meiLiTianShi
//
//  Created by zcw on 15/8/3.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "ChangePasswordSecondStepFTV.h"

#import "XLForm.h"
#import "MLSession.h"
#import "TSMessage.h"
#import "ConfigIndexVC.h"
#import "RMUniversalAlert.h"

@interface ChangePasswordSecondStepFTV ()

@end

@implementation ChangePasswordSecondStepFTV
#define getValue(k) ((NSString*)[self.form formRowWithTag:k].value)
#define kPassword1 @"password1"
#define kPassword2 @"password2"
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc] initWithTitle:@"提交"
                                                                             style:UIBarButtonItemStylePlain target:self
                                                                            action:@selector(submit)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id)init {
    XLFormDescriptor *logginedFormDescriptor = [XLFormDescriptor formDescriptor];
    XLFormSectionDescriptor *section;
    XLFormRowDescriptor *row;

    section = [XLFormSectionDescriptor formSectionWithTitle:@""];

    [logginedFormDescriptor addFormSection:section];


    row = [XLFormRowDescriptor formRowDescriptorWithTag:kPassword1 rowType:XLFormRowDescriptorTypePassword title:@"密码"];
//    row.action.viewControllerClass = [InfoIndexVC class];
    [section addFormRow:row];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:kPassword2 rowType:XLFormRowDescriptorTypePassword title:@"密码"];
//    row.action.viewControllerClass = [InfoIndexVC class];
    [section addFormRow:row];


    return [super initWithForm:logginedFormDescriptor];
}

-(void)submit{
    if(getValue(kPassword1).length>0 && getValue(kPassword2).length>0 &&[getValue(kPassword1) isEqualToString:getValue(kPassword2)]){
        [[MLSession current] forgetAndChangePasswordWithPhoneNum:self.phoneNum
                                                         receipt:self.receipt
                                                     rawPassword:getValue(kPassword2)
                                                         success:^{
                                                             [RMUniversalAlert showAlertInViewController:self
                                                                                               withTitle:@"提示"
                                                                                                 message:@"密码修改成功"
                                                                                       cancelButtonTitle:@"确定"
                                                                                  destructiveButtonTitle:nil
                                                                                       otherButtonTitles:nil
                                                                                                tapBlock:^(RMUniversalAlert *alert, NSInteger buttonIndex){
                                                                                                    for (UIViewController *one in [[self.navigationController viewControllers] reverseObjectEnumerator]) {
                                                                                                        if ([one isKindOfClass:[ConfigIndexVC class]]) {
                                                                                                            [self.navigationController popToViewController:one animated:YES];
                                                                                                            break;
                                                                                                        }
                                                                                                    }
                                                                                                }];

                                                         } fail:^(NSInteger i, id o) {
                    [TSMessage showNotificationInViewController:self.navigationController
                                                          title:@"出错了"
                                                       subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
                                                           type:TSMessageNotificationTypeError];
                }];
    }
}

@end
