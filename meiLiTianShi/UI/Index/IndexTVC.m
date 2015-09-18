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
#import "UIImageView+MLStyle.h"
#import "UIImage+Resizing.h"

@interface IndexTVC ()
@property (strong, nonatomic)NSMutableArray *tableData;
@end
#define kIndexCellEvent @"indexcellevent"
#define kIndexCellOther @"indexcellother"
@implementation IndexTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"佳妍";
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

//
//- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
//    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
//        return (UIImageView *)view;
//    }
//    for (UIView *subview in view.subviews) {
//        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
//        if (imageView) {
//            return imageView;
//        }
//    }
//    return nil;
//}



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

        IndexCellOfOthers*cell= [self.tableView dequeueReusableCellWithIdentifier:kIndexCellOther];
        TopicModel *data=self.tableData[indexPath.section];
//        cell.title.text=[NSString stringWithFormat:@"huati: %@",data.title];
//        cell.desc.text=[NSString stringWithFormat:@"huati: %@",data.desc];
        if(data.coverImg){
            if(cell.backImage.image){
                [cell.backImage sd_setImageWithURL:data.coverImg];
            }else{
            [cell.backImage sd_setImageWithURL:data.coverImg
                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                         [cell.backImage setImageWithFadeIn:[image scaleToCoverSize:CGSizeMake(cell.backImage.frame.size.width*2,cell.backImage.frame.size.height*2)]];
//                                         [cell.backImage setNeedsDisplay];
                                     }];
            }
        }else{
            cell.backImage.backgroundColor=THEME_COLOR;
        }
        return cell;
    }else{
        EventModel *data=self.tableData[indexPath.section];

        IndexCellPR  *cell=[self.tableView dequeueReusableCellWithIdentifier:kIndexCellEvent];
        if(data.coverImg){
            if(cell.backImage.image){
                [cell.backImage sd_setImageWithURL:data.coverImg];
            }else{
                [cell.backImage sd_setImageWithURL:data.coverImg
                                         completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                             [cell.backImage setImageWithFadeIn:[image scaleToCoverSize:CGSizeMake(cell.backImage.frame.size.width*2,cell.backImage.frame.size.height*2)]];
//                                         [cell.backImage setNeedsDisplay];
                                         }];
            }
        }else{
            cell.backImage.backgroundColor=THEME_COLOR;
        }

        if(data.doctorAvatar){
            [cell.doctorAvatar sd_setImageWithURL:data.doctorAvatar];
        }else{
            cell.doctorAvatar.backgroundColor=THEME_COLOR_TEXT_LIGHT_GRAY;
        }

        cell.doctorNameLabel.text=data.doctorName;
        cell.doctorDescLabel.text=data.doctorDesc;
        cell.statusLabel.text=data.status;


        return cell;
    }

    

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if([self.tableData[indexPath.section] isKindOfClass:[TopicModel class]]){
        return [IndexCellOfOthers cellHeight];
        return [tableView fd_heightForCellWithIdentifier:kIndexCellOther cacheByIndexPath:indexPath configuration:nil];
        return [tableView fd_heightForCellWithIdentifier:kIndexCellOther cacheByIndexPath:indexPath configuration:^(id cell) {
//        id data = self.tableData[indexPath.section];
//        [self setTheCell:cell withData:data];


        }];
    }else{
        return [IndexCellPR cellHeight];
        return [tableView fd_heightForCellWithIdentifier:kIndexCellEvent cacheByIndexPath:indexPath configuration:nil];
        return [tableView fd_heightForCellWithIdentifier:kIndexCellEvent cacheByIndexPath:indexPath configuration:^(id cell) {
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
        vc.eventId= [data.eventId unsignedIntegerValue];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
