//
// Created by zcw on 15/8/27.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UILabel (MLStyle)
+ (UILabel *)newMLStyleWithSize:(CGFloat)size isGrey:(BOOL)isGrey;

- (void)appendIcon:(UIImage *)icon;

//- (void)appendIcon:(UIImage *)icon withBounds:(CGRect)bound;

- (void)appendIconOfGender:(NSUInteger)gender;

- (void)prependIconOfGender:(NSUInteger)gender;

- (void)prependIcon:(UIImage *)icon;

//- (void)prependIcon:(UIImage *)icon withBounds:(CGRect)bound;
@end