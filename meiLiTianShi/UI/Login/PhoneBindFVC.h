//
// Created by zcw on 15/8/18.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLFormViewController.h"
#import "MLXLformVC.h"
#import "FloatCellOfPhoneAndButton.h"

typedef NS_ENUM(NSUInteger , PhoneBindVcType){
    PhoneBindVcType_afterWechatLogin,
    PhoneBindVcType_registerFirstStep,
    PhoneBindVcType_forgetPasswordFirstStep,
    PhoneBindVcType_bindWechatFirstStep,
    PhoneBindVcType_changePasswordFirstStep,
};
@interface PhoneBindFVC : MLXLformVC<FloatCellOfPhoneAndButton_buttonDelegate>
@property (nonatomic, assign)PhoneBindVcType type;

@property (nonatomic, strong)NSString *wxReceipt_afterWechatLogin;

@end