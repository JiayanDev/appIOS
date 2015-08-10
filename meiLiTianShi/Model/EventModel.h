//
// Created by zcw on 15/7/19.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"


@interface EventModel : JSONModel
@property (nonatomic, assign) NSUInteger id;
@property (nonatomic, strong) NSString <Optional>*categoryName;
//@property (nonatomic, assign) NSNumber <Optional>* hospitalId;
@property (nonatomic, assign) NSNumber <Optional>* hasLike;
@property (nonatomic, strong) NSArray<Optional> *categoryIds;
@property (nonatomic, strong) NSString <Optional>*province;
@property (nonatomic, strong) NSString <Optional>*applyBeginTime;
@property (nonatomic, strong) NSString <Optional>*desc;
@property (nonatomic, strong) NSString <Optional>*hospitalName;
@property (nonatomic, assign) NSNumber <Optional>* userId;
@property (nonatomic, assign) NSString  <Optional>* userName;
@property (nonatomic, strong) NSString <Optional>*doctorName;
//@property (nonatomic, assign) NSNumber <Optional>* doctorId;
@property (nonatomic, strong) NSString <Optional>*city;
@property (nonatomic, strong) NSString <Optional>*district;
@property (nonatomic, strong) NSString <Optional>*addr;


@property (nonatomic, assign) NSNumber <Optional>* applymentCount;
@property (nonatomic, assign) NSNumber <Optional>* commentCount;
@property (nonatomic, assign) NSNumber <Optional>* likeCount;
@property (nonatomic, strong) NSNumber  <Optional>*beginTime;


@property (nonatomic, strong) NSArray <Optional>*photo;

//伴美状态
@property (nonatomic, strong)NSString <Optional>*applyStatus;

//for index page
@property (nonatomic, strong)NSString <Optional>*coverImg;
@property (nonatomic, strong)NSString <Optional>*title;
//@property (nonatomic, strong)NSString <Optional>*desc;
+ (EventModel *)randomOne;
@end