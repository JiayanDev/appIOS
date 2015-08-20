//
//  TimelineVC.m
//  meiLiTianShi
//
//  Created by zcw on 15/8/12.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "TimelineVC.h"
#import "IDMPhotoBrowser.h"
#import "TSMessage.h"
#import "WebviewRespondModel.h"
#import "MLSession.h"
#import "WebviewRequestModel.h"
#import "URLParser.h"
#import "MLWebRedirectPusher.h"
#import "CreateDiaryFVC.h"

@interface TimelineVC ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic)NSURL *url;

@end

@implementation TimelineVC

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}





- (void)viewDidLoad {
    [super viewDidLoad];

    self.webView.delegate=self;
    self.url=[NSURL URLWithString:[NSString stringWithFormat:
            @"http://apptest.jiayantech.com/html/timeline.html?id=%@",self.userId]];

    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:self.url]];
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
    }
    else if([requestModel.action isEqualToString:@"setNavigationBarTitle"]){

        self.title=requestModel.data[@"title"];
    }
    else if([requestModel.action isEqualToString:@"playImg"]){
        [self showImageBrowserWithImages:requestModel.data[@"imgList"] startIndex:[requestModel.data[@"defaultIndex"] unsignedIntegerValue]];
    }
    else if([requestModel.action isEqualToString:@"scrollBottomToPosY"]){
        NSUInteger posY= [requestModel.data[@"posY"] unsignedIntegerValue];
        NSUInteger posYtop=posY-self.webView.frame.size.height;
        [self.webView.scrollView setContentOffset:CGPointMake(0, posYtop) animated:YES];


    }else if([requestModel.action isEqualToString:@"addPost"]){
        CreateDiaryFVC *vc= [[CreateDiaryFVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];


    }else if([requestModel.action isEqualToString:@"hideLoading"]){


    }

    return NO;
}

-(BOOL)handleRedirectRequests:(NSURL *)url{

    return ![MLWebRedirectPusher pushWithUrl:url
                              viewController:self];
}


#pragma mark - specific handles



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