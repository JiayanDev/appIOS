//
// Created by zcw on 15/8/27.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
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



}


- (void)update {


    [self.avatarView sd_setImageWithURL:self.rowDescriptor.value[kAvatar]
                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                  if(image) {
                                      self.avatarView.image = image;
                                  }
                              }];

}

+ (CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor {

}




@end