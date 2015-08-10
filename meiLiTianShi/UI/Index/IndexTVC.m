//
//  IndexTVC.m
//  meiLiTianShi
//
//  Created by zcw on 15/8/10.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "IndexTVC.h"
#import "MLSession.h"
#import "TSMessage.h"
#import "TopicModel.h"
#import "EventModel.h"
#import "IndexCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "EventDetailVC.h"

@interface IndexTVC ()
@property (strong, nonatomic)NSMutableArray *tableData;
@end
#define kIndexCell @"indexcell"
@implementation IndexTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"美丽天使";
    self.tableData=[NSMutableArray array];
    [self.tableView registerClass:[IndexCell class] forCellReuseIdentifier:kIndexCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"IndexCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kIndexCell];
    [self getData];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

-(void)getData{
    [[MLSession current] getIndexList_success:^(NSArray *array) {
        self.tableData= [array mutableCopy];
        [self.tableView reloadData];
    } fail:^(NSInteger i, id o) {
        [TSMessage showNotificationWithTitle:@"出错了"
                                    subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
                                        type:TSMessageNotificationTypeError];
    }];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IndexCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kIndexCell];
    if([self.tableData[indexPath.section] isKindOfClass:[TopicModel class]]){
        TopicModel *data=self.tableData[indexPath.section];
        cell.title.text=[NSString stringWithFormat:@"huati: %@",data.title];
        cell.desc.text=[NSString stringWithFormat:@"huati: %@",data.desc];
        if(data.coverImg){
            [cell.imageView sd_setImageWithURL:data.coverImg
                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                         [cell.imageView setNeedsDisplay];
                                     }];
        }
    }else{
        EventModel *data=self.tableData[indexPath.section];
        cell.title.text=[NSString stringWithFormat:@"huodong: %@",data.title];
        cell.desc.text=[NSString stringWithFormat:@"huodong: %@",data.desc];
        if(data.coverImg){
            [cell.imageView sd_setImageWithURL:data.coverImg
                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                         [cell.imageView setNeedsDisplay];
                                     }];
        }
    }

    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:kIndexCell cacheByIndexPath:indexPath configuration:^(id cell) {
//        id data = self.tableData[indexPath.section];
//        [self setTheCell:cell withData:data];


    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.tableData[indexPath.section] isKindOfClass:[TopicModel class]]){
        TopicModel *data=self.tableData[indexPath.section];


    }else{
        EventModel *data=self.tableData[indexPath.section];

        EventDetailVC *vc=[[EventDetailVC alloc]init];
        vc.event=data;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
