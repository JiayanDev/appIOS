//
// Created by zcw on 15/7/7.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
#import "MLJsonModel.h"


@interface DiaryModel : MLJsonModel
@property (nonatomic, assign) NSUInteger commentCount;
@property (nonatomic, assign) NSUInteger id;
@property (nonatomic, strong) NSString <Optional>*content;
@property (nonatomic, strong) NSArray <Optional>*photoes;
@property (nonatomic, assign) NSUInteger likeCount;
@property (nonatomic, assign) NSUInteger createTime;

@property (nonatomic, strong) NSString <Optional>*userName;
@property (nonatomic, strong) NSNumber<Optional> *userId;
//@property (nonatomic, strong) NSArray <Optional> *categoryIds;
@end