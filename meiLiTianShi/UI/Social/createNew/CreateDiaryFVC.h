//
//  CreateDiaryFVC.h
//  meiLiTianShi
//
//  Created by zcw on 15/7/9.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "XLFormViewController.h"
#import "MLXLformVC.h"

@interface CreateDiaryFVC : MLXLformVC
@property (nonatomic, assign)BOOL needToCreateNewDiaryBookLater;
@property (nonatomic, strong) NSMutableOrderedSet *categories;

@end
