//
// Created by zcw on 15/7/16.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>


@interface WebviewRequestModel : JSONModel
@property (nonatomic, strong) NSString *success;
@property (nonatomic, strong) NSDictionary<Optional>* data;
@property (nonatomic, strong) NSString *error;
@property (nonatomic, strong) NSString *action;
@end