//
// Created by zcw on 15/8/17.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "MLStyleManager.h"
#import "HexColor.h"


@implementation MLStyleManager {

}

#define myHairLineTag 56789

+(void)styleSetsWhenFinishiLaunchingWithWindow:(UIWindow *)window{


    NSDictionary *textTitleOptions = @{
            NSForegroundColorAttributeName : [UIColor colorWithHexString:@"ff5a60"],/*, UITextAttributeTextShadowColor : [UIColor whiteColor]*/
            NSFontAttributeName:[UIFont systemFontOfSize:17]
    };
    [[UINavigationBar appearance] setTitleTextAttributes:textTitleOptions];
//    [[UINavigationBar appearance]set]


    [[UINavigationBar appearance] setTintColor:[UIColor colorWithHexString:@"ff5a60"]];


    [window setTintColor:[UIColor colorWithHexString:@"ff5a60"]];

//    [UINavigationBar appearance]set
};


+(void)styleTheNavigationBar:(UINavigationBar *)navigationBar{

    //hairline
    UIView* sv= [[UIView alloc] initWithFrame:[self findHairlineImageViewUnder:navigationBar].frame];
    sv.backgroundColor=[UIColor colorWithHexString:@"d9d9d9"];
    sv.tag=myHairLineTag;
    UIView *v=[self findHairlineImageViewUnder:navigationBar].superview;
    [v addSubview:sv];
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(v).offset(THE1PX_CONST);
        make.left.equalTo(v);
        make.right.equalTo(v);
        make.height.mas_equalTo(THE1PX_CONST);
    }];



    //back button
    UIImage *backBtn = [UIImage imageNamed:@"返回.png"];
    backBtn = [backBtn imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    navigationBar.backIndicatorImage = backBtn;
    navigationBar.backIndicatorTransitionMaskImage = backBtn;
}

+(void)hideTheHairLine:(UINavigationBar *)navigationBar{

    //hairline
//    UIView* sv= [[UIView alloc] initWithFrame:[self findHairlineImageViewUnder:navigationBar].frame];
//    sv.backgroundColor=[UIColor colorWithHexString:@"d9d9d9"];
    UIImageView *view;
    while ((view=[self findMyHarilineUnder:navigationBar.superview] )!=nil){
        [view removeFromSuperview];
    }
    [self findHairlineImageViewUnder:navigationBar].hidden=YES;
//    [self findHairlineImageViewUnder:navigationBar].hidden=YES;



}



+(void)removeBackTextForNextScene:(UIViewController *)viewController{
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
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


+ (UIImageView *)findMyHarilineUnder:(UIView *)view {
    if (view.tag==myHairLineTag) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findMyHarilineUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}



@end