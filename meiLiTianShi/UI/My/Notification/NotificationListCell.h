//
// Created by zcw on 15/9/14.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NotificationListCell : UITableViewCell
@property(nonatomic, strong) UIImageView *avatarView;
@property(nonatomic, strong) UILabel *timeLabel;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *actionLabel;
@property(nonatomic, strong) UILabel *contentLabel;
@property(nonatomic, strong) UIImageView *secondContentImageView;
@property(nonatomic, strong) UILabel *secondContentLabel;
@end