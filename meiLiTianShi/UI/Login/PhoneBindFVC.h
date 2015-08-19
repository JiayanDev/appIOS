//
// Created by zcw on 15/8/18.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLFormViewController.h"
#import "MLXLformVC.h"
#import "FloatCellOfPhoneAndButton.h"


@interface PhoneBindFVC : MLXLformVC<FloatCellOfPhoneAndButton_buttonDelegate>
@property (nonatomic, strong)NSString *wxReceipt_afterWechatLogin;

@end