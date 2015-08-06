//
//  EventDetailVC.m
//  meiLiTianShi
//
//  Created by zcw on 15/8/6.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "EventDetailVC.h"
#import "EventModel.h"
#import "DiaryModel.h"
#import "URLParser.h"
#import "WebviewRequestModel.h"
#import "WebviewRespondModel.h"
#import "MLSession.h"
#import "UserModel.h"
#import "IDMPhoto.h"
#import "IDMPhotoBrowser.h"

@interface EventDetailVC ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic)NSURL *url;
@end

@implementation EventDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.webView.delegate=self;
    self.url=[NSURL URLWithString:[NSString stringWithFormat:
            @"http://apptest.jiayantech.com/html/eventdetail.html?id=%@",@(self.event.id)]];

    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:self.url]];
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
    }else if([requestModel.action isEqualToString:@"openCommentPanel"]){
//        self.commentRequest=requestModel;
//        [self.textInputbar.textView becomeFirstResponder];
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

-(BOOL)handleRedirectRequests:(NSURL *)url{

    return NO;
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
