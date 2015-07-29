//
//  PhoneBindVC.h
//  meiLiTianShi
//
//  Created by zcw on 15/7/29.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger , PhoneBindVcType){
    PhoneBindVcType_afterWechatLogin,
    PhoneBindVcType_registerFirstStep,
    PhoneBindVcType_forgetPasswordFirstStep,
};

@interface PhoneBindVC : UIViewController
@property (nonatomic, assign)PhoneBindVcType type;

@end
