//
//  MyMeiLiTianShiVC.h
//  meiLiTianShi
//
//  Created by zcw on 15/7/30.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XLFormRowDescriptor.h"
#import "MLStyledTableVC.h"

@interface MyMeiLiTianShiVC : MLStyledTableVC <XLFormRowDescriptorViewController>
@property (nonatomic) XLFormRowDescriptor * rowDescriptor;

@end
