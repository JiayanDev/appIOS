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
#import "SLKTextViewController.m"

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

    if (self = [super initWithNibName:nil bundle:nil])
    {
//        _scrollView = scrollView;
//        _scrollView.translatesAutoresizingMaskIntoConstraints = NO; // Makes sure the scrollView plays nice with auto-layout

        self.scrollViewProxy = self.webView.scrollView;
        [self slk_commonInit];
    }
    return self;

}

- (void)viewDidLoad {
    //[super viewDidLoad];
    self.inverted=NO;



        //[[super super] viewDidLoad];

        [self.view addSubview:self.webView];
//        [self.view addSubview:self.autoCompletionView];
//        [self.view addSubview:self.typingIndicatorView];
//        [self.view addSubview:self.textInputbar];

        [self slk_setupViewConstraints];


    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://m.qq.com/"]]];
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
