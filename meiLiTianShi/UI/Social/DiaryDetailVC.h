//
//  DiaryDetailVC.h
//  meiLiTianShi
//
//  Created by zcw on 15/7/15.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "SLKTextViewController.h"

@class DiaryModel;

@interface DiaryDetailVC : SLKTextViewController <UIWebViewDelegate>
@property (nonatomic, strong)DiaryModel *diary;
@end
