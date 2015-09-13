//
// Created by zcw on 15/9/14.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "RatingCell_ATitleAndTwoRates.h"
#import "UILabel+MLStyle.h"
#import "HCSStarRatingView.h"

NSString * const XLFormRowDescriptorType_RatingCell_ATitleAndTwoRates = @"XLFormRowDescriptorType_RatingCell_ATitleAndTwoRates";


@implementation RatingCell_ATitleAndTwoRates {

}
+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[self class] forKey:XLFormRowDescriptorType_RatingCell_ATitleAndTwoRates];
}


- (void)configure {
    self.titleLabel=[UILabel newMLStyleWithSize:15 isGrey:NO];
    self.label1=[UILabel newMLStyleWithSize:12 isGrey:YES];
    self.label2=[UILabel newMLStyleWithSize:12 isGrey:YES];
    self.star1=[HCSStarRatingView new];
    self.star2=[HCSStarRatingView new];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(16);
        make.left.equalTo(self.contentView).offset(16);
    }];

    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(16);
        make.left.equalTo(self.titleLabel);
    }];
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(16);
        make.left.equalTo(self.titleLabel);
    }];
    
    [self.star1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(30);
        make.left.equalTo(self.label1.mas_right).offset(30);
        make.centerY.equalTo(self.label1);
        make.height.mas_equalTo(20);
    }];


    [self.star2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(30);
        make.left.equalTo(self.label2.mas_right).offset(30);
        make.centerY.equalTo(self.label2);
        make.height.mas_equalTo(20);
    }];
}


+ (CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor {
    return 120;
}




@end