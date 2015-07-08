//
// Created by zcw on 15/7/7.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>


@interface DiaryBookModel : JSONModel
@property (nonatomic, assign) NSUInteger id;
@property (nonatomic, strong) NSNumber <Optional>*hospitalId;
@property (nonatomic, strong) NSString *hospitalName;
@property (nonatomic, strong) NSArray <Optional>*previousPhotoes;
//@property (nonatomic, strong) NSNumber <Optional>*projectId;

@property (nonatomic, assign) NSNumber <Optional>* price;
@property (nonatomic, strong) NSArray *categoryIds;
@property (nonatomic, strong) NSNumber <Optional>*doctorId;
@property (nonatomic, strong) NSString *doctorName;
@property (nonatomic, strong) NSString <Optional>*currentPhoto;
@property (nonatomic, assign) NSNumber <Optional>* createTime;
@property (nonatomic, assign) NSNumber <Optional>* operationTime;

+ (id)randomOne;
@end