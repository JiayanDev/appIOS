//
// Created by zcw on 15/11/15.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KILabel.h"

#define KILinkTypeDetectedString 12332

@interface MLKILabel : KILabel
@property (nonatomic, strong)NSString *detectString;
@property (nullable, nonatomic, copy) KILinkTapHandler detectStringTapHandler;

+ (MLKILabel *)newMLStyleWithSize:(CGFloat)size isGrey:(BOOL)isGrey string:(NSString *)s DetectString:(NSString *)ds;

- (instancetype)initWithString:(NSString *)s DetectString:(NSString *)ds;
@end