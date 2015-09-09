//
// Created by zcw on 15/9/9.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DiaryInListCell : UITableViewCell
@property(nonatomic, strong) NSArray *images;
@property(nonatomic, strong) NSArray *imageViews;
@property(nonatomic, strong) UIImageView *avatarView;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *catogoriesLabel;
@property(nonatomic, strong) UILabel *contentLabel;
@property(nonatomic, strong) UILabel *dateLabel;
@property(nonatomic, strong) UILabel *pinglunAndZanLabel;
@end