//
// Created by zcw on 15/9/14.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLFormBaseCell.h"
#import "HCSStarRatingView.h"
//@class HCSStarRatingView;
extern NSString * const XLFormRowDescriptorType_RatingCell_ATitleAndTwoRates;

@interface RatingCell_ATitleAndTwoRates : XLFormBaseCell
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *label1;
@property(nonatomic, strong) UILabel *label2;

@property(nonatomic, strong) HCSStarRatingView *star1;
@property(nonatomic, strong) HCSStarRatingView *star2;
@end