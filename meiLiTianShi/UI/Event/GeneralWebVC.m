//
// Created by zcw on 15/9/10.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "GeneralWebVC.h"
#import "MLStyleManager.h"

@interface GeneralWebVC()
@property (strong, nonatomic)  UIWebView *webView;

@end
@implementation GeneralWebVC {

}

- (void)loadView {
    [super loadView];
    self.webView=[UIWebView new];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];


}

- (void)viewDidLoad {
    [super viewDidLoad];
    [MLStyleManager removeBackTextForNextScene:self];
}


@end