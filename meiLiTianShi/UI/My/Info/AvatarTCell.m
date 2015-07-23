//
//  AvatarTCell.m
//  meiLiTianShi
//
//  Created by zcw on 15/7/23.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "AvatarTCell.h"
NSString * const XLFormRowDescriptorTypeAvatar = @"XLFormRowDescriptorTypeAvatar";

@implementation AvatarTCell

- (void)awakeFromNib {
    // Initialization code
    self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:NSStringFromClass([AvatarTCell class]) forKey:XLFormRowDescriptorTypeAvatar];
}

- (void)update
{
    [super update];

    if([self.rowDescriptor.value isKindOfClass:[UIImage class]]){
        self.imageView.image=self.rowDescriptor.value;
    }else{
//        [self.imageView.image sd_setImageWith
    }
}


+(CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor{
    return 88;
};


@end
