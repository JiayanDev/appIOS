//
// Created by zcw on 15/7/16.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>


@interface UserModel : JSONModel
@property (nonatomic, assign)NSUInteger id;
@property (nonatomic, strong)NSString <Optional>* name;
@property (nonatomic, strong)NSString <Optional>*avatar;
@property (nonatomic, strong)NSNumber <Optional>*gender;
@property (nonatomic, strong)NSString <Optional>*province;
@property (nonatomic, strong)NSString <Optional>*city;

@end