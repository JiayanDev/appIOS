//
// Created by zcw on 15/8/12.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "MLWebRedirectPusher.h"
#import "DiaryDetailVC.h"
#import "DiaryModel.h"
#import "URLParser.h"
#import "TopicModel.h"
#import "TimeLineVCB.h"
#import "GeneralWebVC.h"


@implementation MLWebRedirectPusher {

}


+(BOOL)pushWithUrl:(NSURL*)url viewController:(UIViewController *)vc{
    if([url.path isEqualToString:@"/html/diary.html"]){
        DiaryDetailVC *svc= [[DiaryDetailVC alloc] init];
        svc.type=WebviewWithCommentVcDetailTypeDiary;
        DiaryModel *diary= [[DiaryModel alloc] init];
        diary.id= (NSUInteger) [[[[URLParser alloc] initWithURLString:[url absoluteString]] valueForVariable:@"id"] longLongValue];
        svc.diary=diary;
        [vc.navigationController pushViewController:svc animated:YES];
        return YES;
    }else if([url.path isEqualToString:@"/html/diary.html"]){
        DiaryDetailVC *svc= [[DiaryDetailVC alloc] init];
        svc.type=WebviewWithCommentVcDetailTypeDiary;
        TopicModel *topic= [[TopicModel alloc] init];
        topic.id= (NSUInteger) [[[[URLParser alloc] initWithURLString:[url absoluteString]] valueForVariable:@"id"] longLongValue];
        svc.topic=topic;
        [vc.navigationController pushViewController:svc animated:YES];
        return YES;
    }else if([url.path isEqualToString:@"/html/topic.html"]){
        DiaryDetailVC *svc= [[DiaryDetailVC alloc] init];
        svc.type=WebviewWithCommentVcDetailTypeTopic;
        TopicModel *topic= [[TopicModel alloc] init];
        topic.id= (NSUInteger) [[[[URLParser alloc] initWithURLString:[url absoluteString]] valueForVariable:@"id"] longLongValue];
        svc.topic=topic;
        [vc.navigationController pushViewController:svc animated:YES];
        return YES;
    }else if([url.path isEqualToString:@"/html/timeline.html"]){
        TimeLineVCB *svc= [[TimeLineVCB alloc] init];
        svc.userId= @([[[[URLParser alloc] initWithURLString:[url absoluteString]] valueForVariable:@"id"] longLongValue]);

        [vc.navigationController pushViewController:svc animated:YES];
        return YES;
    }else{
        GeneralWebVC *wvc= [[GeneralWebVC alloc] init];
        wvc.url=url;
        [vc.navigationController pushViewController:wvc animated:YES];
        return YES;
    }

    return NO;

}
@end