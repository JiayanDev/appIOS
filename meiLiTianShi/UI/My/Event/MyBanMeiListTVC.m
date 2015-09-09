//
//  MyBanMeiListTVC.m
//  meiLiTianShi
//
//  Created by zcw on 15/7/30.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>
#import "MyBanMeiListTVC.h"
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
#import "MyBanMeiCellB.h"
#import "MLStyleManager.h"


@interface MyBanMeiListTVC ()
@property (strong, nonatomic)NSMutableArray *tableData;
@property (nonatomic, strong)PageIndicator *pageIndicator;
@end

#define kBanmeiCell @"banmeicell"
@implementation MyBanMeiListTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的伴美";
    self.tableData=[NSMutableArray array];

    self.pageIndicator= [[PageIndicator alloc] init];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                                 refreshingAction:@selector(dragUp)];

    [self.tableView registerClass:[MyBanMeiCellB class] forCellReuseIdentifier:kBanmeiCell];

    [self getDataWithScrollingToTop:NO];
    [MLStyleManager removeBackTextForNextScene:self];

}


-(void)dragUp{
    [self getDataWithScrollingToTop:NO];

}

- (void)getDataWithScrollingToTop:(BOOL)gotoTop {
    [MBProgressHUD showHUDAddedTo:self.view
                         animated:YES];

    [[MLSession current] getMyBanMeiEventListWithPageIndicator:self.pageIndicator
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
    return self.tableData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView :(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MyBanMeiCellB *cell=[self.tableView dequeueReusableCellWithIdentifier:kBanmeiCell];
    EventModel *data=self.tableData[indexPath.section];
    cell.thumbImageView.backgroundColor=THEME_COLOR_TEXT_LIGHT_GRAY;
    if(data.thumbnailImg){
        [cell.thumbImageView sd_setImageWithURL:[NSURL URLWithString:data.thumbnailImg]];
    }
    cell.titleLabel.text= [NSString stringWithFormat:@"%@-%@",data.userName,[CategoryModel stringWithIdArray:data.categoryIds]];
    cell.descLabel.text=[CategoryModel stringWithIdArray:data.categoryIds];
    cell.timeLabel.text= [[NSDate dateWithTimeIntervalSince1970:[data.beginTime unsignedIntegerValue]] displayTextWithDateAndHHMM];
    cell.statusLable.text=data.applyStatus;
    if(YES){
        cell.pingjiaButton.hidden=YES;
        cell.statusLable.hidden=NO;
    }else{
        cell.pingjiaButton.hidden=NO;
        cell.statusLable.hidden=YES;
    }

    return cell;


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.tableView fd_heightForCellWithIdentifier:kBanmeiCell configuration:^(id cell) {

    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EventModel *d=self.tableData[indexPath.section];
    EventDetailVC *vc= [[EventDetailVC alloc] init];
    vc.event=d;
    [self.navigationController pushViewController:vc
                                         animated:YES];
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}
@end
