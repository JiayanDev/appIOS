//
// Created by zcw on 15/8/2.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"



@protocol AreaSelectModel
@end

#define kAreaLevelSheng @"sheng"
#define kAreaLevelShi @"shi"

@interface AreaSelectModel : JSONModel
@property (nonatomic, assign)NSString *level;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSArray <AreaSelectModel,Optional>*children;
@end