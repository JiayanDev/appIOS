//
// Created by zcw on 15/9/8.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+MLStyle.h"
#import "SDImageCache.h"
#import "UIImage+Resizing.h"


@implementation UIImageView (MLStyle)
+(UIImageView *)newWithRoundRadius:(CGFloat)r{
    UIImageView *v=[UIImageView new];
    v.layer.cornerRadius = r;
    v.clipsToBounds = YES;
    v.contentMode=UIViewContentModeScaleAspectFill;
    return v;
}

- (void)setImageWithFadeIn:(UIImage *)image {

    [UIView transitionWithView:self
                      duration:0.3f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.image = image;
                    } completion:nil];
}

-(void)setImageWithScalingToSelfSizeWithUrl:(NSURL *)url AndWillAnimate:(BOOL)animated{
    if (animated) {
        [self sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                UIImage *scaledImage = [image scaleToCoverSize:CGSizeMake(self.frame.size.width * 2, self.frame.size.height * 2)];
                dispatch_main_async_safe(^{
                    [self setImageWithFadeIn:scaledImage];


                });
            });

        }];
    } else {
        [self sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                UIImage *scaledImage = [image scaleToCoverSize:CGSizeMake(self.frame.size.width * 2, self.frame.size.height * 2)];
                dispatch_main_async_safe(^{


                    self.image = scaledImage;
                });
            });

        }];
    }
}



@end