//
// Created by zcw on 15/9/6.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "MLBlurImageHeaderedWebview.h"
#import "FXBlurView.h"
#import "MLStyleManager.h"
#import "UILabel+MLStyle.h"


#define IMAGEVIEW_HEIGHT 220
#define IMAGEVIEW_HEIGHT_SHRINK 64

CGFloat const offset_HeaderStop = IMAGEVIEW_HEIGHT-IMAGEVIEW_HEIGHT_SHRINK;
CGFloat const offset_B_LabelHeader = 95.0;
CGFloat const distance_W_LabelHeader = 31.0;

@implementation MLBlurImageHeaderedWebview {

}

- (instancetype)init {
    CGRect bounds = [[UIScreen mainScreen] bounds];
    if(self=[super initWithFrame:bounds]){

        [self setupSubviews];
    }
    return self;
}

-(void)setupSubviews{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    self.imageView= [[UIImageView alloc] initWithFrame:CGRectMake(0,0,bounds.size.width,IMAGEVIEW_HEIGHT )];



    self.imageView.contentMode=UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;


    self.headerLabel = [UILabel newMLStyleWithSize:15 isGrey:NO];
    self.headerLabel.frame=CGRectMake(self.frame.origin.x, self.imageView.frame.size.height - 5, self.frame.size.width, 25);
    self.headerLabel.textAlignment = NSTextAlignmentCenter;
    self.headerLabel.text = @"hahahahahaha";
//    self.headerLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18];
    self.headerLabel.textColor = [UIColor whiteColor];

    
    
    

    self.webView= [[UIWebView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height)];
    self.webView.scrollView.contentInset=UIEdgeInsetsMake(IMAGEVIEW_HEIGHT,0,0,0);

    self.webView.scrollView.delegate=self;
//    NSURL *websiteUrl = [NSURL URLWithString:@"http://apptest.jiayantech.com/html/timeline.html?id=495"];
//    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:10];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];

//    [self.webView loadRequest:urlRequest];
    [self addSubview:self.webView];
    [self addSubview:self.imageView];
    [self.imageView addSubview:self.headerLabel];
    
    
    
    
    
    self.nameLabel=[UILabel newMLStyleWithSize:14 isGrey:NO];
    self.nameLabel.textColor=[UIColor whiteColor];

    self.descLabel=[UILabel newMLStyleWithSize:10 isGrey:NO];
    self.descLabel.textColor=[UIColor whiteColor];
    
    self.avatarView=[UIImageView new];

    self.avatarView.layer.cornerRadius = 33;
    self.avatarView.clipsToBounds = YES;
    self.avatarView.contentMode=UIViewContentModeScaleAspectFill;

    [self addSubview:self.nameLabel];
    [self addSubview:self.descLabel];
    [self addSubview:self.avatarView];


    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(65,65));
        make.top.equalTo(self.imageView).offset(66);
        make.centerX.equalTo(self.imageView);
    }];

    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imageView);
        make.top.equalTo(self.avatarView.mas_bottom).offset(10);
    }];

    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imageView);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
    }];












}


- (void)setBackgroundImageOrigin:(UIImage *)backgroundImageOrigin {
    _backgroundImageOrigin=backgroundImageOrigin;
    self.backgroundImageBlured= [self.backgroundImageOrigin blurredImageWithRadius:100
                                                                        iterations:10
                                                                         tintColor:[UIColor colorWithHexString:@"333333" alpha:0.3]];

    self.imageView.image=self.backgroundImageBlured;
}



-(void)setupVC:(UIViewController *)viewController{
    [MLStyleManager hideTheHairLine:viewController.navigationController.navigationBar];
    [viewController.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    viewController.navigationController.navigationBar.shadowImage = [UIImage new];
    viewController.navigationController.navigationBar.translucent = YES;
    viewController.navigationController.view.backgroundColor = [UIColor clearColor];
    viewController.navigationController.navigationBar.backgroundColor = [UIColor clearColor];

    viewController.navigationController.navigationBar.backIndicatorImage= [[UIImage imageNamed:@"timeline_返回-.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

};

-(void)unsetupVC:(UIViewController *)viewController{
    [viewController.navigationController.navigationBar setBackgroundImage:nil
                                                  forBarMetrics:UIBarMetricsDefault];
    [MLStyleManager styleTheNavigationBar:viewController.navigationController.navigationBar];

}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y;
    [self animationForScroll:offset];
}

- (void)animationForScroll:(CGFloat)offset {

    CATransform3D headerTransform = CATransform3DIdentity;

    offset+=IMAGEVIEW_HEIGHT;


    // DOWN -----------------

    if (offset < 0) {

        CGFloat headerScaleFactor = -(offset) / self.imageView.bounds.size.height;
        CGFloat headerSizevariation = ((self.imageView.bounds.size.height * (1.0 + headerScaleFactor)) - self.imageView.bounds.size.height)/2.0;
        headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0);
        headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0);

        NSLog(@"%2.2f, %2.2f, %2.2f",offset,headerScaleFactor,headerSizevariation);

        self.imageView.layer.transform = headerTransform;


         headerTransform = CATransform3DIdentity;

        headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0);


        //  ------------ Label
        self.avatarView.layer.transform = headerTransform;
        self.nameLabel.layer.transform = headerTransform;
        self.descLabel.layer.transform = headerTransform;

    }

        // SCROLL UP/DOWN ------------

    else {

        // Header -----------
        headerTransform = CATransform3DTranslate(headerTransform, 0, MAX(-offset_HeaderStop, -offset), 0);



        self.imageView.layer.transform = headerTransform;
        self.avatarView.layer.transform = headerTransform;
        self.nameLabel.layer.transform = headerTransform;
        self.descLabel.layer.transform = headerTransform;



    }

    //  ------------ Label
    CATransform3D labelTransform = CATransform3DMakeTranslation(0, MAX(-distance_W_LabelHeader, offset_B_LabelHeader - offset), 0);
    self.headerLabel.layer.transform = labelTransform;
    self.headerLabel.layer.zPosition = 2;


    CGFloat opa=(offset-offset_B_LabelHeader)/distance_W_LabelHeader;
    opa=1-opa;
    if(opa<0){opa=0;}
    if(opa>1){opa=1;}

    self.avatarView.layer.opacity=opa;
    self.nameLabel.layer.opacity=opa;
    self.descLabel.layer.opacity=opa;


}


@end