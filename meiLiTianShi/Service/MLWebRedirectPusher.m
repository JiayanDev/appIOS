//
// Created by zcw on 15/8/12.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "MLWebRedirectPusher.h"
#import "DiaryDetailVCB.h"
#import "DiaryModel.h"
#import "URLParser.h"
#import "TopicModel.h"
#import "TimeLineVCB.h"
#import "GeneralWebVC.h"
#import "MLSession.h"
#import "UserModel.h"
#import "MyBanMeiListTVC.h"
#import "WikiGeneralWebVC.h"


@implementation MLWebRedirectPusher {

}


+(BOOL)pushWithUrl:(NSURL*)url viewController:(UIViewController *)vc{
    if([url.path isEqualToString:@"/html/diary.html"]){
        DiaryDetailVCB *svc= [[DiaryDetailVCB alloc] init];
        svc.type=WebviewWithCommentVcDetailTypeDiary;
        DiaryModel *diary= [[DiaryModel alloc] init];
        diary.id= (NSUInteger) [[[[URLParser alloc] initWithURLString:[url absoluteString]] valueForVariable:@"id"] longLongValue];
        svc.diary=diary;
        [vc.navigationController pushViewController:svc animated:YES];
        return YES;
    }else if([url.path isEqualToString:@"/html/diary.html"]){
        DiaryDetailVCB *svc= [[DiaryDetailVCB alloc] init];
        svc.type=WebviewWithCommentVcDetailTypeDiary;
        TopicModel *topic= [[TopicModel alloc] init];
        topic.id= (NSUInteger) [[[[URLParser alloc] initWithURLString:[url absoluteString]] valueForVariable:@"id"] longLongValue];
        svc.topic=topic;
        [vc.navigationController pushViewController:svc animated:YES];
        return YES;
    }else if([url.path isEqualToString:@"/html/topic.html"]){
        DiaryDetailVCB *svc= [[DiaryDetailVCB alloc] init];
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
    }else if([url.path hasPrefix:@"/pedia"]){
        WikiGeneralWebVC *wvc= [[WikiGeneralWebVC alloc] init];
        wvc.url=url;
        [vc.navigationController pushViewController:wvc animated:YES];
        return YES;
    }else{
        GeneralWebVC *wvc= [[GeneralWebVC alloc] init];
        wvc.url=url;
        [vc.navigationController pushViewController:wvc animated:YES];
        return YES;
    }

    return NO;

}

+(BOOL)pushWithNotificationData:(NSDictionary *)noti viewController:(UIViewController *)viewController{
    if([noti[@"action"] isEqualToString:@"jump_to_web"]){
        NSString *data=noti[@"data"];
        GeneralWebVC *generalWebVC=[GeneralWebVC new];
        generalWebVC.url=[NSURL URLWithString:data];
        [viewController.navigationController pushViewController:generalWebVC animated:YES];
        return YES;



    }else if([noti[@"action"] isEqualToString:@"jump_to_page"]){
        NSDictionary *data=noti[@"data"];
        NSString *name=data[@"page"];
        if([name isEqualToString:@"diary_detail"]){

            DiaryDetailVCB *vc=[DiaryDetailVCB new];
            vc.type=WebviewWithCommentVcDetailTypeDiary;
            DiaryModel *diaryModel=[DiaryModel new];
            diaryModel.id= [data[@"id"] unsignedIntegerValue];
            vc.diary=diaryModel;
            [viewController.navigationController pushViewController:vc animated:YES];
            return YES;
        }else if([name isEqualToString:@"topic_detail"]){
            DiaryDetailVCB *vc=[DiaryDetailVCB new];
            vc.type=WebviewWithCommentVcDetailTypeTopic;
            TopicModel *topicModel=[TopicModel new];
            topicModel.id= [data[@"id"] unsignedIntegerValue];
            vc.topic=topicModel;
            [viewController.navigationController pushViewController:vc animated:YES];
            return YES;
        }else if([name isEqualToString:@"my_angel"]){
            TimeLineVCB *vc=[TimeLineVCB new];
            vc.userId= @([MLSession current].currentUser.id);
            [viewController.navigationController pushViewController:vc animated:YES];

            return YES;
        }else if([name isEqualToString:@"my_company"]){
            MyBanMeiListTVC *vc=[MyBanMeiListTVC new];
            [viewController.navigationController pushViewController:vc animated:YES];
            return YES;
        }else{

        }
    }

    return NO;
}
@end