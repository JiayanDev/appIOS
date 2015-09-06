//
// Created by zcw on 15/9/6.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "TimeLineVCB.h"
#import "MLBlurImageHeaderedWebview.h"
#import "URLParser.h"
#import "WebviewRequestModel.h"
#import "WebviewRespondModel.h"
#import "CreateDiaryFVC.h"
#import "MLWebRedirectPusher.h"
#import "IDMPhoto.h"
#import "IDMPhotoBrowser.h"


@implementation TimeLineVCB {

}
- (void)loadView {
    [super loadView];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.mainView= [[MLBlurImageHeaderedWebview alloc] init];
    [self.mainView setupVC:self];
    self.mainView.backgroundImageOrigin=[UIImage imageNamed:@"meinvtupianbizhi_813_051.jpg"];
    [self.view addSubview:self.mainView];


    self.mainView.avatarView.image=[UIImage imageNamed:@"meinvtupianbizhi_813_051.jpg"];
    self.mainView.nameLabel.text=@"hahahaha";
    self.mainView.descLabel.text=@"hahahaha";
    self.mainView.webView.delegate=self;

}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [self setNeedsStatusBarAppearanceUpdate];
//    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"timeline_分享.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                             style:UIBarButtonItemStylePlain target:self
                                                                            action:@selector(sharePress)];
}

-(void)sharePress{

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNeedsStatusBarAppearanceUpdate];
}



#pragma mark - webview delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *url=request.URL;
//    if([url isEqual:self.url]){
//        return YES;
//    }
    if([url.scheme isEqualToString:@"jiayan"]){
        return [self handleInteractionRequests:url];
    }else if([url.scheme isEqualToString:@"http"]){
        //return [self handleRedirectRequests:url];
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
                                         }] respondToWebview:self.mainView.webView
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
        NSUInteger posYtop=posY-self.mainView.webView.frame.size.height;
        [self.mainView.webView.scrollView setContentOffset:CGPointMake(0, posYtop) animated:YES];


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