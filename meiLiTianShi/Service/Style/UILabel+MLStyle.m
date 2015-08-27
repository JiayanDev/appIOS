//
// Created by zcw on 15/8/27.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "UILabel+MLStyle.h"


@implementation UILabel (MLStyle)
+(UILabel *)newMLStyleWithSize:(CGFloat)size isGrey:(BOOL)isGrey{
    UILabel *l=[UILabel new];
    l.font=[UIFont systemFontOfSize:size<=0?15:size];
    l.textColor=isGrey?THEME_COLOR_TEXT_LIGHT_GRAY:THEME_COLOR_TEXT;
    return l;
}
@end