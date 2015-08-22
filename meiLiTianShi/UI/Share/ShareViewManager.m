//
// Created by zcw on 15/8/22.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "ShareViewManager.h"


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
    CGFloat height=200;

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

        [self.ontoView setNeedsLayout];
        [self.ontoView setNeedsUpdateConstraints];
        [self.ontoView layoutIfNeeded];

        [UIView animateWithDuration:animateDuration
                              delay:0
                            options:UIViewAnimationOptionTransitionCurlUp
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

@end