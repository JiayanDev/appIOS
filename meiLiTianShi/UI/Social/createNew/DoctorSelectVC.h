//
//  DoctorSelectVC.h
//  meiLiTianShi
//
//  Created by zcw on 15/7/14.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLFormRowDescriptor.h"


@interface DoctorSelectVC : UIViewController<UITableViewDataSource, UITableViewDelegate,XLFormRowDescriptorViewController>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *onePixel;
@property (nonatomic) XLFormRowDescriptor * rowDescriptor;

@end
