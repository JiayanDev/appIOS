//
//  DoctorSelectVC.m
//  meiLiTianShi
//
//  Created by zcw on 15/7/14.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <MJRefresh/MJRefreshAutoNormalFooter.h>
#import "DoctorSelectVC.h"
#import "PageIndicator.h"
#import "MLSession.h"
#import "DoctorModel.h"
#import "TSMessage.h"
#import "UIScrollView+MJRefresh.h"


@interface DoctorSelectVC ()
@property (weak, nonatomic) IBOutlet UITextField *input;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)PageIndicator *pageIndicator;
@property (nonatomic, strong)NSMutableArray *tableData;
@end

@implementation DoctorSelectVC

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

-(void)dragUp{
    [self getDataWithScrollingToTop:NO];

}

- (void)getDataWithScrollingToTop:(BOOL)gotoTop {
    [[MLSession current] getDoctorWithBlurName:self.input.text
                                   pageIndicator:self.pageIndicator
                                         success:^(NSArray *array) {
                                             [self.tableView.footer endRefreshing];

                                             [self.tableData addObjectsFromArray:array];
                                             [self.tableView reloadData];
                                             self.pageIndicator=[PageIndicator initWithMaxId:@(((DoctorModel *)self.tableData[self.tableData.count-1]).id)];
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
    DoctorModel *data=self.tableData[indexPath.row];
    UITableViewCell *cell= [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text=data.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.rowDescriptor.value=self.tableData[indexPath.row];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
