//
// Created by zcw on 15/7/7.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>


@interface DiaryModel : JSONModel
@property (nonatomic, assign) NSUInteger commentCount;
@property (nonatomic, assign) NSUInteger id;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSArray *photoes;
@property (nonatomic, assign) NSUInteger likeCount;
@property (nonatomic, assign) NSUInteger createTime;
@end