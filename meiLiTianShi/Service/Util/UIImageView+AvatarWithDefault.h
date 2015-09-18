//
// Created by zcw on 15/9/16.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImageView (AvatarWithDefault)

- (void)setAvatarImageUrl:(NSString *)urlString;

- (void)setAvatarImageUrl:(NSString *)urlString completed:(void (^)(UIImage *image))completed;
@end