//
// Created by zcw on 15/10/13.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "MLComposeBarView.h"
#import "PHFComposeBarView_Button.h"




@implementation MLComposeBarView {

}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

//        self.button=self.buttonDeamon;
    }

    return self;
}


- (void)setButtonTitle:(NSString *)buttonTitle {
    //nothing
}


- (UIButton *)button {
    CGFloat kHorizontalSpacing = 8.0f;

    CGFloat kButtonHeight = 26.0f;
    CGFloat kButtonTouchableOverlap = 6.0f;
    CGFloat kButtonRightMargin = -2.0f;
    CGFloat kButtonBottomMargin = 8.0f;
    if (!self.buttonDeamon) {
        CGRect frame = CGRectMake([self bounds].size.width - kHorizontalSpacing - kButtonRightMargin - kButtonTouchableOverlap,
                [self bounds].size.height - kButtonBottomMargin - kButtonHeight,
                kButtonTouchableOverlap*2,
                kButtonHeight);
        self.likeButton = [PHFComposeBarView_Button buttonWithType:UIButtonTypeCustom];
        [self.likeButton setImage:[UIImage imageNamed:@"赞－灰.png"] forState:UIControlStateNormal];
        [self.likeButton setImage:[UIImage imageNamed:@"赞－亮.png"] forState:UIControlStateSelected];
        [self.likeButton setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin];
        self.likeButton.frame = frame;


        self.submitButton = [PHFComposeBarView_Button buttonWithType:UIButtonTypeCustom];
        [self.submitButton setImage:[UIImage imageNamed:@"确定.png"] forState:UIControlStateNormal];
        [self.submitButton setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin];

        self.submitButton.frame = frame;

        self.buttonDeamon = self.likeButton;

        [self addSubview:self.likeButton];
        [self addSubview:self.submitButton];
        self.submitButton.hidden=YES;
        [self.submitButton addTarget:self
                              action:@selector(didPressButton) forControlEvents:UIControlEventTouchUpInside];

    }
    return nil;
}

//
- (void)resizeButton {

    CGFloat kButtonTouchableOverlap = 6.0f;
    CGFloat kHorizontalSpacing = 8.0f;


    CGRect previousButtonFrame = [[self submitButton] frame];
    CGRect newButtonFrame = previousButtonFrame;
    CGRect textContainerFrame = [[self textContainer] frame];
    CGRect charCountLabelFrame = [[self charCountLabel] frame];

    [[self submitButton] sizeToFit];
    CGFloat widthDelta = [[self submitButton] bounds].size.width + 2 * kButtonTouchableOverlap - previousButtonFrame.size.width;

    newButtonFrame.size.width += widthDelta;
    newButtonFrame.origin.x -= widthDelta;
    [[self submitButton] setFrame:newButtonFrame];
    [[self likeButton] setFrame:newButtonFrame];

    textContainerFrame.size.width -= widthDelta;
    [[self textContainer] setFrame:textContainerFrame];

    charCountLabelFrame.origin.x = textContainerFrame.origin.x + textContainerFrame.size.width;
    charCountLabelFrame.size.width = [self bounds].size.width - charCountLabelFrame.origin.x - kHorizontalSpacing;
    [[self charCountLabel] setFrame:charCountLabelFrame];
}

@end