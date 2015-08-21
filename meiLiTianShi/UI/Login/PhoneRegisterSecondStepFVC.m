//
// Created by zcw on 15/8/20.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "PhoneRegisterSecondStepFVC.h"
#import "MLStyleManager.h"
#import "FloatCellOfName.h"
#import "FloatCellOfGender.h"
#import "FloatCellOfPassword.h"
#import "MLSession.h"
#import "TSMessage.h"
#import "XLform_getAndSetValue.h"

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
    self.title=@"完善信息";
//    [MLStyleManager styleTheNavigationBar:self.navigationController.navigationBar];




    self.submitButton=[self addStyledBigButtonAtTableFooter_title:@"注册"];
    [self.submitButton addTarget:self action:@selector(submitButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *l=[[UILabel alloc]init];
    [self.tableView.tableFooterView addSubview:l];
    l.text=@"点击注册,代表理解并同意用户协议及隐私政策";
    l.numberOfLines=0;
    l.font=[UIFont systemFontOfSize:13];
    l.textColor=THEME_COLOR_TEXT_LIGHT_GRAY;
    [l mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tableView.tableFooterView).with.offset(15);
        make.right.equalTo(self.tableView.tableFooterView).with.offset(-15);
        make.top.equalTo(self.tableView.tableFooterView).with.offset(6);
    }];
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
    row.value=@1;

    row = [XLFormRowDescriptor formRowDescriptorWithTag:kPass1 rowType:XLFormRowDescriptorTypeFloatLabeledTextField_password];
    row.title=@"设置密码";
    [section addFormRow:row];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:kPass2 rowType:XLFormRowDescriptorTypeFloatLabeledTextField_password];
    row.title=@"确认密码";
    [section addFormRow:row];



    return [super initWithForm:formDescriptor];

}





- (IBAction)submitButtonPress:(UIButton *)sender {
    [self.view endEditing:YES];
    NSLog(@"name:%@,gender:%@",getValue(kName),getValue(kGender));
    if(!getValue(kName)){
        [TSMessage showNotificationWithTitle:@"请填写昵称" type:TSMessageNotificationTypeError];
        return ;
    }

    if(getValueS(kPass1).length>0 &&getValueS(kPass2).length>0 && [getValueS(kPass1) isEqualToString:getValueS(kPass2)]) {
        NSDictionary *d = @{
                @"phoneNum" : self.phoneNum,
                @"name" : getValue(kName),
                @"gender" : getValue(kGender),
                @"receipt" : self.receipt,
        };

        [[MLSession current] registerWithParam:d
                                      password:getValue(kPass1)
                                       success:^(UserModel *model) {
                                           [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];

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