//
// Created by zcw on 15/9/15.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "ChangePasswordFVC.h"
#import "XLForm.h"
#import "MLXLFormTextFieldCell.h"
#import "MLSession.h"
#import "UserModel.h"
#import "FloatCellOfPassword.h"
#import "TSMessage.h"
#import "XLform_getAndSetValue.h"

@implementation ChangePasswordFVC {
    BOOL userHasPassword;
}

#define kName @"name"
#define kPassOld @"passold"
#define kPassNew1 @"passnew1"
#define kPassNew2 @"passnew2"

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self addStyledBigButtonAtTableFooter_title:@"保存"] addTarget:self
                                                           action:@selector(submitPress)
                                                 forControlEvents:UIControlEventTouchUpInside];
    [[MLSession current] checkUserHasPasswordSucc:^(BOOL hasPassword) {
                userHasPassword = hasPassword;
                if (!hasPassword) {
                    self.title=@"设置密码";
                    [self.form removeFormRow:[self.form formRowWithTag:kPassOld]];
                    [self.tableView reloadData];
                }

            }
                                             fail:^(NSInteger i, id o) {
                                                 [TSMessage showNotificationWithTitle:@"出错了"
                                                                             subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
                                                                                 type:TSMessageNotificationTypeError];
                                             }];
}

- (void)submitPress {
    [self.view endEditing:YES];
    if([getValueS(kPassNew1) isEqualToString:getValueS(kPassNew2)] && getValueS(kPassNew1).length>=6){
        if(userHasPassword){

            [[MLSession current] changeUserPasswordWithOriginalRawPassword:getValueS(kPassOld)
                                                            newRawPassword:getValueS(kPassNew1)
                                                                   success:^{
                                                                       [TSMessage showNotificationWithTitle:@"修改密码成功"
                                                                                                       type:TSMessageNotificationTypeSuccess];
                                                                       [self.navigationController popViewControllerAnimated:YES];
                                                                   } fail:^(NSInteger i, id o) {
                        [TSMessage showNotificationWithTitle:@"出错了"
                                                    subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
                                                        type:TSMessageNotificationTypeError];
                    }];
        }else{
            [[MLSession current] changeUserPasswordWithOriginalRawPassword:nil
                                                            newRawPassword:getValueS(kPassNew1)
                                                                   success:^{
                                                                       [TSMessage showNotificationWithTitle:@"修改密码成功"
                                                                                                       type:TSMessageNotificationTypeSuccess];
                                                                       [self.navigationController popViewControllerAnimated:YES];
                                                                   } fail:^(NSInteger i, id o) {
                        [TSMessage showNotificationWithTitle:@"出错了"
                                                    subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
                                                        type:TSMessageNotificationTypeError];
                    }];
        };

    }else{
        [TSMessage showNotificationWithTitle:@"请输入至少6位的密码,并确保两次一致"
                                        type:TSMessageNotificationTypeWarning];
    }

};


- (id)init {
    XLFormDescriptor *formDescriptor = [XLFormDescriptor formDescriptorWithTitle:@"修改密码"];
    XLFormSectionDescriptor *section;
    XLFormRowDescriptor *row;

    section = [XLFormSectionDescriptor formSectionWithTitle:@""];

    [formDescriptor addFormSection:section];


    row = [XLFormRowDescriptor formRowDescriptorWithTag:kName rowType:XLFormRowDescriptorTypeText title:@""];
    row.value = [MLSession current].currentUser.name;
    row.disabled = @(YES);
//    row.action.viewControllerClass=[AvatarDetailVC class];
    [section addFormRow:row];


    section = [XLFormSectionDescriptor formSectionWithTitle:@""];

    [formDescriptor addFormSection:section];


    row = [XLFormRowDescriptor formRowDescriptorWithTag:kPassOld rowType:XLFormRowDescriptorTypeFloatLabeledTextField_password];
    row.title = @"当前密码";
    [section addFormRow:row];

    [formDescriptor addFormSection:section];
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kPassNew1 rowType:XLFormRowDescriptorTypeFloatLabeledTextField_password];
    row.title = @"新密码";
    [section addFormRow:row];

    [formDescriptor addFormSection:section];
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kPassNew2 rowType:XLFormRowDescriptorTypeFloatLabeledTextField_password];
    row.title = @"再次输入新密码";
    [section addFormRow:row];


    return [super initWithForm:formDescriptor];
}
@end