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
#import "DiaryBookModel.h"
#import "MBProgressHUD.h"
#import "MJRefreshAutoNormalFooter.h"
#import "UIScrollView+MJRefresh.h"
#import "CreateDiaryBookFVC.h"
#import "ProjectSelectVC.h"
#import "DiaryModel.h"
#import "DiaryDetailVC.h"

@interface TopicListVC ()
@property (strong, nonatomic) IBOutlet UISegmentedControl *typeSwitcher;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)NSMutableArray *tableData;
@property (nonatomic, strong)PageIndicator *pageIndicator;
@property (nonatomic, assign)NSInteger type;
@end

#define kCellTopic @"topic_cell"
#define TYPE_DIARY 0
#define TYPE_TOPIC 1

@implementation TopicListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"话题列表";
    self.navigationItem.titleView=self.typeSwitcher;

    self.tableData=[NSMutableArray array];
    [self.tableView registerClass:[TopicListCell class] forCellReuseIdentifier:kCellTopic];
    [self.tableView registerNib:[UINib nibWithNibName:@"TopicListCell" bundle:nil]
         forCellReuseIdentifier:kCellTopic];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.estimatedRowHeight=142;
    self.pageIndicator= [[PageIndicator alloc] init];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                                 refreshingAction:@selector(dragUp)];
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                         target:self
                                                                                         action:@selector(gotoCreate)];
    [self getDataWithScrollingToTop:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)typeChanged:(id)sender {
    self.type=self.typeSwitcher.selectedSegmentIndex;
    self.tableData=[NSMutableArray array];
    self.pageIndicator=[[PageIndicator alloc]init];
    [self getDataWithScrollingToTop:YES];

}


-(void)dragUp{
    [self getDataWithScrollingToTop:NO];

}

-(void)gotoCreate{
    if(self.type== TYPE_DIARY){
        ProjectSelectVC *bvc=[[ProjectSelectVC alloc]init];
        bvc.isFirstStep=YES;
        [self.navigationController pushViewController:bvc
                                             animated:YES];
    }

}

- (void)getDataWithScrollingToTop:(BOOL)gotoTop {
    [MBProgressHUD showHUDAddedTo:self.view
                         animated:YES];
    if (self.type == TYPE_DIARY) {

        [[MLSession current] getPostListWithPageIndicator:self.pageIndicator
                                                     type:@"diary"
                                               categoryId:nil
                                                  success:^(NSArray *array) {
                                                      [MBProgressHUD hideHUDForView:self.view
                                                                           animated:YES];
                                                      [self.tableView.footer endRefreshing];

                                                      if (self.type == TYPE_DIARY) {
                                                          [self.tableData addObjectsFromArray:array];
                                                          if(array.count==0){[self.tableView.footer noticeNoMoreData];}
                                                          self.pageIndicator=[PageIndicator initWithMaxId:@(((DiaryBookModel *)self.tableData[self.tableData.count-1]).id)];

                                                          [self.tableView reloadData];
                                                          if (gotoTop){
                                                              self.tableView.contentOffset = CGPointMake(0, 0 - self.tableView.contentInset.top);
                                                          }
                                                      }
                                                  } fail:^(NSInteger i, id o) {
                    [MBProgressHUD hideHUDForView:self.view
                                         animated:YES];
                    [self.tableView.footer endRefreshing];

                    [TSMessage showNotificationWithTitle:@"出错了"
                                                subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
                                                    type:TSMessageNotificationTypeError];
                }];

//        [[MLSession current] getDiaryBookListWithPageIndicator:self.pageIndicator
//                                                       success:^(NSArray *array) {
//                                                           [MBProgressHUD hideHUDForView:self.view
//                                                                                animated:YES];
//                                                           [self.tableView.footer endRefreshing];
//
//                                                           if (self.type == TYPE_DIARY) {
//                                                               [self.tableData addObjectsFromArray:array];
//                                                               if(array.count==0){[self.tableView.footer noticeNoMoreData];}
//                                                               self.pageIndicator=[PageIndicator initWithMaxId:@(((DiaryBookModel *)self.tableData[self.tableData.count-1]).id)];
//
//                                                               [self.tableView reloadData];
//                                                               if (gotoTop){
//                                                                   self.tableView.contentOffset = CGPointMake(0, 0 - self.tableView.contentInset.top);
//                                                               }
//                                                           }
//                                                       } fail:^(NSInteger i, id o) {
//                    [MBProgressHUD hideHUDForView:self.view
//                                         animated:YES];
//                    [self.tableView.footer endRefreshing];
//
//                    [TSMessage showNotificationWithTitle:@"出错了"
//                                                subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
//                                                    type:TSMessageNotificationTypeError];
//                }];
    } else {

        [[MLSession current] getTopicListWithPageIndicator:self.pageIndicator
                                                   success:^(NSArray *array) {
                                                       [MBProgressHUD hideHUDForView:self.view
                                                                            animated:YES];
                                                       [self.tableView.footer endRefreshing];

                                                       if (self.type == TYPE_TOPIC) {
                                                           [self.tableData addObjectsFromArray:array];
                                                           if(array.count==0){[self.tableView.footer noticeNoMoreData];}
                                                           self.pageIndicator=[PageIndicator initWithMaxId:@(((TopicModel *)self.tableData[self.tableData.count-1]).id)];
                                                           [self.tableView reloadData];
                                                           if (gotoTop){
                                                               self.tableView.contentOffset = CGPointMake(0, 0 - self.tableView.contentInset.top);
                                                           }
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
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}


-(void)setTheCell:(UITableViewCell *)cell withData:(id)data{
    if([cell isKindOfClass:[TopicListCell class]]){
        TopicListCell *tcell=((TopicListCell *) cell);

        if([data isKindOfClass:[TopicModel class]]){
            TopicModel * topic=(TopicModel *)data;
            tcell.contentLabel.text=topic.content;
            tcell.downLabel.text= [NSString stringWithFormat:@"评论:%@ 赞:%@",@(topic.commentCount),@(topic.likeCount)];

        }else if([data isKindOfClass:[DiaryModel class]]){
            DiaryModel *diary=(DiaryModel *)data;
            tcell.contentLabel.text=diary.content;
            tcell.downLabel.text=@"这是一个日记";
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TopicModel *data=self.tableData[indexPath.row];
    TopicListCell *cell= [self.tableView dequeueReusableCellWithIdentifier:kCellTopic];
    [self setTheCell:cell withData:data];

    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:kCellTopic cacheByIndexPath:indexPath configuration:^(id cell) {
        TopicModel *data = self.tableData[indexPath.row];
        TopicListCell *c = (TopicListCell *) cell;
        [self setTheCell:c withData:data];

        cell = c;
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id data=self.tableData[indexPath.row];
    if([data isKindOfClass:[DiaryModel class]]){
        [self gotoDiaryDetail:data];
    }
}


-(void)gotoDiaryDetail:(DiaryModel *)diary{

    DiaryDetailVC *vc= [[DiaryDetailVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
