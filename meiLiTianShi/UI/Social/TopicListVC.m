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
#import "DiaryListCell.h"
#import "UIImageView+WebCache.h"
#import "CategoryModel.h"

@interface TopicListVC ()
@property (strong, nonatomic) IBOutlet UISegmentedControl *typeSwitcher;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)NSMutableArray *tableData;
@property (nonatomic, strong)PageIndicator *pageIndicator;
@property (nonatomic, assign)NSInteger type;
@end

#define kCellTopic @"topic_cell"
#define kCellDiary @"diarycell"
#define TYPE_DIARY 0
#define TYPE_TOPIC 1

@implementation TopicListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"话题列表";
    self.navigationItem.titleView=self.typeSwitcher;

    self.tableData=[NSMutableArray array];
    [self.tableView registerClass:[TopicListCell class] forCellReuseIdentifier:kCellTopic];
    [self.tableView registerNib:[UINib nibWithNibName:@"TopicListCell" bundle:nil]forCellReuseIdentifier:kCellTopic];
    [self.tableView registerClass:[DiaryListCell class] forCellReuseIdentifier:kCellDiary];
    [self.tableView registerNib:[UINib nibWithNibName:@"DiaryListCell" bundle:nil]forCellReuseIdentifier:kCellDiary];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.estimatedRowHeight=142;
    self.pageIndicator= [[PageIndicator alloc] init];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                                 refreshingAction:@selector(dragUp)];
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                         target:self
                                                                                         action:@selector(gotoCreate)];
//    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;

    [self getDataWithScrollingToTop:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tableData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


-(void)setTheCell:(UITableViewCell *)cell withData:(id)data{
    if([data isKindOfClass:[DiaryModel class]]){
        DiaryListCell *dcell=((DiaryListCell *) cell);
        DiaryModel *diary=(DiaryModel *)data;
        //[dcell.avatarView sd_setImageWithURL:diary.];

        dcell.splitLineHeightConstraint.constant=1.0 / [UIScreen mainScreen].scale;
        dcell.userNameLabel.text=diary.userName;
        dcell.userDescLabel.text=@"用户地址 用户年龄";
        dcell.diaryContentLabel.text=diary.content;

        dcell.diaryImage1.hidden= diary.photoes.count < 1;
        dcell.diaryImage2.hidden=diary.photoes.count<2;
        dcell.diaryImage3.hidden=diary.photoes.count<3;

        if(diary.photoes.count>=1){
            [dcell.diaryImage1 sd_setImageWithURL:diary.photoes[0]];
            dcell.noImageConstraint.priority=500;
            dcell.pic1up.priority=999;
            dcell.pic2up.priority=999;
            dcell.pic3up.priority=999;
//
//            dcell.pic1down.priority=999;
//            dcell.pic2down.priority=999;
//            dcell.pic3down.priority=999;
        }else{
            dcell.noImageConstraint.priority=999;
            dcell.pic1up.priority=500;
            dcell.pic2up.priority=500;
            dcell.pic3up.priority=500;
//
//            dcell.pic1down.priority=500;
//            dcell.pic2down.priority=500;
//            dcell.pic3down.priority=500;
        }

        [dcell layoutIfNeeded];

        if(diary.photoes.count>=2){
            [dcell.diaryImage2 sd_setImageWithURL:diary.photoes[1]];
        }

        if(diary.photoes.count>=3){
            [dcell.diaryImage3 sd_setImageWithURL:diary.photoes[2]];
        }

        NSMutableArray *cates=[NSMutableArray array];
        for (NSNumber *categoryId in diary.categoryIds) {
            [cates addObject:[CategoryModel stringWithId:[categoryId unsignedIntegerValue]]];
        }

        dcell.tagLabel.text= [cates componentsJoinedByString:@"，"];

        [dcell.likeButton setTitle:[NSString stringWithFormat:@"%@",@(diary.likeCount)] forState:UIControlStateNormal];
        [dcell.commentButton setTitle:[NSString stringWithFormat:@"%@",@(diary.commentCount)] forState:UIControlStateNormal];


        // Remove seperator inset
        if ([dcell respondsToSelector:@selector(setSeparatorInset:)]) {
            [dcell setSeparatorInset:UIEdgeInsetsZero];
        }

        // Prevent the cell from inheriting the Table View's margin settings
        if ([dcell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
            [dcell setPreservesSuperviewLayoutMargins:NO];
        }

        // Explictly set your cell's layout margins
        if ([dcell respondsToSelector:@selector(setLayoutMargins:)]) {
            [dcell setLayoutMargins:UIEdgeInsetsZero];
        }

//        dcell.separatorInset = UIEdgeInsetsMake(0.0f, cell.frame.size.width, 0.0f, 0.0f);

//        dcell.separatorInset

    }else if([cell isKindOfClass:[TopicListCell class]]){
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
    id data=self.tableData[indexPath.section];
    if([data isKindOfClass:[DiaryModel class]]){
        DiaryListCell *cell= [self.tableView dequeueReusableCellWithIdentifier:kCellDiary];
        [self setTheCell:cell withData:data];
        return cell;
    }else{
        TopicListCell *cell= [self.tableView dequeueReusableCellWithIdentifier:kCellTopic];
        [self setTheCell:cell withData:data];
        return cell;
    }



}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id data=self.tableData[indexPath.section];

    if([data isKindOfClass:[DiaryModel class]]){
        return [tableView fd_heightForCellWithIdentifier:kCellDiary cacheByIndexPath:indexPath configuration:^(id cell) {
            id data = self.tableData[indexPath.section];
            [self setTheCell:cell withData:data];


        }];
    }else{
        return [tableView fd_heightForCellWithIdentifier:kCellTopic cacheByIndexPath:indexPath configuration:^(id cell) {
            id data = self.tableData[indexPath.section];
            [self setTheCell:cell withData:data];


        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id data=self.tableData[indexPath.section];
    if([data isKindOfClass:[DiaryModel class]]){
        [self gotoDiaryDetail:data];
    }
}


-(void)gotoDiaryDetail:(DiaryModel *)diary{

    DiaryDetailVC *vc= [[DiaryDetailVC alloc] init];
    vc.diary=diary;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
