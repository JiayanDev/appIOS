//
// Created by zcw on 15/8/20.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "PhoneLoginFVC.h"
#import "MLStyleManager.h"
#import "FloatCellOfNumber.h"
#import "FloatCellOfPassword.h"
#import "RegExCategories.h"
#import "TSMessage.h"
#import "XLform_getAndSetValue.h"
#import "MLSession.h"

@interface PhoneLoginFVC()

@property (nonatomic, strong)UIButton *submitButton;
@end

@implementation PhoneLoginFVC
#define kPhone @"phone"
#define kPass @"password"
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"账号登陆";
    [MLStyleManager styleTheNavigationBar:self.navigationController.navigationBar];
    [MLStyleManager removeBackTextForNextScene:self];





    self.submitButton=[self addStyledBigButtonAtTableFooter_title:@"登录"];
    [self.submitButton addTarget:self action:@selector(submitButtonPress:) forControlEvents:UIControlEventTouchUpInside];

    UIButton *b=[[UIButton alloc]init];
    [self.tableView.tableFooterView addSubview:b];
    [b setImage:[UIImage imageNamed:@"微信.png"] forState:UIControlStateNormal];
    [b setTitle:@"微信" forState:UIControlStateNormal];
    [b setImageEdgeInsets:UIEdgeInsetsMake(0,13,0,0)];
    [b setTitleEdgeInsets:UIEdgeInsetsMake(84,-55,0,0)];
    [b setContentEdgeInsets:UIEdgeInsetsMake(0,0,23,0)];
    [b setTitleColor:THEME_COLOR_TEXT forState:UIControlStateNormal];
    [b.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [b mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.tableView.tableFooterView ).with.offset(-57);
        make.centerX.equalTo(self.tableView.tableFooterView );

    }];


}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

    NSLog(@"%@",NSStringFromCGRect(self.tableView.tableFooterView.frame));
    CGRect r=self.tableView.tableFooterView.frame;
    r.size.height=self.tableView.frame.size.height-r.origin.y-64;
    self.tableView.tableFooterView.frame=r;

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



    row = [XLFormRowDescriptor formRowDescriptorWithTag:kPhone rowType:XLFormRowDescriptorTypeFloatLabeledTextField_number];
    row.title=@"手机号";
//    row.cellConfigAtConfigure[@"textView.placeholder"] = @"日记内容";
    [section addFormRow:row];



    row = [XLFormRowDescriptor formRowDescriptorWithTag:kPass rowType:XLFormRowDescriptorTypeFloatLabeledTextField_password];
    row.title=@"密码";
//    row.cellConfigAtConfigure[@"textView.placeholder"] = @"日记内容";
    [section addFormRow:row];




    return [super initWithForm:formDescriptor];

}


- (IBAction)submitButtonPress:(UIButton *)sender {
    [self.view endEditing:YES];


    if(![getValue(kPhone) isMatch:RX(@"^1\\d{10}$")]){
        [TSMessage showNotificationInViewController:self.navigationController
                                              title:@"请输入正确的国内手机号码"
                                           subtitle:nil
                                               type:TSMessageNotificationTypeError];
//        [TSMessage showNotificationWithTitle:@"请输入正确的国内手机号码"
//                                        type:TSMessageNotificationTypeError];
        return;
    }

    if(getValueS(kPass).length<1){
        [TSMessage showNotificationWithTitle:@"请输入密码"
                                        type:TSMessageNotificationTypeError];
        return;
    }

    [[MLSession current] loginWithPhone:getValue(kPhone)
                               password:getValueS(kPass)
                                success:^(UserModel *model) {

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

@end