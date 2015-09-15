//
// Created by zcw on 15/9/16.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"


@interface MessageNoticingModel : JSONModel
@property (nonatomic, assign) NSUInteger id;

@property (nonatomic, assign) NSNumber <Optional> *  createTime;

@property (nonatomic, assign) NSNumber <Optional> *  fromUserId;
@property (nonatomic, strong) NSString <Optional> * fromUserName;

@property (nonatomic, strong) NSString <Optional> * fromUserAvatar;




@property (nonatomic, strong) NSString <Optional> * action;



@property (nonatomic, strong) NSString <Optional> * msg;
@property (nonatomic, assign) NSNumber <Optional> *  code;
@property (nonatomic, strong) NSString <Optional> * data;




//#以下当消息类型为评论某个项目时才返回
@property (nonatomic, assign) NSNumber <Optional> *  commentId;
@property (nonatomic, strong) NSString <Optional> * commentContent;


@property (nonatomic, assign) NSNumber <Optional> *  subjectId;
@property (nonatomic, strong) NSString <Optional> * subject;
@property (nonatomic, strong) NSString <Optional> * subjectContent;

@end