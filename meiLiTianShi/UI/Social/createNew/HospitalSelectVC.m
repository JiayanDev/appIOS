//
//  HospitalSelectVC.m
//  meiLiTianShi
//
//  Created by zcw on 15/7/13.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <MJRefresh/MJRefreshAutoNormalFooter.h>
#import "HospitalSelectVC.h"
#import "MLSession.h"
#import "PageIndicator.h"
#import "HospitalModel.h"
#import "TSMessage.h"
#import "UIScrollView+MJRefresh.h"


@interface HospitalSelectVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *onePixel;
@property (weak, nonatomic) IBOutlet UITextField *input;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)PageIndicator *pageIndicator;
@property (nonatomic, strong)NSMutableArray *tableData;

@end

@implementation HospitalSelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.onePixel.constant = 1.f/[UIScreen mainScreen].scale;//enforces it to be a true 1 pixel line
    self.tableData=[NSMutableArray array];
    self.pageIndicator=[[PageIndicator alloc]init];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                                 refreshingAction:@selector(dragUp)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)textChanged:(id)sender {
    self.tableData=[NSMutableArray array];
    self.pageIndicator=[[PageIndicator alloc]init];
    [self getDataWithScrollingToTop:YES];
}

- (void)getDataWithScrollingToTop:(BOOL)gotoTop {
    [[MLSession current] getHospitalWithBlurName:self.input.text
                                   pageIndicator:self.pageIndicator
                                         success:^(NSArray *array) {
                                             [self.tableView.footer endRefreshing];

                                             [self.tableData addObjectsFromArray:array];
                                             [self.tableView reloadData];
                                             self.pageIndicator=[PageIndicator initWithMaxId:@(((HospitalModel *)self.tableData[self.tableData.count-1]).id)];
                                             if (gotoTop){
                                                 self.tableView.contentOffset = CGPointMake(0, 0 - self.tableView.contentInset.top);
                                             }

                                         } fail:^(NSInteger i, id o) {
                [self.tableView.footer endRefreshing];

                [TSMessage showNotificationWithTitle:@"出错了"
                                            subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
                                                type:TSMessageNotificationTypeError];
            }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HospitalModel *data=self.tableData[indexPath.row];
    UITableViewCell *cell= [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text=data.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.rowDescriptor.value=self.tableData[indexPath.row];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
