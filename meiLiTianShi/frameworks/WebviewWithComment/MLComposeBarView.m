//
// Created by zcw on 15/10/13.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "MLComposeBarView.h"


@implementation MLComposeBarView {

}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.likeButton=[UIButton new];
        [self.likeButton setImage:[UIImage imageNamed:@"赞－灰.png"] forState:UIControlStateNormal];
        [self.likeButton setImage:[UIImage imageNamed:@"赞－亮.png"] forState:UIControlStateSelected];



        self.submitButton=[UIButton new];
        [self.submitButton setImage:[UIImage imageNamed:@"确定.png"] forState:UIControlStateNormal];

        self.buttonDeamon=self.likeButton;
        self.button=self.buttonDeamon;
    }

    return self;
}


- (void)setButtonTitle:(NSString *)buttonTitle {
    //nothing
}


- (UIButton *)button {
    return self.button;
}

@end