//
//  CreateDiaryBookFVC.h
//  meiLiTianShi
//
//  Created by zcw on 15/7/9.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "XLFormViewController.h"

@class CategoryModel;
@class DiaryBookModel;
@class DiaryModel;

@interface CreateDiaryBookFVC : XLFormViewController
@property (nonatomic, strong) NSMutableOrderedSet *categories;
@property (nonatomic, strong)DiaryBookModel *diaryBookWithOnlyCates;
@property (nonatomic, strong)DiaryModel *diaryWithoutImage;
@property (nonatomic, strong)NSArray *imagesToUpload;
@end
