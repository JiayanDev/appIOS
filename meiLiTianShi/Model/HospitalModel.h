//
// Created by zcw on 15/7/13.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>


@interface HospitalModel : JSONModel
@property (nonatomic, assign)NSUInteger id;
@property (nonatomic, strong)NSString *name;
@end