//
//  DiaryDetailVC.h
//  meiLiTianShi
//
//  Created by zcw on 15/7/15.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "SLKTextViewController.h"
#import "IDMPhotoBrowser.h"
typedef NS_ENUM(NSUInteger,WebviewWithCommentVcDetailType){
    WebviewWithCommentVcDetailTypeDiary,
    WebviewWithCommentVcDetailTypeTopic,
};

@class DiaryModel;
@class TopicModel;
@class TopicListVC;

@interface DiaryDetailVC : SLKTextViewController <UIWebViewDelegate, IDMPhotoBrowserDelegate>
@property (nonatomic, assign)WebviewWithCommentVcDetailType type;
@property (nonatomic, strong)DiaryModel *diary;
@property (nonatomic, strong)TopicModel *topic;

@end
