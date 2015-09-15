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

@implementation ChangePasswordFVC {

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
}

-(void)submitPress{


};


-(id)init {
    XLFormDescriptor *formDescriptor = [XLFormDescriptor formDescriptorWithTitle:@"我的资料"];
    XLFormSectionDescriptor *section;
    XLFormRowDescriptor *row;

    section = [XLFormSectionDescriptor formSectionWithTitle:@""];

    [formDescriptor addFormSection:section];


    row = [XLFormRowDescriptor formRowDescriptorWithTag:kName rowType:XLFormRowDescriptorTypeText title:@""];
    row.value=[MLSession current].currentUser.name;
    row.disabled=@(YES);
//    row.action.viewControllerClass=[AvatarDetailVC class];
    [section addFormRow:row];



    section = [XLFormSectionDescriptor formSectionWithTitle:@""];

    [formDescriptor addFormSection:section];
    row=[XLFormRowDescriptor formRowDescriptorWithTag:kPassOld rowType:XLFormRowDescriptorTypeFloatLabeledTextField_password];
    row.title=@"当前密码";

    [formDescriptor addFormSection:section];
    row=[XLFormRowDescriptor formRowDescriptorWithTag:kPassNew1 rowType:XLFormRowDescriptorTypeFloatLabeledTextField_password];
    row.title=@"新密码";

    [formDescriptor addFormSection:section];
    row=[XLFormRowDescriptor formRowDescriptorWithTag:kPassNew2 rowType:XLFormRowDescriptorTypeFloatLabeledTextField_password];
    row.title=@"再次输入新密码";


    return [super initWithForm:formDescriptor];
}
@end