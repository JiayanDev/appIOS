//
//  AvatarTCell.h
//  meiLiTianShi
//
//  Created by zcw on 15/7/23.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLFormBaseCell.h"
extern NSString * const XLFormRowDescriptorTypeAvatar;

@interface AvatarTCell : XLFormBaseCell
@property (weak, nonatomic) IBOutlet UIImageView *avatar;

@end
