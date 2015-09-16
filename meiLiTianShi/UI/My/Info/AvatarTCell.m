//
//  AvatarTCell.m
//  meiLiTianShi
//
//  Created by zcw on 15/7/23.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "AvatarTCell.h"
#import "UIImageView+WebCache.h"
#import "AvatarDetailVC.h"

NSString * const XLFormRowDescriptorTypeAvatar = @"XLFormRowDescriptorTypeAvatar";

@implementation AvatarTCell

- (void)awakeFromNib {
    // Initialization code
    self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    self.avatar.layer.cornerRadius = 20;
    self.avatar.clipsToBounds = YES;
    self.avatar.contentMode=UIViewContentModeScaleAspectFill;
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
    self.titleLabel.textColor=THEME_COLOR_TEXT;

    if([self.rowDescriptor.value isKindOfClass:[UIImage class]]){
        self.avatar.image=self.rowDescriptor.value;
    }else{
        [self.avatar sd_setImageWithURL:self.rowDescriptor.value
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                     self.avatar.image=image;
                                     [self needsUpdateConstraints];
                                     [self setNeedsDisplay];
                                 }];
    }
}
//
//-(void)formDescriptorCellDidSelectedWithFormController:(XLFormViewController *)controller
//{
////    [self.formViewController.tableView deselectRowAtIndexPath:[controller.form indexPathOfFormRow:self.rowDescriptor] animated:YES];
//    AvatarDetailVC *vc= [[AvatarDetailVC alloc] init];
//    vc.rowDescriptor=self.rowDescriptor;
//    [self.formViewController.navigationController pushViewController:vc animated:YES];
//}


+(CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor{
    return 70;
};


@end
