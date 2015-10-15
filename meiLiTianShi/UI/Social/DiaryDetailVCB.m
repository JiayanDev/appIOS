//
// Created by zcw on 15/10/13.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "DiaryDetailVCB.h"
#import "WebviewRequestModel.h"
#import "DiaryModel.h"
#import "TopicModel.h"
#import "MLSession.h"
#import "TSMessage.h"
#import "URLParser.h"
#import "WebviewRespondModel.h"
#import "UserModel.h"
#import "ShareViewManager.h"
#import "UIViewController+requireLogin.h"

@interface DiaryDetailVCB()

@property (strong, nonatomic)NSURL *url;
@property (strong, nonatomic)WebviewRequestModel *commentRequest;
@property ShareViewManager* share;
@end
@implementation DiaryDetailVCB {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate=self;
    self.webView.opaque = NO;
    self.webView.backgroundColor = [UIColor whiteColor];
    self.share= [ShareViewManager new];

    if(self.type==WebviewWithCommentVcDetailTypeDiary){

        self.url=[NSURL URLWithString:[NSString stringWithFormat:
                @"http://apptest.jiayantech.com/html/diary.html?id=%@",@(self.diary.id)]];
    }else{
        self.url=[NSURL URLWithString:[NSString stringWithFormat:
                @"http://apptest.jiayantech.com/html/topic.html?id=%@",@(self.topic.id)]];
    }
    NSLog(@"self.url: %@",self.url);
    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:self.url]];

    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"分享.png"]
                                                                             style:UIBarButtonItemStylePlain target:self
                                                                            action:@selector(sharePress)];

    self.commentRequest= [[WebviewRequestModel alloc] initWithDictionary:@{@"action":@"openCommentPanel",@"success":@"G_renderPostComment"} error:nil];


//    [self.composeBarView.textContainer addTarget:self
//                                          action:@selector(keyboardGoesUped) forControlEvents:UIControlEventTouchUpInside];


//    self.view.backgroundColor=THEME_COLOR_BACKGROUND;
}

-(void)sharePress{
    [self.share showSharePanelOnto:self.navigationController.view];
}


- (void)likeButtonPress:(UIButton *)sender {
    NSNumber *iden;
    if(self.type==WebviewWithCommentVcDetailTypeDiary){
        iden= @(self.diary.id);
    }else{
        iden= @(self.topic.id);
    }
    if(sender.selected){
        sender.selected=NO;
        [[MLSession current] cancelLikePostId:iden
                                      success:^{

                                      } fail:^(NSInteger i, id o) {
                    sender.selected=YES;
                    [TSMessage showNotificationWithTitle:@"出错了"
                                                subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
                                                    type:TSMessageNotificationTypeError];
                }];
    }else{
        sender.selected=YES;

        [[MLSession current] likePostId:iden
                                success:^{

                                } fail:^(NSInteger i, id o) {
                    sender.selected=NO;
                    [TSMessage showNotificationWithTitle:@"出错了"
                                                subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
                                                    type:TSMessageNotificationTypeError];
                }];
    }
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
    }else if([requestModel.action isEqualToString:@"getShareInfo"]){

        self.share.shareTitle=requestModel.data[@"title"];
        self.share.shareDesc=requestModel.data[@"content"];
        self.share.shareIconUrl=requestModel.data[@"thumbnail"];
        self.share.shareUrl= [self.url absoluteString];

    }else if([requestModel.action isEqualToString:@"openCommentPanel"]){
        self.commentRequest=requestModel;
        [self.composeBarView.textView becomeFirstResponder];
        if(requestModel.data[@"toUserName"]){
            self.composeBarView.placeholder=[NSString stringWithFormat:@"回复%@:",requestModel.data[@"toUserName"]];
        }else{
            self.composeBarView.placeholder=[NSString stringWithFormat:@"评论"];
        }
    }else if([requestModel.action isEqualToString:@"setNavigationBarTitle"]){

        self.title=requestModel.data[@"title"];
    }else if([requestModel.action isEqualToString:@"playImg"]){
        [self showImageBrowserWithImages:requestModel.data[@"imgList"] startIndex:[requestModel.data[@"defaultIndex"] unsignedIntegerValue]];
    }else if([requestModel.action isEqualToString:@"scrollBottomToPosY"]){
        NSUInteger posY= [requestModel.data[@"posY"] unsignedIntegerValue];
        NSUInteger posYtop=posY-self.webView.frame.size.height;
        [self.webView.scrollView setContentOffset:CGPointMake(0, posYtop) animated:YES];


    }else if([requestModel.action isEqualToString:@"getUserInfo"]){
        if([MLSession current].isLogined){
            NSMutableDictionary  *d= [[[MLSession current].currentUser toDictionary] mutableCopy];
            d[@"token"]=[MLSession current].token;
            d[@"phone"]=[MLSession current].currentUser.phoneNum;


            [[WebviewRespondModel respondWithCode:@0
                                              msg:@"ok"
                                             data:d] respondToWebview:self.webView
                                                          withReqeust:requestModel
                                                            isSuccess:YES];
        }else{
            [[WebviewRespondModel respondWithCode:@NOT_LOGIN_CODE
                                              msg:@"ok"
                                             data:@{
                                                     @"token":[MLSession current].token,
                                             }] respondToWebview:self.webView
                                                     withReqeust:requestModel
                                                       isSuccess:YES];
        }


    }else if([requestModel.action isEqualToString:@"postDetailData"]){


        if(self.type==WebviewWithCommentVcDetailTypeDiary){
            DiaryModel *diary= [[DiaryModel alloc] initWithDictionary:requestModel.data
                                                                error:nil];
            self.composeBarView.likeButton.selected= [diary.isLike boolValue];
        }

    }

    return NO;
}

-(BOOL)handleRedirectRequests:(NSURL *)url{

    return NO;
}

- (BOOL)textViewWillBecomeFirstResponder {

    if(![MLSession current].isLogined){
//        [self.composeBarView.textView resignFirstResponder];
//        [self.view endEditing:YES];
        [self requireLogin];

        return NO;
    }

    return YES;
}

#pragma mark - specific handles

- (void)composeBarViewDidPressButton:(PHFComposeBarView *)composeBarView {
//    NSString *text = [NSString stringWithFormat:@"Main button pressed. Text:\n%@", [composeBarView text]];
//    [self prependTextToTextView:text];



    NSString *comment= self.composeBarView.text;
    if([comment length]==0){
        [TSMessage showNotificationWithTitle:@"请输入评论内容"
                                        type:TSMessageNotificationTypeWarning];
        return;
    }

    WebviewRequestModel *request=self.commentRequest;
    UIWebView *webView=self.webView;
    __weak DiaryDetailVCB* weakSelf = self;

    NSString *subject=request.data ? request.data[@"subject"] : (self.type==WebviewWithCommentVcDetailTypeDiary? @"diary":@"topic");
    NSNumber *subjectId=request.data ? request.data[@"subjectId"] : @(self.type==WebviewWithCommentVcDetailTypeDiary? self.diary.id:self.topic.id);


    [[MLSession current] createCommentWithSubject:subject
                                        subjectId:subjectId
                                          content:comment
                                          success:^(NSUInteger id, NSDictionary *respondObject) {
                                              NSMutableDictionary *d = [@{
                                                      @"subject" : subject,
                                                      @"subjectId" : subjectId,
                                                      @"userName" : [[MLSession current] currentUser].name?[[MLSession current] currentUser].name:@"",
                                                      @"userId" : @([[MLSession current] currentUser].id),
                                                      @"createTime" : respondObject[@"createTime"],
                                                      @"content" : comment,
                                                      @"id" : @(id),
                                              } mutableCopy];
                                              if (request&&request.data[@"toUserName"]) {
                                                  d[@"toUserName"] = request.data[@"toUserName"];
                                              }

                                              if(request&&request.data[@"toUserId"]){
                                                  d[@"toUserId"]=request.data[@"toUserId"];
                                              }

                                              [[WebviewRespondModel respondWithCode:@0
                                                                                msg:@"ok"
                                                                               data:d] respondToWebview:webView
                                                                                            withReqeust:request
                                                                                              isSuccess:YES];
                                              [composeBarView setText:@"" animated:YES];
                                              [composeBarView resignFirstResponder];
                                              self.composeBarView.placeholder=[NSString stringWithFormat:@"评论"];

                                          } fail:^(NSInteger i, id o) {
                [TSMessage showNotificationWithTitle:@"出错了"
                                            subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
                                                type:TSMessageNotificationTypeError];
            }];


//    if (self.shouldClearTextAtRightButtonPress) {
//        // Clears the text and the undo manager
//        [self.textView slk_clearText:YES];
//    }
//
//    // Clears cache
//    [self clearCachedText];

}


-(void)showImageBrowserWithImages:(NSArray *)imageUrls startIndex:(NSUInteger)index{
    NSArray *photosWithURL = [IDMPhoto photosWithURLs:imageUrls];

    NSMutableArray * photos = [NSMutableArray arrayWithArray:photosWithURL];
// Create and setup browser
    IDMPhotoBrowser *browser = [[IDMPhotoBrowser alloc] initWithPhotos:photos];
    [browser setInitialPageIndex:index];
    browser.displayActionButton=NO;

    browser.delegate = self;
    [self presentViewController:browser animated:YES completion:nil];

}


@end