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
#import "URLParser.h"
#import "WebviewRequestModel.h"
#import "WebviewRespondModel.h"

@interface DiaryDetailVC ()
//@property (strong, nonatomic) IBOutlet UIScrollView *scroll;
@property(strong, nonatomic) UIScrollView *scroller;
//@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property(strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic)NSURL *url;

@end

@implementation DiaryDetailVC
- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}





- (instancetype)init {
    //[[NSBundle mainBundle] loadNibNamed:@"DiaryDetailVC" owner:self options:nil];
    self.webView = [[UIWebView alloc] init];
    self.webView.delegate=self;

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

    self.url=[NSURL URLWithString:[NSString stringWithFormat:
            @"http://app.jiayantech.com/app/html/diary.html?id=%@&test=1",@(self.diary.id)]];

    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:self.url]];
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


#pragma mark - webview delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *url=request.URL;
    if([url isEqual:self.url]){
        return YES;
    }
    if([url.scheme isEqualToString:@"jiayan"]){
        return [self handleInteractionRequests:url];
    }else if([url.scheme isEqualToString:@"http"]){
        return [self handleRedirectRequests:url];
    }

    return YES;



}


#pragma mark - handles

-(BOOL)handleInteractionRequests:(NSURL*)url{
    URLParser *parser = [[URLParser alloc] initWithURLString:[url absoluteString]] ;
    NSString *dataString= [[parser valueForVariable:@"options"] stringByRemovingPercentEncoding];
    NSError* err = nil;

    WebviewRequestModel *requestModel= [[WebviewRequestModel alloc] initWithString:dataString error:&err];
    if([requestModel.action isEqualToString:@"testForCallNativePleaseGiveBackWhatIHadSend"]){
        [[WebviewRespondModel respondWithCode:@0
                                          msg:@"ok"
                                         data:@{
                                                 @"subject" : requestModel.data[@"subject"],
                                                 @"subjectId" : requestModel.data[@"subjectId"],
                                         }] respondToWebview:self.webView
                                                 withReqeust:requestModel
                                                   isSuccess:YES];
    }

    return NO;
}

-(BOOL)handleRedirectRequests:(NSURL *)url{

    return NO;
}


#pragma mark - specific handles



@end
