//
// Created by zcw on 15/7/6.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"


@interface TopicModel : JSONModel
@property (nonatomic, strong)NSString * content;
@property (nonatomic, strong)NSArray *photoes;
@property (nonatomic, assign)NSInteger commentCount;
@property (nonatomic, assign)NSInteger likeCount;

+ (TopicModel *)randomOne;
@end