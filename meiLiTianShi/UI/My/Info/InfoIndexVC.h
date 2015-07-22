//
// Created by zcw on 15/7/22.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XLFormRowDescriptor.h"

@interface InfoIndexVC : XLFormViewController <XLFormRowDescriptorViewController>
@property (nonatomic) XLFormRowDescriptor * rowDescriptor;
@end