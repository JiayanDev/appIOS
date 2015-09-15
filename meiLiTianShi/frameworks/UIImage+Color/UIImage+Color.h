//
//  UIImage+Color.h
//  ttpic
//
//  Created by darrenyao on 14-4-14.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color imageSize:(CGSize)imageSize;

- (UIImage *)imageWithOverlayColor:(UIColor *)color;

- (UIImage *)blurredImageDarkerWithRadius:(CGFloat)radius iterations:(NSUInteger)iterations tintColor:(UIColor *)tintColor;
@end
