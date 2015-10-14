//
// Created by zcw on 15/8/22.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "ShareViewManager.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import "MLSession.h"
#import "TSMessage.h"
#import "SDWebImageManager.h"


@interface ShareViewManager ()
@property(nonatomic, strong) UIButton *mask;
@property(nonatomic, strong) UIView *panel;
@property(nonatomic, strong) UIView *ontoView;
@end

@implementation ShareViewManager {

}
#define animateDuration 0.3
+(ShareViewManager*)showSharePanelOnto:(UIView *)view {
    ShareViewManager* shareViewManager=[[ShareViewManager alloc]init];
    [shareViewManager showSharePanelOnto:view];
    return shareViewManager;
}

- (void)showSharePanelOnto:(UIView *)view {
    self.ontoView = view;
    [self showOrHideMask:YES];
    [self showOrHidePanel:YES];

}


-(void)disappearAll{
    [self showOrHideMask:NO];
    [self showOrHidePanel:NO];
}

- (void)showOrHideMask:(BOOL)isShow {
    if (isShow) {
        UIButton *b = [[UIButton alloc] init];
        b.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.00];
        [self.ontoView addSubview:b];

        [b mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.ontoView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));

        }];

        [UIView animateWithDuration:animateDuration animations:^{
            b.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.3];
        }];

        self.mask = b;
        [self.mask addTarget:self
              action:@selector(disappearAll) forControlEvents:UIControlEventTouchUpInside];

    } else {
        [UIView animateWithDuration:animateDuration
                         animations:^{
                             self.mask.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.00];
                         } completion:^(BOOL finished) {
                    [self.mask removeFromSuperview];
                    self.mask = nil;
                }];
    }
}


- (void)showOrHidePanel:(BOOL)isShow {
    CGFloat height=300;

    if (isShow) {
        UIView *v = [[UIView alloc] init];
        v.backgroundColor = THEME_COLOR_BACKGROUND;
        [self.ontoView addSubview:v];

        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.ontoView);
            make.right.equalTo(self.ontoView);
            make.height.mas_equalTo(@(height));
            make.top.equalTo(self.ontoView.mas_bottom);

        }];

        [self layoutThePanel:v];

        [self.ontoView setNeedsLayout];
        [self.ontoView setNeedsUpdateConstraints];
        [self.ontoView layoutIfNeeded];

        [UIView animateWithDuration:animateDuration
                              delay:0
                            options:UIViewAnimationOptionTransitionFlipFromBottom
                         animations:^{

                    [v mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(self.ontoView.mas_bottom).with.offset(-height);

                    }];
                    [self.ontoView layoutIfNeeded];
                    [self.ontoView setNeedsLayout];
                    [self.ontoView setNeedsUpdateConstraints];
                } completion:^(BOOL finished) {

                }];



        self.panel = v;

    } else {

        [UIView animateWithDuration:animateDuration
                              delay:0
                            options:UIViewAnimationOptionTransitionCurlUp
                         animations:^{
                             [self.panel mas_updateConstraints:^(MASConstraintMaker *make) {
                                 make.top.equalTo(self.ontoView.mas_bottom).with.offset(0);

                             }];


                             [self.ontoView layoutIfNeeded];
                         } completion:^(BOOL finished) {
                    [self.panel removeFromSuperview];
                    self.panel = nil;
                }];



    }
}

-(void)settleShareButton:(UIButton *)button withImage:(UIImage *)image text:(NSString *)text{
    [button setImage:image forState:UIControlStateNormal];
//    [button setImage:[image imageWithOverlayColor:[UIColor colorWithHexString:@"000000" alpha:0.3]] forState:UIControlStateHighlighted];
    [button setTitle:text forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 13, 0, 0)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(84, -45, 0, 0)];
    [button setContentEdgeInsets:UIEdgeInsetsMake(0, -13, 23, 0)];
    [button setTitleColor:THEME_COLOR_TEXT forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@58);
    }];
}

-(void)layoutThePanel:(UIView *)panel{

    UIButton *wxb = [[UIButton alloc] init];
    [self settleShareButton:wxb
                  withImage:[UIImage imageNamed:@"分享_微信.png"] text:@"微信"];

    [panel addSubview:wxb];


    UIButton *pyq = [[UIButton alloc] init];
    [self settleShareButton:pyq
                  withImage:[UIImage imageNamed:@"分享_朋友圈.png"] text:@"朋友圈"];
    [panel addSubview:pyq];
    [pyq addTarget:self
            action:@selector(sendToPYQ) forControlEvents:UIControlEventTouchUpInside];
    [wxb addTarget:self
            action:@selector(sendToWXFriend) forControlEvents:UIControlEventTouchUpInside];


//    UIButton *wbb = [[UIButton alloc] init];
//    [self settleShareButton:wbb
//                  withImage:[UIImage imageNamed:@"分享_微博.png"] text:@"新浪微博"];
//    [panel addSubview:wbb];
//
//    UIButton *qqk = [[UIButton alloc] init];
//    [self settleShareButton:qqk
//                  withImage:[UIImage imageNamed:@"分享_qq空间.png"] text:@"QQ空间"];
//    [panel addSubview:qqk];

    UIView* v1= [[UIView alloc] init];
    [panel addSubview:v1];

    UIView* v2= [[UIView alloc] init];
    [panel addSubview:v2];

    UIView* v3= [[UIView alloc] init];
    [panel addSubview:v3];



    [wxb mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(panel).with.offset(24);
        make.centerY.equalTo(panel).offset(-11);
    }];

    [pyq mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(panel).offset(-11);
    }];

//    [wbb mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(panel).offset(-11);
//    }];
//
//    [qqk mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(panel).offset(-11);
//        make.right.equalTo(panel).with.offset(-24);
//    }];

    [v1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_greaterThanOrEqualTo(@1);
        make.width.equalTo(v2.mas_width).multipliedBy(2);
        make.centerY.equalTo(panel);
        make.left.equalTo(wxb.mas_right);
        make.right.equalTo(pyq.mas_left);

    }];

    [v2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(v3.mas_width);
        make.centerY.equalTo(panel);
        make.left.equalTo(panel);
        make.right.equalTo(wxb.mas_left);

    }];

    [v3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(v1.mas_width).multipliedBy(0.5);
        make.centerY.equalTo(panel);
        make.left.equalTo(pyq.mas_right);
        make.right.equalTo(panel);

    }];



    UILabel *title= [[UILabel alloc] init];
    [panel addSubview:title];
    title.text=@"分享到";
    title.font=[UIFont systemFontOfSize:13];
    title.textColor=THEME_COLOR_TEXT;
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(panel).with.offset(17);
        make.centerX.equalTo(panel);
    }];


    UIButton *cancelButton =[UIButton new];
    [panel addSubview:cancelButton];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.titleLabel.font=[UIFont systemFontOfSize:15];
    [cancelButton setTitleColor:THEME_COLOR_TEXT forState:UIControlStateNormal];
    [cancelButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"ffffff"]] forState:UIControlStateNormal];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(panel).with.offset(-17);
        make.left.equalTo(panel).offset(15);
        make.right.equalTo(panel).offset(-15);
        make.height.mas_equalTo(@45);
    }];
    cancelButton.layer.cornerRadius = 4;
    cancelButton.clipsToBounds = YES;
    [cancelButton addTarget:self
                     action:@selector(disappearAll) forControlEvents:UIControlEventTouchUpInside];


}


-(void)sendToPYQ{
    [self shareToWxWithType:WXSceneTimeline];


}

-(void)sendToWXFriend{
    [self shareToWxWithType:WXSceneSession];


}




-(void)shareToWxWithType:(enum WXScene)type{
    if(!self.shareTitle || !self.shareIconUrl ||!self.shareUrl){
        return;
    }

    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:[[NSURL alloc] initWithString:self.shareIconUrl]
                          options:0
                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                             // progression tracking code
                         }
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                            if (image) {
                                WXMediaMessage *message = [WXMediaMessage message];
                                message.title = self.shareTitle;
                                message.description = self.shareDesc;
                                [message setThumbImage:image];

                                WXWebpageObject *ext = [WXWebpageObject object];
                                ext.webpageUrl = self.shareUrl;

                                message.mediaObject = ext;
                                message.mediaTagName = @"WECHAT_TAG_JUMP_SHOWRANK";

                                SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
                                req.bText = NO;
                                req.message = message;
                                req.scene = type;
                                [MLSession current].wxMessageRespHandler=self;
                                [WXApi sendReq:req];
                            }
                        }];



}



- (void)handleWxSendMessageRespond:(SendMessageToWXResp *)resp {
    if(resp.errCode==0){
        [TSMessage showNotificationWithTitle:@"分享成功" type:TSMessageNotificationTypeSuccess];
        [self disappearAll];
    }else{
        [TSMessage showNotificationWithTitle:@"分享失败" type:TSMessageNotificationTypeError];
    }
}
@end