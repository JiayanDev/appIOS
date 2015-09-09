//
// Created by zcw on 15/9/9.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "UIButton+MLStyle.h"
#import <QuartzCore/QuartzCore.h>


@implementation UIButton (MLStyle)
+(UIButton *)newSolidThemeColorButtonWithTitle:(NSString *)title fontSize:(CGFloat)fontsize{
    UIButton * b= [[UIButton alloc] init];
    [b setTitle:title forState:UIControlStateNormal];


    b.backgroundColor=THEME_COLOR;
    b.titleLabel.font=[UIFont systemFontOfSize:fontsize];
    b.layer.cornerRadius = 4;
    b.clipsToBounds = YES;
    [b setBackgroundImage:[UIImage imageWithColor:THEME_COLOR_HIGHLIGHT_BUTTON] forState:UIControlStateHighlighted];
    [b setBackgroundImage:[UIImage imageWithColor:THEME_COLOR_DISABLED_BUTTON] forState:UIControlStateDisabled];
    return b;
}

+(UIButton *)newBorderedColorButtonWithTitle:(NSString *)title fontSize:(CGFloat)fontsize{
    UIButton * b= [[UIButton alloc] init];
    [b setTitle:title forState:UIControlStateNormal];


//    b.backgroundColor=THEME_COLOR;
    b.titleLabel.font=[UIFont systemFontOfSize:fontsize];
    b.layer.cornerRadius = 4;
    b.clipsToBounds = YES;
    b.layer.borderWidth = THE1PX_CONST;
    b.layer.borderColor = THEME_COLOR.CGColor;

    return b;
}

@end