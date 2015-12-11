//
// Created by zcw on 15/9/10.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDMPhotoBrowser.h"


@interface GeneralWebVC : UIViewController <UIWebViewDelegate, IDMPhotoBrowserDelegate>
@property (nonatomic, strong)NSURL *url;
@property (strong, nonatomic)  UIWebView *webView;
@end