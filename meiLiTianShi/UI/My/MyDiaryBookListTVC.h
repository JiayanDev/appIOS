//
//  MyDiaryBookListTVC.h
//  meiLiTianShi
//
//  Created by zcw on 15/7/7.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLFormRowDescriptor.h"


@interface MyDiaryBookListTVC : UITableViewController<XLFormRowDescriptorViewController>
@property (nonatomic) XLFormRowDescriptor * rowDescriptor;
@end
