//
//  AboutUsVC.m
//  meiLiTianShi
//
//  Created by zcw on 15/7/27.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "AboutUsVC.h"
#import "UILabel+MLStyle.h"
#import "UIButton+MLStyle.h"
#import "RMUniversalAlert.h"

@interface AboutUsVC ()

@end

@implementation AboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=THEME_COLOR_BACKGROUND;
    self.title=@"关于我们";


    self.logo=[UIImageView new];
    self.versionLabel=[UILabel newMLStyleWithSize:15 isGrey:NO];
    self.qqButton=[UIButton newBorderedColorButtonWithTitle:@"12345678" fontSize:13];
    [self.qqButton setTitleColor:THEME_COLOR forState:UIControlStateNormal];
    self.phoneButton=[UIButton newBorderedColorButtonWithTitle:PHONE_JIAYAN fontSize:13];
    [self.phoneButton setTitleColor:THEME_COLOR forState:UIControlStateNormal];
    self.bottomCLabel=[UILabel newMLStyleWithSize:12 isGrey:YES];
    self.bottomCLabel.text=@"©JIAYAN TECH, ALL RIGHTS RESERVED";
    self.versionLabel.text=@"V1.0";

    [self.view addSubview:self.logo];
    [self.view addSubview:self.versionLabel];
    [self.view addSubview:self.qqButton];
    [self.view addSubview:self.phoneButton];
    [self.view addSubview:self.bottomCLabel];

    self.logo.image=[UIImage imageNamed:@"logo.png"];
    [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view).multipliedBy(0.7);
        make.centerX.equalTo(self.view);
    }];

    [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logo.mas_bottom).offset(20);
        make.centerX.equalTo(self.view);
    }];

    [self.bottomCLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-20);
        make.centerX.equalTo(self.view);
    }];

    [self.phoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.bottomCLabel.mas_top).offset(-30);
        make.width.mas_equalTo(130);
    }];

    [self.qqButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.phoneButton.mas_top).offset(-20);
        make.width.mas_equalTo(130);
    }];


    self.qqButton.hidden=YES;
    [self.phoneButton addTarget:self action:@selector(gotoPhone) forControlEvents:UIControlEventTouchUpInside];
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

-(void)gotoPhone{
    [RMUniversalAlert showAlertInViewController:self
                                      withTitle:@"提示"
                                        message:[NSString stringWithFormat: @"要拨打我们的客服电话 %@ 吗?",PHONE_JIAYAN]
                              cancelButtonTitle:@"取消"
                         destructiveButtonTitle:nil
                              otherButtonTitles:@[@"确定"]
                                       tapBlock:^(RMUniversalAlert *alert, NSInteger buttonIndex){
                                           if(buttonIndex==2){
                                               [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",PHONE_JIAYAN]]];
                                           }

                                       }];
}


@end
