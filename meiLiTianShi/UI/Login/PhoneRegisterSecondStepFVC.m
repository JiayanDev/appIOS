//
// Created by zcw on 15/8/20.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "PhoneRegisterSecondStepFVC.h"
#import "MLStyleManager.h"
#import "FloatCellOfName.h"
#import "FloatCellOfGender.h"
#import "FloatCellOfPassword.h"

@interface PhoneRegisterSecondStepFVC()
@property (nonatomic, strong)UIButton *submitButton;

@end

@implementation PhoneRegisterSecondStepFVC
#define kName @"name"
#define kGender @"gender"
#define kPass1 @"password1"
#define kPass2 @"password2"

- (void)viewDidLoad {
    [super viewDidLoad];
//    [MLStyleManager styleTheNavigationBar:self.navigationController.navigationBar];




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



    row = [XLFormRowDescriptor formRowDescriptorWithTag:kName rowType:XLFormRowDescriptorTypeFloatLabeledTextField_name];
    row.title=@"昵称";
    [section addFormRow:row];


    row = [XLFormRowDescriptor formRowDescriptorWithTag:kGender rowType:XLFormRowDescriptorTypeFloatLabeledTextField_gender];
    row.title=@"性别";
    [section addFormRow:row];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:kPass1 rowType:XLFormRowDescriptorTypeFloatLabeledTextField_password];
    row.title=@"设置密码";
    [section addFormRow:row];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:kPass2 rowType:XLFormRowDescriptorTypeFloatLabeledTextField_password];
    row.title=@"确认密码";
    [section addFormRow:row];



    return [super initWithForm:formDescriptor];

}





- (IBAction)submitButtonPress:(UIButton *)sender {


}


@end