//
// Created by zcw on 15/7/6.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"


@interface TopicModel : JSONModel
@property (nonatomic, assign)NSUInteger id;
@property (nonatomic, strong)NSString<Optional> * content;
@property (nonatomic, strong)NSArray <Optional>*photoes;
@property (nonatomic, strong)NSNumber <Optional>* commentCount;
@property (nonatomic, strong)NSNumber <Optional>* likeCount;

//for index page
@property (nonatomic, strong)NSString <Optional>*coverImg;
@property (nonatomic, strong)NSString <Optional>*title;
@property (nonatomic, strong)NSString <Optional>*desc;
+ (TopicModel *)randomOne;
@end