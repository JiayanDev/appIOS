//
// Created by zcw on 15/8/20.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLXLformVC.h"
#import "MLSession.h"


@interface PhoneLoginFVC : MLXLformVC <wxAuthRespondVC>
@property(nonatomic, strong) UILabel *licenseLabelLeft;
@property(nonatomic, strong) UIButton *licenseButton;
@property(nonatomic, strong) UIView *licenseContainer;
@end