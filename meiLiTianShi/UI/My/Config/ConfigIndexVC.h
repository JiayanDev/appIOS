//
//  ConfigIndexVC.h
//  meiLiTianShi
//
//  Created by zcw on 15/7/26.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "XLFormViewController.h"
#import "MLXLformVC.h"

@interface ConfigIndexVC : MLXLformVC<XLFormRowDescriptorViewController>
@property (nonatomic) XLFormRowDescriptor * rowDescriptor;

@end
