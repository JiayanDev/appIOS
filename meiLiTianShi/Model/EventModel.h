//
// Created by zcw on 15/7/19.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"


@interface EventModel : JSONModel
@property (nonatomic, assign) NSUInteger id;
@property (nonatomic, strong)NSNumber <Optional>*eventId;// for index
@property (nonatomic, strong) NSString <Optional>*categoryName;
//@property (nonatomic, strong) NSNumber <Optional>* hospitalId;
@property (nonatomic, strong) NSNumber <Optional>* hasLike;
@property (nonatomic, strong) NSArray<Optional> *categoryIds;
@property (nonatomic, strong) NSString <Optional>*province;
@property (nonatomic, strong) NSString <Optional>*applyBeginTime;
//@property (nonatomic, strong) NSString <Optional>*desc;
@property (nonatomic, strong) NSString <Optional>*hospitalName;
@property (nonatomic, strong) NSNumber <Optional>* userId;
//@property (nonatomic, strong) NSString  <Optional>* userName123;
//
//@property (nonatomic, assign) NSString  <Optional>* userName456;
@property (nonatomic, strong) NSString <Optional>*doctorName;
@property (nonatomic, strong) NSNumber <Optional>* doctorId;

@property (nonatomic, strong) NSString <Optional>*doctorAvatar; // for index
@property (nonatomic, strong) NSString <Optional>*doctorDesc; // for index
@property (nonatomic, strong) NSString <Optional>*status; // for index

@property (nonatomic, strong)NSString <Optional>*thumbnailImg;

@property (nonatomic, strong) NSString <Optional>*city;
@property (nonatomic, strong) NSString <Optional>*district;
@property (nonatomic, strong) NSString <Optional>*addr;


@property (nonatomic, strong) NSNumber <Optional>* applymentCount;
@property (nonatomic, strong) NSNumber <Optional>* commentCount;
@property (nonatomic, strong) NSNumber <Optional>* likeCount;
@property (nonatomic, strong) NSNumber  <Optional>*beginTime;


@property (nonatomic, strong) NSArray <Optional>*photo;

//伴美状态
@property (nonatomic, strong)NSString <Optional>*applyStatus;

//for index page
@property (nonatomic, strong)NSString <Optional>*coverImg;
@property (nonatomic, strong)NSString <Optional>*title;
@property (nonatomic, strong) NSString  <Optional>* userName;
//@property (nonatomic, strong)NSString <Optional>*desc;
+ (EventModel *)randomOne;

- (BOOL)isActiveStatus;

- (NSString *)statusForRead;
@end