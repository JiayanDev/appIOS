//
//  MyBanMeiListTVC.m
//  meiLiTianShi
//
//  Created by zcw on 15/7/30.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "MyBanMeiListTVC.h"
#import "PageIndicator.h"
#import "MJRefreshAutoNormalFooter.h"
#import "UIScrollView+MJRefresh.h"
#import "MBProgressHUD.h"
#import "MLSession.h"
#import "EventModel.h"
#import "TSMessage.h"
#import "MyBanMeiCell.h"
#import "CategoryModel.h"

#import "NSDate+XLformPushDisplay.h"


@interface MyBanMeiListTVC ()
@property (strong, nonatomic)NSMutableArray *tableData;
@property (nonatomic, strong)PageIndicator *pageIndicator;
@end

#define kBanmeiCell @"banmeicell"
@implementation MyBanMeiListTVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableData=[NSMutableArray array];

    self.pageIndicator= [[PageIndicator alloc] init];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                                 refreshingAction:@selector(dragUp)];

    [self.tableView registerClass:[MyBanMeiCell class] forCellReuseIdentifier:kBanmeiCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyBanMeiCell"
                                               bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kBanmeiCell];

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
                                                           self.pageIndicator=[PageIndicator initWithMaxId:@(((EventModel *)self.tableData[self.tableData.count-1]).id)];


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

    MyBanMeiCell *cell=[self.tableView dequeueReusableCellWithIdentifier:kBanmeiCell];
    EventModel *data=self.tableData[indexPath.section];
    cell.title.text= [NSString stringWithFormat:@"%@-%@",data.userName,[CategoryModel stringWithIdArray:data.categoryIds]];
    cell.doctorAndHospital.text=[NSString stringWithFormat:@"%@ %@",data.hospitalName,data.doctorName];
    cell.timePoint.text= [[NSDate dateWithTimeIntervalSince1970:[data.beginTime unsignedIntegerValue]] displayTextWithDateAndHHMM];
    cell.status.text=data.applyStatus;

    return cell;


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

@end
