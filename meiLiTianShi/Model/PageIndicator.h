//
// Created by zcw on 15/7/6.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"


@interface PageIndicator : JSONModel
@property (nonatomic, strong)NSNumber <Optional>*sinceId;
@property (nonatomic, strong)NSNumber <Optional>*maxId;

+ (PageIndicator *)initWithSinceId:(NSNumber *)sinceId maxId:(NSNumber *)maxId;
@end