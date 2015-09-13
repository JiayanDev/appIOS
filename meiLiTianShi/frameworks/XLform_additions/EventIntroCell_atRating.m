//
// Created by zcw on 15/9/14.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Masonry/MASConstraintMaker.h>
#import <Masonry/View+MASAdditions.h>
#import "EventIntroCell_atRating.h"
#import "UILabel+MLStyle.h"
#import "UIButton+MLStyle.h"


NSString * const XLFormRowDescriptorType_EventIntroCell_atRating = @"XLFormRowDescriptorType_EventIntroCell_atRating";


@implementation EventIntroCell_atRating {

}


+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[self class] forKey:XLFormRowDescriptorType_EventIntroCell_atRating];
}


- (void)configure {
    self.thumbImageView=[UIImageView new];
    self.thumbImageView.contentMode=UIViewContentModeScaleAspectFill;

    self.titleLabel=[UILabel newMLStyleWithSize:14 isGrey:NO];

    self.descLabel=[UILabel newMLStyleWithSize:12 isGrey:YES];

    self.statusLable=[UILabel newMLStyleWithSize:12 isGrey:YES];

    self.timeLabel=[UILabel newMLStyleWithSize:10 isGrey:YES];


    [self.contentView addSubview:self.thumbImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.descLabel];
    [self.contentView addSubview:self.statusLable];
    [self.contentView addSubview:self.timeLabel];

    [self.thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(17);
        make.top.equalTo(self.contentView).offset(17);
        make.bottom.equalTo(self.contentView).offset(-17);
        make.size.mas_equalTo(CGSizeMake(60,60));
    }];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(17);
        make.left.equalTo(self.thumbImageView.mas_right).offset(20);



    }];

    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
        make.left.equalTo(self.thumbImageView.mas_right).offset(20);
    }];

    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.thumbImageView.mas_right).offset(20);
        make.bottom.equalTo(self.contentView).offset(-17);
    }];


    [self.statusLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(self.contentView);
    }];


}


+ (CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor {
    return 95;
}


@end