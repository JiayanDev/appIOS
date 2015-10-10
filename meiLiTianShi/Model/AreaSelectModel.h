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
@property (nonatomic, strong)NSString *level;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSArray <AreaSelectModel,Optional>*children;
@property (nonatomic, strong, nullable)AreaSelectModel <Ignore>*parent;

+ (AreaSelectModel *)initAndFindPositionForName:(NSString *)name;

+ (NSArray *)list;

- (AreaSelectModel *)findForName:(NSString *)name;
@end