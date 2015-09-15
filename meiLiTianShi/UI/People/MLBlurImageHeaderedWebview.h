//
// Created by zcw on 15/9/6.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MLBlurImageHeaderedWebview : UIView <UIScrollViewDelegate>
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic)UIImage *backgroundImageOrigin;
@property (strong, nonatomic)UIImage *backgroundImageBlured;
@property(nonatomic, strong) UIImageView * imageView;
@property(nonatomic, strong) UILabel *headerLabel;

@property(nonatomic, strong) UILabel *nameLabel;

@property(nonatomic, strong) UILabel *descLabel;

@property(nonatomic, strong) UIImageView *avatarView;

- (void)setupVC:(UIViewController *)viewController;

- (void)unsetupVC:(UIViewController *)viewController;
@end