//
// Created by zcw on 15/9/16.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLStyledTableVC.h"
#import "XLFormRowDescriptor.h"

@interface NotificationListTVC : MLStyledTableVC <XLFormRowDescriptorViewController>
@property (nonatomic) XLFormRowDescriptor * rowDescriptor;
@end