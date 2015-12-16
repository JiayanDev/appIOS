//
// Created by zcw on 15/9/10.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "GeneralWebVC.h"
#import "MLStyleManager.h"
#import "URLParser.h"


#import "WebviewRequestModel.h"
#import "WebviewRespondModel.h"
#import "MLSession.h"
#import "EventJoinApplyFVC.h"
#import "MLWebRedirectPusher.h"
#import "IDMPhoto.h"
#import "IDMPhotoBrowser.h"


@interface GeneralWebVC()


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

    self.webView.opaque = NO;
    self.webView.backgroundColor = [UIColor whiteColor];


}

- (void)viewDidLoad {
    [super viewDidLoad];
    [MLStyleManager removeBackTextForNextScene:self];
    self.webView.delegate=self;

    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:self.url]];
    [MLStyleManager styleTheNavigationBar:self.navigationController.navigationBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"%@",request.URL);
    NSURL *url=request.URL;

//    if([url.absoluteString isEqualToString:[self.url absoluteString]]){
//        return YES;
//    }else
    if([url.scheme isEqualToString:@"jiayan"]){
        return [self handleInteractionRequests:url];
    }else if(!navigationType==UIWebViewNavigationTypeLinkClicked){
        return YES;
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

    NSLog(@"%@",dataString);

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
    }else if([requestModel.action isEqualToString:@"applymentEvent"]){
        EventJoinApplyFVC *vc= [[EventJoinApplyFVC alloc] init];
        vc.eventId=requestModel.data[@"id"];
        vc.eventInfo=requestModel.data[@"eventInfo"];
        [self.navigationController pushViewController:vc animated:YES];

    }else if([requestModel.action isEqualToString:@"setNavigationBarTitle"]){

        self.title=requestModel.data[@"title"];
    }else if([requestModel.action isEqualToString:@"playImg"]){
        [self showImageBrowserWithImages:requestModel.data[@"imgList"] startIndex:[requestModel.data[@"defaultIndex"] unsignedIntegerValue]];
    }else if([requestModel.action isEqualToString:@"scrollBottomToPosY"]){
        NSUInteger posY= [requestModel.data[@"posY"] unsignedIntegerValue];
        NSUInteger posYtop=posY-self.webView.frame.size.height;
        [self.webView.scrollView setContentOffset:CGPointMake(0, posYtop) animated:YES];


    }

    return NO;
}
- (BOOL)hidesBottomBarWhenPushed {
//    NSLog(@"%@", @([[NSDate new] timeIntervalSince1970]));
    return YES;
}

-(BOOL)handleRedirectRequests:(NSURL *)url{


    return ![MLWebRedirectPusher pushWithUrl:url
                              viewController:self];
}



-(void)showImageBrowserWithImages:(NSArray *)imageUrls startIndex:(NSUInteger)index{
    NSArray *photosWithURL = [IDMPhoto photosWithURLs:imageUrls];

    NSMutableArray * photos = [NSMutableArray arrayWithArray:photosWithURL];
// Create and setup browser
    IDMPhotoBrowser *browser = [[IDMPhotoBrowser alloc] initWithPhotos:photos];
    [browser setInitialPageIndex:index];
    browser.delegate = self;
    [self presentViewController:browser animated:YES completion:nil];

}



@end