//
//  MyMeiLiTianShiVC.m
//  meiLiTianShi
//
//  Created by zcw on 15/7/30.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>
#import <XLForm/NSObject+XLFormAdditions.h>
#import "MyMeiLiTianShiVC.h"
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
#import "UIButton+MLStyle.h"
#import "ShenQingMLTS_FVC.h"
#import "MLStyleManager.h"
#import "MyMLTSCell.h"
#import "NSNumber+MLUtil.h"
#import "NSObject+MLUtil.h"
#import "NSString+jsonUtil.h"

@interface MyMeiLiTianShiVC ()

@property (strong, nonatomic)NSMutableArray *tableData;
@property (nonatomic, strong)PageIndicator *pageIndicator;
@property (nonatomic, strong)UIButton *button;

@end
#define kBanmeiCell @"banmeicell"

@implementation MyMeiLiTianShiVC

- (instancetype)init {
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"美丽天使";
    self.automaticallyAdjustsScrollViewInsets=YES;

    self.tableData=[NSMutableArray array];

    self.pageIndicator= [[PageIndicator alloc] init];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                                 refreshingAction:@selector(dragUp)];
    [((MJRefreshAutoNormalFooter*)self.tableView.footer) setTitle:@"" forState:MJRefreshStateNoMoreData];
    [self.tableView registerClass:[MyMLTSCell class] forCellReuseIdentifier:kBanmeiCell];
//    [self.tableView registerNib:[UINib nibWithNibName:@"MyBanMeiCell"
//                                               bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kBanmeiCell];

    [self getDataWithScrollingToTop:NO];


    self.button=[UIButton newSquareSolidButtonWithTitle:@"成为美丽天使"];
    [self.button addTarget:self
                    action:@selector(applyNewPress:) forControlEvents:UIControlEventTouchUpInside];

    [self.tableView addSubview:self.button];
    self.fixedBottomView=self.button;

    [MLStyleManager removeBackTextForNextScene:self];
}




-(void)dragUp{
    [self getDataWithScrollingToTop:NO];

}

- (void)getDataWithScrollingToTop:(BOOL)gotoTop {
    [MBProgressHUD showHUDAddedTo:self.view
                         animated:YES];

    [[MLSession current] getMyMeilitianshiEventListWithPageIndicator:self.pageIndicator
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

    MyMLTSCell *cell=[self.tableView dequeueReusableCellWithIdentifier:kBanmeiCell];
    EventModel *data=self.tableData[indexPath.section];

    ((UIImageView *)cell.lefts[0]).image=[UIImage imageNamed:@"活动名称.png"];
    ((UIImageView *)cell.lefts[1]).image=[UIImage imageNamed:@"活动地点.png"];
    ((UIImageView *)cell.lefts[2]).image=[UIImage imageNamed:@"活动时间.png"];
    ((UILabel *)cell.rights[0]).text= [data.title selfOrBlankWithReplacing:[CategoryModel stringWithIdArray:data.categoryIds]];//[NSString stringWithFormat:@"%@-%@",data.userName,[CategoryModel stringWithIdArray:data.categoryIds]];
    NSString *t=[data.hospitalName selfOrBlankWithReplacing:@"暂未确定医院"];
    if(!t){
        t=@"暂未确定医院";
    }
    ((UILabel *)cell.rights[1]).text= t;
    ((UILabel *)cell.rights[2]).text= [[NSDate dateWithTimeIntervalSince1970:[data.createTime unsignedIntegerValue]] displayTextWithDateAndHHMM];

    cell.statusLabel.text= [data statusForRead];


//
//    cell.doctorAndHospital.text=[NSString stringWithFormat:@"%@ %@",data.hospitalName,data.doctorName];
//    cell.timePoint.text= [[NSDate dateWithTimeIntervalSince1970:[data.beginTime unsignedIntegerValue]] displayTextWithDateAndHHMM];
//    cell.status.text=data.applyStatus;

    return cell;


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.tableView fd_heightForCellWithIdentifier:kBanmeiCell configuration:^(id cell) {

    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EventModel *d=self.tableData[indexPath.section];
    if(![d isValidatedOk]){
        [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
        return;
    }
    EventDetailVC *vc= [[EventDetailVC alloc] init];
    vc.eventId=[d.eventId unsignedIntegerValue];
    [self.navigationController pushViewController:vc
                                         animated:YES];
}


- (IBAction)applyNewPress:(id)sender {
    ShenQingMLTS_FVC * shenQingMLTSFvc=[ShenQingMLTS_FVC new];
    shenQingMLTSFvc.parentVC=self;
    [self.navigationController pushViewController:shenQingMLTSFvc animated:YES];
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}


- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
    UIWebView *webView=[UIWebView new];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://apptest.jiayantech.com/html/aboutmlts.html"]]];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCREEN_HEIGHT);
    }];
    return webView;
}


@end
