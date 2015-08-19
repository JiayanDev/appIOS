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
    UIView * t= [[UIView alloc] init];
    UIButton * b= [[UIButton alloc] init];
    [b setTitle:@"完成验证" forState:UIControlStateNormal];
//    [b setTitle:@"已发送"
//                        forState:UIControlStateDisabled];
    b.backgroundColor=THEME_COLOR;
    b.titleLabel.font=[UIFont systemFontOfSize:15];
    b.layer.cornerRadius = 4;
    b.clipsToBounds = YES;
    [b setBackgroundImage:[UIImage imageWithColor:THEME_COLOR_HIGHLIGHT] forState:UIControlStateHighlighted];
    [b setBackgroundImage:[UIImage imageWithColor:THEME_COLOR_DISABLED_BUTTON] forState:UIControlStateDisabled];

    [b addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    [t addSubview:b];
    [b mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@45);
        make.left.equalTo(t.mas_left).with.offset(15);
        make.right.equalTo(t.mas_right).with.offset(-15);
        make.top.equalTo(t.mas_top).with.offset(30);
    }];

    self.tableView.tableFooterView=t;

//    [t mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.tableView.mas_leading).with.offset(0);
//        make.trailing.equalTo(self.tableView.mas_trailing).with.offset(0);
//    }];

    self.submitButton=b;
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
@end