//
// Created by zcw on 15/9/13.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLStyledTableVC.h"
#import "XLFormRowDescriptor.h"


@interface CateSelectVC :  MLStyledTableVC <XLFormRowDescriptorViewController>
@property (nonatomic) XLFormRowDescriptor * rowDescriptor;
@end