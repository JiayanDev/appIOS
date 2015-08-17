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
#import "DiaryDetailVC.h"
#import "UIImage+Color.h"
#import "HexColor.h"
#import "MLStyleManager.h"

@interface IndexTVC ()
@property (strong, nonatomic)NSMutableArray *tableData;
@end
#define kIndexCell @"indexcell"
@implementation IndexTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"阿赫";
    self.tableData=[NSMutableArray array];
    [self.tableView registerClass:[IndexCell class] forCellReuseIdentifier:kIndexCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"IndexCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kIndexCell];
    [self getData];


    [MLStyleManager styleTheNavigationBar:self.navigationController.navigationBar];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;


}


- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
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
        DiaryDetailVC *vc= [[DiaryDetailVC alloc] init];
        vc.type=WebviewWithCommentVcDetailTypeTopic;
        vc.topic=data;
        [self.navigationController pushViewController:vc animated:YES];

    }else{
        EventModel *data=self.tableData[indexPath.section];

        EventDetailVC *vc=[[EventDetailVC alloc]init];
        vc.event=data;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
