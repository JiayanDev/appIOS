//
//  TopicListVC.m
//  meiLiTianShi
//
//  Created by zcw on 15/7/3.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "TopicListVC.h"
#import "TopicListCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "TopicModel.h"
#import "MLSession.h"
#import "PageIndicator.h"
#import "TSMessage.h"

@interface TopicListVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)NSMutableArray *tableData;
@property (nonatomic, strong)PageIndicator *pageIndicator;
@end

#define kCellTopic @"topic_cell"

@implementation TopicListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableData=[NSMutableArray array];
    [self.tableView registerClass:[TopicListCell class] forCellReuseIdentifier:kCellTopic];
    [self.tableView registerNib:[UINib nibWithNibName:@"TopicListCell" bundle:nil]
         forCellReuseIdentifier:kCellTopic];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.pageIndicator= [[PageIndicator alloc] init];
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)getData{
    [[MLSession current] getTopicListWithPageIndicator:self.pageIndicator
                                               success:^(NSArray *array) {
                                                   [self.tableData addObjectsFromArray:array];
                                                   [self.tableView reloadData];
                                               } fail:^(NSInteger i, id o) {
                    [TSMessage showNotificationWithTitle:@"出错了"
                                                subtitle:[NSString stringWithFormat:@"%d - %@",i,o]
                                                    type:TSMessageNotificationTypeError];
            }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TopicModel *data=self.tableData[indexPath.row];
    TopicListCell *cell= [self.tableView dequeueReusableCellWithIdentifier:kCellTopic];
    cell.contentLabel.text=data.content;
    //cell.image1

    cell.downLabel.text= [NSString stringWithFormat:@"评论:%@ 赞:%@",@(data.commentCount),@(data.likeCount)];

    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:kCellTopic configuration:^(id cell) {
        TopicModel *data=self.tableData[indexPath.row];
        TopicListCell * c=(TopicListCell *)cell;
        c.contentLabel.text=data.content;
        //cell.image1

        c.downLabel.text= [NSString stringWithFormat:@"评论:%@ 赞:%@",@(data.commentCount),@(data.likeCount)];

        cell=c;
    }];
}




@end
