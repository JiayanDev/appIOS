//
// Created by zcw on 15/9/16.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "NotificationListTVC.h"
#import "PageIndicator.h"

#import "MJRefreshAutoNormalFooter.h"
#import "UIScrollView+MJRefresh.h"
#import "MBProgressHUD.h"
#import "MLSession.h"
#import "EventModel.h"
#import "TSMessage.h"
//#import "MyBanMeiCell.h"
#import "CategoryModel.h"

#import "NSDate+XLformPushDisplay.h"
#import "EventDetailVC.h"
//#import "MyBanMeiCellB.h"
#import "MLStyleManager.h"
#import "NotificationListCell.h"
#import "MessageNoticingModel.h"
#import "NSNumber+MLUtil.h"
#import "MLWebRedirectPusher.h"

@interface NotificationListTVC()
@property (strong, nonatomic)NSMutableArray *tableData;
@property (nonatomic, strong)PageIndicator *pageIndicator;
@end

@implementation NotificationListTVC {

}

#define kCell @"cell_noti"


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的通知";
    self.tableData=[NSMutableArray array];

    self.pageIndicator= [[PageIndicator alloc] init];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                                 refreshingAction:@selector(dragUp)];

    [self.tableView registerClass:[NotificationListCell class] forCellReuseIdentifier:kCell];

    [self getDataWithScrollingToTop:NO];
    [MLStyleManager removeBackTextForNextScene:self];
    self.tableView.tableFooterView = [UIView new];

}


-(void)dragUp{
    [self getDataWithScrollingToTop:NO];

}

- (void)getDataWithScrollingToTop:(BOOL)gotoTop {
    [MBProgressHUD showHUDAddedTo:self.view
                         animated:YES];

    [[MLSession current] getNotificationListWithPageIndicator:self.pageIndicator
                                                       success:^(NSArray *array) {
                                                           [MBProgressHUD hideHUDForView:self.view
                                                                                animated:YES];
                                                           [self.tableView.footer endRefreshing];

                                                           [self.tableData addObjectsFromArray:array];
                                                           if(array.count==0){[self.tableView.footer noticeNoMoreData];}
                                                           else{
                                                               self.pageIndicator=[PageIndicator initWithMaxId:@(((EventModel *)self.tableData[self.tableData.count-1]).id)];
                                                               [self.tableView reloadData];
                                                           }

                                                           if (gotoTop){
                                                               self.tableView.contentOffset = CGPointMake(0, 0 - self.tableView.contentInset.top);
                                                           }
                                                       } fail:^(NSInteger i, id o) {
                [MBProgressHUD hideHUDForView:self.view
                                     animated:YES];
                [self.tableView.footer endRefreshing];
                [TSMessage showNotificationWithTitle:@"出错了"
                                            subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
                                                type:TSMessageNotificationTypeError];

            }];


}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}

-(void)setCell:(NotificationListCell *)cell withData:(MessageNoticingModel*)data{

    [cell.avatarView sd_setImageWithURL:[NSURL URLWithString:data.fromUserAvatar]];
    cell.nameLabel.text=data.fromUserName;
    cell.actionLabel.text=data.msg;
    cell.timeLabel.text= [data.createTime stringOfDateSince1970_blankTip:@"未知"];
    cell.contentLabel.text=data.commentContent;
    if(data.subject && data.subjectContent && data.subjectContent.length>0){
        [cell setTheSecondContentViews];
        cell.secondContentLabel.text=data.subjectContent;
    }else{
        [cell removeTheSecondContentViews];
        cell.secondContentImageView.hidden=YES;
    }

}

-(UITableViewCell *)tableView :(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NotificationListCell *cell=[self.tableView dequeueReusableCellWithIdentifier:kCell];
    [self setCell:cell
         withData:self.tableData[indexPath.row]];
    return cell;

//    MyBanMeiCellB *cell=[self.tableView dequeueReusableCellWithIdentifier:kBanmeiCell];
//    EventModel *data=self.tableData[indexPath.row];
//    cell.thumbImageView.backgroundColor=THEME_COLOR_TEXT_LIGHT_GRAY;
//    if(data.thumbnailImg){
//        [cell.thumbImageView sd_setImageWithURL:[NSURL URLWithString:data.thumbnailImg]];
//    }
//    cell.titleLabel.text= [NSString stringWithFormat:@"%@-%@",data.userName,[CategoryModel stringWithIdArray:data.categoryIds]];
//    cell.descLabel.text=[CategoryModel stringWithIdArray:data.categoryIds];
//    cell.timeLabel.text= [[NSDate dateWithTimeIntervalSince1970:[data.beginTime unsignedIntegerValue]] displayTextWithDateAndHHMM];
//    cell.statusLable.text=data.applyStatus;
//    if(YES){
//        cell.pingjiaButton.hidden=YES;
//        cell.statusLable.hidden=NO;
//    }else{
//        cell.pingjiaButton.hidden=NO;
//        cell.statusLable.hidden=YES;
//    }
//
//    return cell;


}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.tableView fd_heightForCellWithIdentifier:kCell configuration:^(id cell) {
        [self setCell:cell
             withData:self.tableData[indexPath.row]];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    EventModel *d=self.tableData[indexPath.row];
//    EventDetailVC *vc= [[EventDetailVC alloc] init];
//    vc.eventId=[d.eventId unsignedIntegerValue];
//    [self.navigationController pushViewController:vc
//                                         animated:YES];

    MessageNoticingModel*data=self.tableData[indexPath.row];
    [MLWebRedirectPusher pushWithNotificationData:[data toJumpableDict]
                                   viewController:self];


}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}
@end