//
//  AvatarDetailVC.h
//  meiLiTianShi
//
//  Created by zcw on 15/8/3.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLFormRowDescriptor.h"

@interface AvatarDetailVC : UIViewController <XLFormRowDescriptorViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic) XLFormRowDescriptor * rowDescriptor;

@end
