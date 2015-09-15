//
// Created by zcw on 15/9/16.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+AvatarWithDefault.h"


@implementation UIImageView (AvatarWithDefault)
-(void)setAvatarImageUrl:(NSString *)urlString{
    if(urlString&&urlString!=[NSNull null]&&urlString.length>0){
        [self sd_setImageWithURL:[[NSURL alloc] initWithString:urlString]];
    }else{
        self.image=[UIImage imageNamed:@"logo.png"];
    }
}


-(void)setAvatarImageUrl:(NSString *)urlString completed:(void(^)(UIImage * image))completed{
    if(urlString&&urlString!=[NSNull null]&&urlString.length>0){
        [self sd_setImageWithURL:[[NSURL alloc] initWithString:urlString]
                       completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                            completed(image);
                       }];
    }else{
        self.image=[UIImage imageNamed:@"logo.png"];
        completed(self.image);
    }
}
@end