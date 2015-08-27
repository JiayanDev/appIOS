//
// Created by zcw on 15/8/27.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/View+MASAdditions.h>
#import "PersonCellOfAvatarAndName.h"

NSString * const XLFormRowDescriptorType_personCellOfAvatarAndName = @"XLFormRowDescriptorType_personCellOfAvatarAndName";

@interface PersonCellOfAvatarAndName()
@property (nonatomic, strong)UIImageView *avatarView;
@property (nonatomic, strong)UILabel *nameLabel;

@end
@implementation PersonCellOfAvatarAndName {

}

+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[PersonCellOfAvatarAndName class] forKey:XLFormRowDescriptorType_personCellOfAvatarAndName];
}


- (void)configure {
    self.avatarView=[UIImageView new];
    self.nameLabel=[UILabel new];
    [self.contentView addSubview:self.avatarView];
    [self.contentView addSubview:self.nameLabel];
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.top.equalTo(self.contentView).offset(17);
        make.bottom.equalTo(self.contentView).offset(17);
        make.size.mas_equalTo(CGSizeMake(31,31));
    }];

    self.avatarView.layer.cornerRadius = 16;
    self.avatarView.layer.masksToBounds=YES;

    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarView.mas_right).offset(7);
        make.centerY.equalTo(self.contentView);
    }];


}


- (void)update {


    [self.avatarView sd_setImageWithURL:self.rowDescriptor.value[kAvatar]
                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                  if(image) {
                                      self.avatarView.image = image;
                                  }
                              }];

    self.nameLabel.text=self.rowDescriptor.value[kName];

}

+ (CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor {
    return 34+31;
}




@end