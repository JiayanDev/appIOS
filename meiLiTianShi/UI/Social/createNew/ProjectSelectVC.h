//
//  ProjectSelectVC.h
//  meiLiTianShi
//
//  Created by zcw on 15/7/9.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLFormRowDescriptor.h"


@interface ProjectSelectVC : UIViewController<XLFormRowDescriptorViewController, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign)BOOL isFirstStep;
@property (nonatomic) XLFormRowDescriptor * rowDescriptor;

@end
