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
//#import "IndexCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "EventDetailVC.h"
#import "DiaryDetailVC.h"
#import "UIImage+Color.h"
#import "HexColor.h"
#import "MLStyleManager.h"
#import "IndexCellPR.h"
#import "IndexCellOfOthers.h"

@interface IndexTVC ()
@property (strong, nonatomic)NSMutableArray *tableData;
@end
#define kIndexCellEvent @"indexcellevent"
#define kIndexCellOther @"indexcellother"
@implementation IndexTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"阿赫";
    self.tableData=[NSMutableArray array];
    [self.tableView registerClass:[IndexCellPR class] forCellReuseIdentifier:kIndexCellEvent];
    [self.tableView registerClass:[IndexCellOfOthers class] forCellReuseIdentifier:kIndexCellOther];
    [self getData];


    [MLStyleManager styleTheNavigationBar:self.navigationController.navigationBar];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    [MLStyleManager removeBackTextForNextScene:self];

//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];



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

    if([self.tableData[indexPath.section] isKindOfClass:[TopicModel class]]){

        IndexCellPR *cell= [self.tableView dequeueReusableCellWithIdentifier:kIndexCellEvent];
        TopicModel *data=self.tableData[indexPath.section];
//        cell.title.text=[NSString stringWithFormat:@"huati: %@",data.title];
//        cell.desc.text=[NSString stringWithFormat:@"huati: %@",data.desc];
        if(data.coverImg){
            [cell.backImage sd_setImageWithURL:data.coverImg
                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                         cell.backImage.image=image;
                                         [cell.backImage setNeedsDisplay];
                                     }];
        }else{
            cell.backImage.backgroundColor=THEME_COLOR;
        }
        return cell;
    }else{
        EventModel *data=self.tableData[indexPath.section];

        IndexCellOfOthers *cell=[self.tableView dequeueReusableCellWithIdentifier:kIndexCellOther];
        if(data.coverImg){
            [cell.backImage sd_setImageWithURL:data.coverImg
                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                         cell.backImage.image=image;
                                         [cell.backImage setNeedsDisplay];
                                     }];
        }else{
            cell.backImage.backgroundColor=THEME_COLOR;
        }
        return cell;
    }

    

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if([self.tableData[indexPath.section] isKindOfClass:[TopicModel class]]){
        return [tableView fd_heightForCellWithIdentifier:kIndexCellEvent cacheByIndexPath:indexPath configuration:^(id cell) {
//        id data = self.tableData[indexPath.section];
//        [self setTheCell:cell withData:data];


        }];
    }else{
        return [tableView fd_heightForCellWithIdentifier:kIndexCellOther cacheByIndexPath:indexPath configuration:^(id cell) {
//        id data = self.tableData[indexPath.section];
//        [self setTheCell:cell withData:data];


        }];
    }

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
