//
// Created by zcw on 15/8/27.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "PhoneAndGotoEditButtonCell.h"
#import "MASConstraintMaker.h"
#import "UILabel+MLStyle.h"

NSString * const XLFormRowDescriptorType_PhoneAndGotoEditButtonCell = @"XLFormRowDescriptorType_PhoneAndGotoEditButtonCell";

@interface PhoneAndGotoEditButtonCell()
@property (nonatomic, strong)UILabel *phoneLabel;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *gotoEditLabel;
@end
@implementation PhoneAndGotoEditButtonCell {

}


+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[PhoneAndGotoEditButtonCell class] forKey:XLFormRowDescriptorType_PhoneAndGotoEditButtonCell];
}


- (void)configure {

    self.phoneLabel=[UILabel newMLStyleWithSize:15 isGrey:NO];
    self.titleLabel=[UILabel newMLStyleWithSize:15 isGrey:YES];
    self.gotoEditLabel= [UILabel newMLStyleWithSize:15 isGrey:NO];

    [self.contentView addSubview:self.phoneLabel];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.gotoEditLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.centerY.equalTo(self.contentView);
    }];

    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(16);
        make.centerY.equalTo(self.contentView);

    }];

    [self.gotoEditLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-9);
        make.centerY.equalTo(self.contentView);

    }];

    self.gotoEditLabel.textColor=THEME_COLOR;
    self.gotoEditLabel.text=@"更换";
    self.titleLabel.text=@"手机";

    self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

}


- (void)update {

    self.phoneLabel.text=self.rowDescriptor.value;

}

+ (CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor {
    return 50;
}


@end