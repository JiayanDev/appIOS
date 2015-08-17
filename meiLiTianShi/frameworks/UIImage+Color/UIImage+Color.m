//
//  UIImage+Color.m
//  ttpic
//
//  Created by darrenyao on 14-4-14.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [UIImage imageWithColor:color imageSize:CGSizeMake(1, 1)];;
}

+(UIImage *)imageWithColor:(UIColor *)color imageSize:(CGSize)imageSize
{
    NSAssert(!CGSizeEqualToSize(imageSize, CGSizeZero), @"imageSize is zero for method imageWithColor: imageSize:");
    
    if (color == nil) {
        return nil;
    }
    
    CGRect rect = CGRectMake(0.0f, 0.0f, imageSize.width, imageSize.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
//    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
