//
//  LoginWaySelectVC.m
//  meiLiTianShi
//
//  Created by zcw on 15/7/28.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <TSMessages/TSMessage.h>
#import "LoginWaySelectVC.h"
#import "PhoneLoginVC.h"
#import "PhoneBindFVC.h"
#import "WXApi.h"
#import "MLSession.h"
#import "WXApiObject.h"
#import "MLStyleManager.h"

@interface LoginWaySelectVC ()
@property (weak, nonatomic) IBOutlet UIButton *wxLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *otherLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@end

@implementation LoginWaySelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    THEME_BUTTON(self.wxLoginButton);

//
//    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithTitle:@"取消"
//                                                                            style:UIBarButtonItemStylePlain
//                                                                           target:self
//                                                                           action:@selector(cancel)];
//    if(![WXApi isWXAppInstalled]){
//        self.wxLoginButton.hidden=YES;
//    }
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
    [self.navigationController pushViewController:[[PhoneLoginVC alloc] init]
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
