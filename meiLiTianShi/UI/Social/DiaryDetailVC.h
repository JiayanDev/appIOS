//
//  DiaryDetailVC.h
//  meiLiTianShi
//
//  Created by zcw on 15/7/15.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "SLKTextViewController.h"
#import "IDMPhotoBrowser.h"

@class DiaryModel;

@interface DiaryDetailVC : SLKTextViewController <UIWebViewDelegate, IDMPhotoBrowserDelegate>
@property (nonatomic, strong)DiaryModel *diary;
@end
