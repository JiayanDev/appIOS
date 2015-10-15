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
#import "DiaryDetailVCB.h"
#import "UIImage+Color.h"
#import "HexColor.h"
#import "MLStyleManager.h"
#import "IndexCellPR.h"
#import "IndexCellOfOthers.h"
#import "UIImageView+MLStyle.h"
#import "UIImage+Resizing.h"
#import "MJRefreshNormalHeader.h"

@interface IndexTVC ()
@property (strong, nonatomic)NSMutableArray *tableData;
@property (strong, nonatomic)NSMutableArray *tableDataDisplayCaching;
@end
#define kIndexCellEvent @"indexcellevent"
#define kIndexCellOther @"indexcellother"
@implementation IndexTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"佳妍";
    UIImageView *imageView=[UIImageView new];
    imageView.image=[UIImage imageNamed:@"首页_logo.png"];

    self.navigationItem.titleView=imageView;
    CGRect frame=imageView.frame;
    frame.size=[UIImage imageNamed:@"首页_logo.png"].size;
    imageView.frame=frame;
    self.tableData=[NSMutableArray array];
    self.tableDataDisplayCaching=[NSMutableArray new];
    [self.tableView registerClass:[IndexCellPR class] forCellReuseIdentifier:kIndexCellEvent];
    [self.tableView registerClass:[IndexCellOfOthers class] forCellReuseIdentifier:kIndexCellOther];
    [self getData];


    [MLStyleManager styleTheNavigationBar:self.navigationController.navigationBar];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    [MLStyleManager removeBackTextForNextScene:self];


    self.tableView.header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(dragDown)];
    ((MJRefreshNormalHeader*)self.tableView.header).lastUpdatedTimeLabel.hidden = YES;

//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];



}


-(void)dragDown{
    self.tableData=[NSMutableArray array];
    [self getData];

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
    return self.tableDataDisplayCaching.count;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
return 1;
}

-(void)getData{
    [[MLSession current] getIndexList_success:^(NSArray *array) {
        self.tableData= [array mutableCopy];
        self.tableDataDisplayCaching=self.tableData;
        [self.tableView.header endRefreshing];
        [self.tableView reloadData];

    } fail:^(NSInteger i, id o) {
        [TSMessage showNotificationWithTitle:@"出错了"
                                    subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
                                        type:TSMessageNotificationTypeError];
        [self.tableView.header endRefreshing];
    }];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if([self.tableDataDisplayCaching[indexPath.section] isKindOfClass:[TopicModel class]]){

        IndexCellOfOthers*cell= [self.tableView dequeueReusableCellWithIdentifier:kIndexCellOther];
        TopicModel *data=self.tableDataDisplayCaching[indexPath.section];
//        cell.title.text=[NSString stringWithFormat:@"huati: %@",data.title];
//        cell.desc.text=[NSString stringWithFormat:@"huati: %@",data.desc];
        if(data.coverImg){
//            if(cell.backImage.image){
//                [cell.backImage sd_setImageWithURL:data.coverImg];
//            }else{
//            [cell.backImage sd_setImageWithURL:data.coverImg
//                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                                         [cell.backImage setImageWithFadeIn:[image scaleToCoverSize:CGSizeMake(cell.backImage.frame.size.width*2,cell.backImage.frame.size.height*2)]];
////                                         [cell.backImage setNeedsDisplay];
//                                     }];
//            }


            BOOL animated=(!self.tableView.isDragging && !self.tableView.isDecelerating);
            [cell.backImage setImageWithScalingToSelfSizeWithUrl:[NSURL URLWithString:data.coverImg]
                                                  AndWillAnimate:animated withSize:CGSizeZero];
//            if (animated) {
//                [cell.backImage sd_setImageWithURL:data.coverImg completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                        UIImage *scaledImage = [image scaleToCoverSize:CGSizeMake(cell.backImage.frame.size.width*2,cell.backImage.frame.size.height*2)];
//                        dispatch_async(dispatch_get_main_queue(),^{
//                            [cell.backImage setImageWithFadeIn:scaledImage];
//
////                    cell.backImage.image=scaledImage;
//                        });
//                    });
//
//                }];
//            } else {
//                [cell.backImage sd_setImageWithURL:data.coverImg completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                        UIImage *scaledImage = [image scaleToCoverSize:CGSizeMake(cell.backImage.frame.size.width*2,cell.backImage.frame.size.height*2)];
//                        dispatch_async(dispatch_get_main_queue(),^{
////                        [cell.backImage setImageWithFadeIn:[image scaleToCoverSize:CGSizeMake(w*2,w*2)]];
//
//                            cell.backImage.image = scaledImage;
//                        });
//                    });
//
//                }];
//            }


        }else{
            cell.backImage.backgroundColor=THEME_COLOR;
        }
        return cell;
    }else{
        EventModel *data=self.tableDataDisplayCaching[indexPath.section];

        IndexCellPR  *cell=[self.tableView dequeueReusableCellWithIdentifier:kIndexCellEvent];
        if(data.coverImg){
//            if(cell.backImage.image){
//                [cell.backImage sd_setImageWithURL:data.coverImg];
//            }else{
//                [cell.backImage sd_setImageWithURL:data.coverImg
//                                         completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                                             [cell.backImage setImageWithFadeIn:[image scaleToCoverSize:CGSizeMake(cell.backImage.frame.size.width*2,cell.backImage.frame.size.height*2)]];
////                                         [cell.backImage setNeedsDisplay];
//                                         }];
//            }

            BOOL animated=(!self.tableView.isDragging && !self.tableView.isDecelerating);
            [cell.backImage setImageWithScalingToSelfSizeWithUrl:[NSURL URLWithString:data.coverImg]
                                                  AndWillAnimate:animated  withSize:CGSizeZero];
//            if (animated) {
//                [cell.backImage sd_setImageWithURL:data.coverImg completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                        UIImage *scaledImage = [image scaleToCoverSize:CGSizeMake(cell.backImage.frame.size.width*2,cell.backImage.frame.size.height*2)];
//                        dispatch_main_async_safe(^{
//                            [cell.backImage setImageWithFadeIn:scaledImage];
//
////                    cell.backImage.image=scaledImage;
//                        });
//                    });
//
//                }];
//            } else {
//                [cell.backImage sd_setImageWithURL:data.coverImg completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                        UIImage *scaledImage = [image scaleToCoverSize:CGSizeMake(cell.backImage.frame.size.width*2,cell.backImage.frame.size.height*2)];
//                        dispatch_main_async_safe(^{
////                        [cell.backImage setImageWithFadeIn:[image scaleToCoverSize:CGSizeMake(w*2,w*2)]];
//
//                            cell.backImage.image = scaledImage;
//                        });
//                    });
//
//                }];
//            }
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
        cell.statusLabel.text= [data statusForRead];

        [cell setStatusBackColorIsRed:[data isActiveStatus]];


        return cell;
    }

    

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if([self.tableDataDisplayCaching[indexPath.section] isKindOfClass:[TopicModel class]]){
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
    if([self.tableDataDisplayCaching[indexPath.section] isKindOfClass:[TopicModel class]]){
        TopicModel *data=self.tableDataDisplayCaching[indexPath.section];
        DiaryDetailVCB *vc= [[DiaryDetailVCB alloc] init];
        vc.type=WebviewWithCommentVcDetailTypeTopic;
        vc.topic=data;
        [self.navigationController pushViewController:vc animated:YES];

    }else{
        EventModel *data=self.tableDataDisplayCaching[indexPath.section];

        EventDetailVC *vc=[[EventDetailVC alloc]init];
        vc.eventId= [data.eventId unsignedIntegerValue];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
