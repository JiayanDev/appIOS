//
// Created by zcw on 15/7/3.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"


@interface RespondModel : JSONModel
@property NSInteger code;
@property NSDictionary <Optional>*data;
@property NSString <Optional>*msg;
@end