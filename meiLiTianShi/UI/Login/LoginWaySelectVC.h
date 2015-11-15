//
//  LoginWaySelectVC.h
//  meiLiTianShi
//
//  Created by zcw on 15/7/28.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLSession.h"

@class SendAuthResp;
@class MLKILabel;

@interface LoginWaySelectVC : UIViewController <wxAuthRespondVC>

@property(nonatomic, strong) MLKILabel *licenseLabel;

@property(nonatomic, strong) UIButton *licenseButton;

@property(nonatomic, strong) UILabel *licenseLabelLeft;

- (void)handleWxAuthRespond:(SendAuthResp *)resp;
@end
