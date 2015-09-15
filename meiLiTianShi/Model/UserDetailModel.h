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
@property (nonatomic, strong)NSString *phone;
@property (nonatomic, assign)NSNumber <Optional>* bindWX;
@property (nonatomic, assign)NSNumber <Optional>* bindWB;
@property (nonatomic, assign)NSNumber <Optional>* bindQQ;

- (NSString *)descOfGenderAreaAge;

- (void)setGenderIconAndCityAndAgeForLabel:(UILabel *)label;
@end