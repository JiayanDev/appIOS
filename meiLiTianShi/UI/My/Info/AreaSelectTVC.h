//
//  AreaSelectTVC.h
//  meiLiTianShi
//
//  Created by zcw on 15/8/2.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLFormRowDescriptor.h"
#import "MLStyledTableVC.h"
#import <CoreLocation/CoreLocation.h>

@class AreaSelectModel;


@interface AreaSelectTVC : MLStyledTableVC <XLFormRowDescriptorViewController, CLLocationManagerDelegate>
@property (nonatomic) XLFormRowDescriptor * rowDescriptor;
@property (nonatomic, strong)AreaSelectModel *parent;
@end
