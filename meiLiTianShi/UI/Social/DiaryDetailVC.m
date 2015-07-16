//
//  DiaryDetailVC.m
//  meiLiTianShi
//
//  Created by zcw on 15/7/15.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "DiaryDetailVC.h"
#import "Masonry.h"
#import "HexColor.h"
#import "DiaryModel.h"

@interface DiaryDetailVC ()
//@property (strong, nonatomic) IBOutlet UIScrollView *scroll;
@property(strong, nonatomic) UIScrollView *scroller;
//@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property(strong, nonatomic) UIWebView *webView;

@end

@implementation DiaryDetailVC
- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}





- (instancetype)init {
    //[[NSBundle mainBundle] loadNibNamed:@"DiaryDetailVC" owner:self options:nil];
    self.webView = [[UIWebView alloc] init];

    return (self= [super initWithWebView:self.webView]);

}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.inverted=NO;
//
//
//
//        //[[super super] viewDidLoad];
//
//        [self.view addSubview:self.webView];
////        [self.view addSubview:self.autoCompletionView];
////        [self.view addSubview:self.typingIndicatorView];
////        [self.view addSubview:self.textInputbar];
//
//        [self slk_setupViewConstraints];


    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:
    @"http://app.jiayantech.com/app/html/diary.html?id=%@",@(self.diary.id)]]]];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    //self.scroller.contentSize=self.webView.frame.size;
//    [self.webView needsUpdateConstraints];
//    [self.webView layoutIfNeeded];
//    [self.scroller setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
