//
// Created by zcw on 15/7/14.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>


@interface UploadTokenModel : JSONModel
@property(nonatomic, strong) NSString *policy;
@property(nonatomic, strong) NSString *signature;
@property(nonatomic, strong) NSNumber *expiration;
@end