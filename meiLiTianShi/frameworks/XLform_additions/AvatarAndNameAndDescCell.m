//
// Created by zcw on 15/8/31.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "AvatarAndNameAndDescCell.h"
#import "UILabel+MLStyle.h"
#import "UserDetailModel.h"

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
        make.left.equalTo(self.contentView).offset(16);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(65,65));
    }];


    avatarView.layer.cornerRadius = 33;
    avatarView.layer.masksToBounds=YES;
    avatarView.contentMode=UIViewContentModeScaleAspectFill;

    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(avatarView.mas_right).offset(16);
        make.right.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView).offset(-10);

    }];

    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(avatarView.mas_right).offset(16);
        make.right.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView).offset(10);
    }];

    self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;


}

- (void)update {

    UserDetailModel *detailModel=self.rowDescriptor.value;
    if(detailModel){
        [avatarView sd_setImageWithURL:[NSURL URLWithString:detailModel.avatar]
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                 avatarView.image=image;
                                 [self.contentView setNeedsLayout];
                                 [self.contentView setNeedsDisplay];
                             }];

        nameLabel.text=detailModel.name;
        [nameLabel appendIconOfTag:detailModel.role];
        descLabel.text= [detailModel descOfGenderAreaAge];
    }

    [self.contentView setNeedsLayout];
    [self.contentView setNeedsDisplay];


}


+ (CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor {

    return 110;
}


- (void)formDescriptorCellDidSelectedWithFormController:(XLFormViewController *)controller {
    id VC= [[self.rowDescriptor.action.viewControllerClass alloc]init];
    [controller.navigationController pushViewController:VC animated:YES];
}

@end