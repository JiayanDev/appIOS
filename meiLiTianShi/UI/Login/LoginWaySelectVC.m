//
//  LoginWaySelectVC.m
//  meiLiTianShi
//
//  Created by zcw on 15/7/28.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <TSMessages/TSMessage.h>
#import <Masonry/View+MASAdditions.h>
#import "LoginWaySelectVC.h"
#import "PhoneLoginVC.h"
#import "PhoneBindFVC.h"
#import "WXApi.h"
#import "MLSession.h"
#import "WXApiObject.h"
#import "MLKILabel.h"
#import "MLStyleManager.h"
#import "PhoneLoginFVC.h"
#import "MLKILabel.h"
#import "UILabel+MLStyle.h"
#import "GeneralWebVC.h"

@interface LoginWaySelectVC ()
@property (weak, nonatomic) IBOutlet UIButton *wxLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *otherLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@end

@implementation LoginWaySelectVC

- (void)viewDidLoad {
    [super viewDidLoad];

    if(![WXApi isWXAppInstalled]){
//        self.wxLoginButton.hidden=YES;
        PhoneLoginFVC *vc=[[PhoneLoginFVC alloc] init];
//        [self.navigationController pushViewController:vc
//                                             animated:YES];
        self.navigationController.viewControllers=@[vc];
    }






    THEME_BUTTON(self.wxLoginButton);

    [MLStyleManager removeBackTextForNextScene:self];
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

    UIView *con=[UIView new];
    [self.view addSubview:con];
    [con addSubview:self.licenseLabelLeft];
    [con addSubview:self.licenseButton];
    [self.licenseButton addTarget:self
                           action:@selector(licenseTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.licenseLabelLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(con);
        make.left.equalTo(con);
        make.right.equalTo(self.licenseButton.mas_left);
        make.centerY.equalTo(con);
    }];

    [self.licenseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(con);
        make.top.equalTo(con);
        make.centerY.equalTo(con);
    }];

    [con mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.equalTo(self.licenseButton);
        make.bottom.equalTo(self.wxLoginButton.mas_top).offset(-8);
    }];

//    self.licenseLabel= [MLKILabel newMLStyleWithSize:14 isGrey:YES string:@"点击登陆按钮代表已经同意用户协议" DetectString:@"用户协议"];
//
//    [self.view addSubview:self.licenseLabel];
//    self.licenseLabel.text=@"点击登陆按钮代表已经同意用户协议";
//    [self.licenseLabel setNeedsLayout];
//    [self.licenseLabel setNeedsDisplay];
//    self.licenseLabel.detectStringTapHandler= ^(KILabel *label, NSString *string, NSRange range) {
//        NSString *message = [NSString stringWithFormat:@"You tapped %@", string];
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"p"
//                                                                       message:message
//                                                                preferredStyle:UIAlertControllerStyleAlert];
//        [alert addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:nil]];
//
//        [self presentViewController:alert animated:YES completion:nil];
//    };
//
//    [self.licenseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.wxLoginButton);
//        make.right.equalTo(self.wxLoginButton);
//        make.bottom.equalTo(self.wxLoginButton.mas_top).offset(-8);
//        make.height.mas_greaterThanOrEqualTo(20);
//    }];



//    KILabel *l2=[KILabel new];
//
//    [self.view addSubview:l2];
//    l2.text=@"点击登陆按钮代表已经同意用户协议";
//    [l2 setNeedsLayout];
//    [l2 setNeedsDisplay];
////    l2.detectStringTapHandler= ^(KILabel *label, NSString *string, NSRange range) {
////        NSString *message = [NSString stringWithFormat:@"You tapped %@", string];
////        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"p"
////                                                                       message:message
////                                                                preferredStyle:UIAlertControllerStyleAlert];
////        [alert addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:nil]];
////
////        [self presentViewController:alert animated:YES completion:nil];
////    };
//
//    [l2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.wxLoginButton);
//        make.right.equalTo(self.wxLoginButton);
//        make.bottom.equalTo(self.wxLoginButton.mas_top).offset(-8);
//        make.height.mas_greaterThanOrEqualTo(20);
//    }];

//
//    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithTitle:@"取消"
//                                                                            style:UIBarButtonItemStylePlain
//                                                                           target:self
//                                                                           action:@selector(cancel)];
//    if(![WXApi isWXAppInstalled]){
//        self.wxLoginButton.hidden=YES;
//    }
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
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(IBAction)cancel{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)otherLoginPress:(id)sender {
    [self.navigationController pushViewController:[[PhoneLoginFVC alloc] init]
                                         animated:YES];
}
- (IBAction)registButtonPress:(id)sender {
    PhoneBindFVC *vc= [[PhoneBindFVC alloc] init];
    vc.type=PhoneBindVcType_registerFirstStep;
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
