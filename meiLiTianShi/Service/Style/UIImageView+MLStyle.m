//
// Created by zcw on 15/9/8.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "UIImageView+MLStyle.h"


@implementation UIImageView (MLStyle)
+(UIImageView *)newWithRoundRadius:(CGFloat)r{
    UIImageView *v=[UIImageView new];
    v.layer.cornerRadius = r;
    v.clipsToBounds = YES;
    v.contentMode=UIViewContentModeScaleAspectFill;
    return v;
}
@end