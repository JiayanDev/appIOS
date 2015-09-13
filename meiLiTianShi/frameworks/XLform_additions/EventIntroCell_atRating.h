//
// Created by zcw on 15/9/14.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLFormBaseCell.h"

extern NSString * const XLFormRowDescriptorType_EventIntroCell_atRating;

@interface EventIntroCell_atRating : XLFormBaseCell
@property(nonatomic, strong) UIImageView *thumbImageView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *descLabel;
@property(nonatomic, strong) UILabel *statusLable;
@property(nonatomic, strong) UILabel *timeLabel;
@end