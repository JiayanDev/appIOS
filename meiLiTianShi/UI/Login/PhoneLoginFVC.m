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
#import "WXApiObject.h"
#import "WXApi.h"
#import "PhoneBindFVC.h"
#import "ForgetPasswordFVC.h"
#import "UILabel+MLStyle.h"
#import "GeneralWebVC.h"

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

    if(self==self.navigationController.viewControllers[0]){
        self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self
                                                                               action:@selector(cancel)];
    }



    self.submitButton=[self addStyledBigButtonAtTableFooter_title:@"登录"];
    [self.submitButton addTarget:self action:@selector(submitButtonPress:) forControlEvents:UIControlEventTouchUpInside];

    if([WXApi isWXAppInstalled]) {

        {
            UIButton *b = [[UIButton alloc] init];
            [self.tableView.tableFooterView addSubview:b];
            [b setImage:[UIImage imageNamed:@"微信.png"] forState:UIControlStateNormal];
            [b setTitle:@"微信" forState:UIControlStateNormal];
            [b setImageEdgeInsets:UIEdgeInsetsMake(0, 13, 0, 0)];
            [b setTitleEdgeInsets:UIEdgeInsetsMake(84, -55, 0, 0)];
            [b setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 23, 0)];
            [b setTitleColor:THEME_COLOR_TEXT forState:UIControlStateNormal];
            [b.titleLabel setFont:[UIFont systemFontOfSize:13]];
            [b mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.tableView.tableFooterView).with.offset(-57);
                make.centerX.equalTo(self.tableView.tableFooterView);

            }];

            [b addTarget:self action:@selector(wxLoginPress:) forControlEvents:UIControlEventTouchUpInside];


            UIView *line = [[UIView alloc] init];
            [self.tableView.tableFooterView addSubview:line];
            line.backgroundColor = THEME_COLOR_SEPERATOR_LINE;
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(@(THE1PX_CONST));
                make.right.equalTo(self.tableView.tableFooterView).with.offset(-15);
                make.left.equalTo(self.tableView.tableFooterView).with.offset(15);
                make.bottom.equalTo(b.mas_top).with.offset(-48);


            }];


            UILabel *l = [[UILabel alloc] init];
            [self.tableView.tableFooterView addSubview:l];

            l.text = @"一键登录";
            l.backgroundColor = THEME_COLOR_BACKGROUND;
            l.font = [UIFont systemFontOfSize:13];
            l.textColor = THEME_COLOR_TEXT;
            [l setTextAlignment:NSTextAlignmentCenter];
            [l mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(b.mas_top).with.offset(-40);
                make.centerX.equalTo(self.tableView.tableFooterView);
                make.width.mas_equalTo(@66);
            }];
        }
    }



    
    {
        self.licenseLabelLeft=[UILabel newMLStyleWithSize:14 isGrey:YES];
        self.licenseButton=[UIButton new];
        self.licenseLabelLeft.text=@"点击登陆按钮代表已经同意";
//    [self.licenseButton setTitle:@"123sasd" forState:UIControlStateNormal];


        [self.licenseButton setAttributedTitle:
                        [[NSAttributedString alloc] initWithString:@"用户协议"
                                                        attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14],
                                                                NSForegroundColorAttributeName: THEME_COLOR_TEXT_DARKER_GRAY,
                                                                NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)}]
                                      forState:UIControlStateNormal];
//    [self.licenseButton setTitleColor:THEME_COLOR_TEXT_DARKER_GRAY forState:UIControlStateNormal];
        self.licenseButton.titleLabel.font=[UIFont systemFontOfSize:14];

        self.licenseContainer=[UIView new];
        [self.view addSubview:self.licenseContainer];
        [self.licenseContainer addSubview:self.licenseLabelLeft];
        [self.licenseContainer addSubview:self.licenseButton];
        [self.licenseButton addTarget:self
                               action:@selector(licenseTouch) forControlEvents:UIControlEventTouchUpInside];
        [self.licenseLabelLeft mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.licenseContainer);
            make.left.equalTo(self.licenseContainer);
            make.right.equalTo(self.licenseButton.mas_left);
            make.centerY.equalTo(self.licenseContainer);
        }];

        [self.licenseButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.licenseContainer);
            make.top.equalTo(self.licenseContainer);
            make.centerY.equalTo(self.licenseContainer);
        }];

        [self.licenseContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.height.equalTo(self.licenseButton);
            make.top.equalTo(self.submitButton.mas_bottom).offset(8);
        }];
    }



    {
        UIButton *b= [[UIButton alloc] init];
        [self.tableView.tableFooterView addSubview:b];
        [b setTitle:@"忘记密码" forState:UIControlStateNormal];
        [b.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [b setTitleColor:THEME_COLOR_TEXT forState:UIControlStateNormal];
        [b setTitleColor:THEME_COLOR_TEXT_LIGHT_GRAY forState:UIControlStateHighlighted];
        [b addTarget:self action:@selector(forgetPasswordPress:) forControlEvents:UIControlEventTouchUpInside];
        [b mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.tableView.tableFooterView).with.offset(-15);
            make.top.equalTo(self.licenseContainer.mas_bottom).with.offset(18);
        }];

    }

    {
        UIButton *b= [[UIButton alloc] init];
        [self.tableView.tableFooterView addSubview:b];
        [b setTitle:@"手机注册" forState:UIControlStateNormal];
        [b.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [b setTitleColor:THEME_COLOR_TEXT forState:UIControlStateNormal];
        [b setTitleColor:THEME_COLOR_TEXT_LIGHT_GRAY forState:UIControlStateHighlighted];
        [b addTarget:self action:@selector(registButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        [b mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.tableView.tableFooterView).with.offset(15);
            make.top.equalTo(self.licenseContainer.mas_bottom).with.offset(18);
        }];
    }





}

-(IBAction)cancel{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
-(void)licenseTouch{
    NSLog(@"licenseTouch");
    GeneralWebVC *vc=[[GeneralWebVC alloc]init];
    vc.url=[NSURL URLWithString:@"http://jiayantech.com/mob/agreement.html"];
    vc.title=@"用户协议";
    [self.navigationController pushViewController:vc animated:YES];

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




    row = [XLFormRowDescriptor formRowDescriptorWithTag:kPhone rowType:XLFormRowDescriptorTypeFloatLabeledTextField_number];
    row.title=@"手机号";
    [section addFormRow:row];



    row = [XLFormRowDescriptor formRowDescriptorWithTag:kPass rowType:XLFormRowDescriptorTypeFloatLabeledTextField_password];
    row.title=@"密码";
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

- (IBAction)forgetPasswordPress:(id)sender {
    ForgetPasswordFVC *vc= [[ForgetPasswordFVC alloc] init];
//    vc.type=PhoneBindVcType_forgetPasswordFirstStep;
    [self.navigationController pushViewController:vc
                                         animated:YES];

}



- (IBAction)wxLoginPress:(id)sender {
    [MLSession current].presentingWxLoginVC=self;
    SendAuthReq *req= [[SendAuthReq alloc] init];
    req.scope=@"snsapi_userinfo" ;
    req.state = @"meilitianshi_weixindenglu" ;
    [WXApi sendReq:req];
}

- (IBAction)registButtonPress:(id)sender {
    PhoneBindFVC *vc= [[PhoneBindFVC alloc] init];
    vc.type=PhoneBindVcType_registerFirstStep;
    [self.navigationController pushViewController:vc
                                         animated:YES];
}

-(void)handleWxAuthRespond:(SendAuthResp*)resp{
    if(resp.errCode!=0){
        [TSMessage showNotificationInViewController:self.navigationController
                                              title:@"微信登陆取消"
                                           subtitle:nil
                                               type:TSMessageNotificationTypeError];
        return ;
    }

    [[MLSession current] loginWithWeixinCode:resp.code
                                     success:^(UserModel *model,NSString *wxReceipt) {
                                         if(wxReceipt){
                                             PhoneBindFVC *vc= [[PhoneBindFVC alloc] init];
                                             vc.type=PhoneBindVcType_afterWechatLogin;
                                             vc.wxReceipt_afterWechatLogin=wxReceipt;
                                             [self.navigationController pushViewController:vc
                                                                                  animated:YES];
                                         }else{
                                             [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
                                         }

                                     } fail:^(NSInteger i, id o) {
                [TSMessage showNotificationInViewController:self.navigationController
                                                      title:@"出错了"
                                                   subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
                                                       type:TSMessageNotificationTypeError];
            }];

}

@end