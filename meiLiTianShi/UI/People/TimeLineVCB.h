//
// Created by zcw on 15/9/6.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDMPhotoBrowser.h"

@class MLBlurImageHeaderedWebview;


@interface TimeLineVCB : UIViewController <UIWebViewDelegate, IDMPhotoBrowserDelegate>
@property(nonatomic, strong) MLBlurImageHeaderedWebview *mainView;
@end