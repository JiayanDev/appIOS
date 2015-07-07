//
// Created by zcw on 15/7/7.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>


@interface DiaryBookModel : JSONModel
@property (nonatomic, assign) NSUInteger id;
@property (nonatomic, strong) NSNumber *hospitalId;
@property (nonatomic, strong) NSNumber *previousPhoto;
@property (nonatomic, strong) NSNumber *projectId;

@property (nonatomic, assign) NSNumber * price;
@property (nonatomic, strong) NSArray *categoryId;
@property (nonatomic, strong) NSNumber *doctorId;
@property (nonatomic, strong) NSString *currentPhoto;
@property (nonatomic, assign) NSUInteger createTime;
@property (nonatomic, assign) NSUInteger operationTime;
@end