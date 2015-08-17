//
// Created by zcw on 15/8/17.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "MLStyleManager.h"
#import "HexColor.h"


@implementation MLStyleManager {

}

+(void)styleSetsWhenFinishiLaunching{


    NSDictionary *textTitleOptions = @{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"ff5a60"]/*, UITextAttributeTextShadowColor : [UIColor whiteColor]*/};
    [[UINavigationBar appearance] setTitleTextAttributes:textTitleOptions];


    [[UINavigationBar appearance] setTintColor:[UIColor colorWithHexString:@"ff5a60"]];
};


+(void)styleTheNavigationBar:(UINavigationBar *)navigationBar{
    UIView* sv= [[UIView alloc] initWithFrame:[self findHairlineImageViewUnder:navigationBar].frame];
    sv.backgroundColor=[UIColor colorWithHexString:@"d9d9d9"];
    [[self findHairlineImageViewUnder:navigationBar].superview addSubview:sv];
}


+ (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

@end