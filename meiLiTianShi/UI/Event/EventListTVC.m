//
//  EventListTVC.m
//  meiLiTianShi
//
//  Created by zcw on 15/7/17.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "EventListTVC.h"
#import "MBProgressHUD.h"
#import "MLSession.h"
#import "TSMessage.h"
#import "DiaryBookModel.h"
#import "PageIndicator.h"
#import "EventModel.h"
#import "EventDetailVC.h"

@interface EventListTVC ()
@property (strong, nonatomic)NSMutableArray *tableData;
@property (nonatomic, strong)PageIndicator *pageIndicator;
@end

#define kCell @"cell"

@implementation EventListTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"活动";
    [self getDataWithScrollingToTop:YES];
    self.tableData=[NSMutableArray array];
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:kCell];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.tableData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EventModel *d=self.tableData[indexPath.section];
    UITableViewCell *cell= [self.tableView dequeueReusableCellWithIdentifier:kCell];
    cell.textLabel.text= [[d description] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EventModel *d=self.tableData[indexPath.section];
    EventDetailVC *vc= [[EventDetailVC alloc] init];
    vc.eventId=d.eventId||d.id;
    [self.navigationController pushViewController:vc
                                         animated:YES];
}


- (void)getDataWithScrollingToTop:(BOOL)gotoTop {
    [MBProgressHUD showHUDAddedTo:self.view
                         animated:YES];
    [[MLSession current] getEventsWithPageIndicator:self.pageIndicator
                                            success:^(NSArray *array) {
                                                [MBProgressHUD hideHUDForView:self.view
                                                                     animated:YES];

                                                [self.tableData addObjectsFromArray:array];
                                                [self.tableView reloadData];

                                            } fail:^(NSInteger i, id o) {
                [MBProgressHUD hideHUDForView:self.view
                                     animated:YES];
//                [self.tableView.footer endRefreshing];

                [TSMessage showNotificationWithTitle:@"出错了"
                                            subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
                                                type:TSMessageNotificationTypeError];
            }];



}


@end
