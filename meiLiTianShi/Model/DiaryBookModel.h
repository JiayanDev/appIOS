//
// Created by zcw on 15/7/7.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
#import "MLJsonModel.h"

@class CategoriesArrayWrap;


@interface DiaryBookModel : MLJsonModel
@property(nonatomic, assign) NSUInteger id;
@property(nonatomic, strong) NSNumber <Optional> *hospitalId;
@property(nonatomic, strong) NSString <Optional> *hospitalName;
@property(nonatomic, strong) NSArray <Optional> *previousPhotoes;
//@property (nonatomic, strong) NSNumber <Optional>*projectId;

@property(nonatomic, strong) NSNumber <Optional> *price;
@property(nonatomic, strong) NSArray *categoryIds;

@property(nonatomic, strong) CategoriesArrayWrap <Ignore> *categories;
@property(nonatomic, strong) NSNumber <Optional> *doctorId;
@property(nonatomic, strong) NSString <Optional> *doctorName;
@property(nonatomic, strong) NSString <Optional> *currentPhoto;
@property(nonatomic, strong) NSNumber <Optional> *createTime;
@property(nonatomic, strong) NSNumber <Optional> *operationTime;
@property (nonatomic, strong)NSNumber <Optional> *satisfyLevel;

@property(nonatomic, strong) NSDate <Ignore> *operationTimeNSDate;

+ (id)randomOne;
@end