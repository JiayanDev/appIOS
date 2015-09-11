//
// Created by zcw on 15/9/9.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIButton (MLStyle)
+ (UIButton *)newSolidThemeColorButtonWithTitle:(NSString *)title fontSize:(CGFloat)fontsize;

+ (UIButton *)newBorderedColorButtonWithTitle:(NSString *)title fontSize:(CGFloat)fontsize;

+ (UIButton *)newSquareSolidButtonWithTitle:(NSString *)title;
@end