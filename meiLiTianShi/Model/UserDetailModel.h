//
// Created by zcw on 15/7/23.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"


@interface UserDetailModel : JSONModel
@property (nonatomic, assign)NSUInteger id;
@property (nonatomic, strong)NSString <Optional>* name;
@property (nonatomic, strong)NSString <Optional>*avatar;
@property (nonatomic, strong)NSNumber <Optional>*gender;
@property (nonatomic, strong)NSString <Optional>*province;
@property (nonatomic, strong)NSString <Optional>*city;
@property (nonatomic, strong)NSNumber <Optional>*birthday;
@property (nonatomic, assign)BOOL bindWX;
@property (nonatomic, assign)BOOL bindWB;
@property (nonatomic, assign)BOOL bindQQ;
@end