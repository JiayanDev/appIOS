//
// Created by zcw on 15/9/6.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "MLBlurImageHeaderedWebview.h"
#import "FXBlurView.h"
#import "MLStyleManager.h"


#define IMAGEVIEW_HEIGHT 100

CGFloat const offset_HeaderStop = 40.0;
CGFloat const offset_B_LabelHeader = 95.0;
CGFloat const distance_W_LabelHeader = 35.0;

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


    self.backgroundImageOrigin=[UIImage imageNamed:@"Y80Y09B4Y73E.jpg"];
    self.backgroundImageBlured= [self.backgroundImageOrigin blurredImageWithRadius:50
                                                                        iterations:5
                                                                         tintColor:[UIColor colorWithHexString:@"888888" alpha:0.2]];

    self.imageView.image=self.backgroundImageBlured;
    self.imageView.contentMode=UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;


    self.headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.imageView.frame.size.height - 5, self.frame.size.width, 25)];
    self.headerLabel.textAlignment = NSTextAlignmentCenter;
    self.headerLabel.text = @"hahahahahaha";
    self.headerLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18];
    self.headerLabel.textColor = [UIColor whiteColor];

    
    
    

    self.webView= [[UIWebView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height)];
    self.webView.scrollView.contentInset=UIEdgeInsetsMake(IMAGEVIEW_HEIGHT,0,0,0);

    self.webView.scrollView.delegate=self;
    NSURL *websiteUrl = [NSURL URLWithString:@"http://news.qq.com"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
    [self.webView loadRequest:urlRequest];
    [self addSubview:self.webView];
    [self addSubview:self.imageView];
    [self.imageView addSubview:self.headerLabel];



}



-(void)setupVC:(UIViewController *)viewController{
    [MLStyleManager hideTheHairLine:viewController.navigationController.navigationBar];
    [viewController.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    viewController.navigationController.navigationBar.shadowImage = [UIImage new];
    viewController.navigationController.navigationBar.translucent = YES;
    viewController.navigationController.view.backgroundColor = [UIColor clearColor];
    viewController.navigationController.navigationBar.backgroundColor = [UIColor clearColor];


};


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y;
    [self animationForScroll:offset];
}

- (void)animationForScroll:(CGFloat)offset {
//    NSLog(@"%2.2f",offset);

    CATransform3D headerTransform = CATransform3DIdentity;
    CATransform3D avatarTransform = CATransform3DIdentity;

    offset+=IMAGEVIEW_HEIGHT;


    // DOWN -----------------

    if (offset < 0) {

        CGFloat headerScaleFactor = -(offset) / self.imageView.bounds.size.height;
        CGFloat headerSizevariation = ((self.imageView.bounds.size.height * (1.0 + headerScaleFactor)) - self.imageView.bounds.size.height)/2.0;
        headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0);
        headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0);

        NSLog(@"%2.2f, %2.2f, %2.2f",offset,headerScaleFactor,headerSizevariation);

        self.imageView.layer.transform = headerTransform;
//
//        if (offset < -self.frame.size.height/3.5) {
//            [self recievedMBTwitterScrollEvent];
//        }

    }

        // SCROLL UP/DOWN ------------

    else {

        // Header -----------
        headerTransform = CATransform3DTranslate(headerTransform, 0, MAX(-offset_HeaderStop, -offset), 0);

        //  ------------ Label
        CATransform3D labelTransform = CATransform3DMakeTranslation(0, MAX(-distance_W_LabelHeader, offset_B_LabelHeader - offset), 0);
        self.headerLabel.layer.transform = labelTransform;
        self.headerLabel.layer.zPosition = 2;

//        // Avatar -----------
//        CGFloat avatarScaleFactor = (MIN(offset_HeaderStop, offset)) / self.avatarImage.bounds.size.height / 1.4; // Slow down the animation
//        CGFloat avatarSizeVariation = ((self.avatarImage.bounds.size.height * (1.0 + avatarScaleFactor)) - self.avatarImage.bounds.size.height) / 2.0;
//        avatarTransform = CATransform3DTranslate(avatarTransform, 0, avatarSizeVariation, 0);
//        avatarTransform = CATransform3DScale(avatarTransform, 1.0 - avatarScaleFactor, 1.0 - avatarScaleFactor, 0);

//        if (offset <= offset_HeaderStop) {
//
//            if (self.avatarImage.layer.zPosition <= self.headerImageView.layer.zPosition) {
//                self.imageView.layer.zPosition = 0;
//            }
//
//        }else {
//            if (self.avatarImage.layer.zPosition >= self.headerImageView.layer.zPosition) {
//                self.imageView.layer.zPosition = 2;
//            }
//        }

    }
//    if (self.headerImageView.image != nil) {
//        [self blurWithOffset:offset];
//    }
//    self.imageView.layer.transform = headerTransform;
//    self.avatarImage.layer.transform = avatarTransform;



}


@end