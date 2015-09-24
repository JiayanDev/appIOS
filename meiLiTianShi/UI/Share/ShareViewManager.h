//
// Created by zcw on 15/8/22.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLSession.h"


@interface ShareViewManager : NSObject <wxSendMessageRespondObj>

@property (nonatomic, strong)NSString *shareTitle;

@property (nonatomic, strong)NSString *shareDesc;

@property (nonatomic, strong)NSString *shareUrl;

@property (nonatomic, strong)UIImage *shareIcon;

+ (ShareViewManager *)showSharePanelOnto:(UIView *)view;

- (void)disappearAll;

- (void)showSharePanelOnto:(UIView *)view;
@end