//
// Created by zcw on 15/9/8.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IndexCellPR : UITableViewCell
@property(nonatomic, strong) UIImageView *backImage;
@property(nonatomic, strong) UIImageView *statusBackImage;
@property(nonatomic, strong) UIView *footView;

@property(nonatomic, strong) UIImageView *doctorAvatar;
@property(nonatomic, strong) UILabel *doctorNameLabel;
@property(nonatomic, strong) UILabel *doctorDescLabel;
@property(nonatomic, strong) UILabel *statusLabel;

+ (int)cellHeight;

- (int)cellHeight;
@end