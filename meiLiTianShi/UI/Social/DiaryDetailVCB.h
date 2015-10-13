//
// Created by zcw on 15/10/13.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLWebViewWithCommentTextBarViewController.h"
#import "IDMPhotoBrowser.h"
typedef NS_ENUM(NSUInteger,WebviewWithCommentVcDetailType){
    WebviewWithCommentVcDetailTypeDiary,
    WebviewWithCommentVcDetailTypeTopic,
};

@class DiaryModel;
@class TopicModel;

@interface DiaryDetailVCB : MLWebViewWithCommentTextBarViewController<UIWebViewDelegate, IDMPhotoBrowserDelegate>
@property (nonatomic, assign)WebviewWithCommentVcDetailType type;
@property (nonatomic, strong)DiaryModel *diary;
@property (nonatomic, strong)TopicModel *topic;
@end