//
//  AboutUsVC.h
//  meiLiTianShi
//
//  Created by zcw on 15/7/27.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLFormRowDescriptor.h"

@interface AboutUsVC : UIViewController<XLFormRowDescriptorViewController>
@property (nonatomic) XLFormRowDescriptor * rowDescriptor;

@property(nonatomic, strong) UIImageView *logo;
@property(nonatomic, strong) UILabel *versionLabel;
@property(nonatomic, strong) UIButton *qqButton;
@property(nonatomic, strong) UIButton *phoneButton;
@property(nonatomic, strong) UILabel *bottomCLabel;
@end
