//
// Created by zcw on 15/8/31.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "AvatarAndNameAndDescCell.h"

NSString * const XLFormRowDescriptorType_AvatarAndNameAndDescCell = @"XLFormRowDescriptorType_AvatarAndNameAndDescCell";


@implementation AvatarAndNameAndDescCell {

}

+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[AvatarAndNameAndDescCell class] forKey:XLFormRowDescriptorType_AvatarAndNameAndDescCell];
}



@end