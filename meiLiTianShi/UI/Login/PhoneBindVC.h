//
//  PhoneBindVC.h
//  meiLiTianShi
//
//  Created by zcw on 15/7/29.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLSession.h"

typedef NS_ENUM(NSUInteger , PhoneBindVcType){
    PhoneBindVcType_afterWechatLogin,
    PhoneBindVcType_registerFirstStep,
    PhoneBindVcType_forgetPasswordFirstStep,
    PhoneBindVcType_bindWechatFirstStep,
    PhoneBindVcType_changePasswordFirstStep,
};

@interface PhoneBindVC : UIViewController
@property (nonatomic, assign)PhoneBindVcType type;
@property (nonatomic, strong)NSString *wxReceipt_afterWechatLogin;

- (void)handleWxAuthRespond:(SendAuthResp *)resp;
@end
