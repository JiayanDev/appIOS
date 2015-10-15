//
// Created by zcw on 15/10/15.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLXLformVC.h"


@interface SuggestionsVCB : MLXLformVC<XLFormRowDescriptorViewController>
@property (nonatomic) XLFormRowDescriptor * rowDescriptor;
@property(nonatomic, strong) UIButton *buttonSubmit;
@end