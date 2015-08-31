//
// Created by zcw on 15/8/31.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "AvatarAndNameAndDescCell.h"
#import "UILabel+MLStyle.h"

NSString * const XLFormRowDescriptorType_AvatarAndNameAndDescCell = @"XLFormRowDescriptorType_AvatarAndNameAndDescCell";


@implementation AvatarAndNameAndDescCell {
    UILabel *nameLabel;
    UILabel *descLabel;
    UIImageView *avatarView;
}

+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[AvatarAndNameAndDescCell class] forKey:XLFormRowDescriptorType_AvatarAndNameAndDescCell];
}


- (void)configure {
    avatarView=[UIImageView new];
    [self.contentView addSubview:avatarView];

    nameLabel=[UILabel newMLStyleWithSize:15 isGrey:NO];
    [self.contentView addSubview:nameLabel];

    descLabel=[UILabel newMLStyleWithSize:15 isGrey:YES];
    [self.contentView addSubview:descLabel];

    [avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(8);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(65,65));
    }];




}

- (void)update {

}


+ (CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor {

    return 110;
}

@end