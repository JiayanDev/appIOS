//
// Created by zcw on 15/9/8.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "MyBanMeiCellB.h"
#import "UILabel+MLStyle.h"


@implementation MyBanMeiCellB {

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){

        self.thumbImageView=[UIImageView new];
        self.thumbImageView.contentMode=UIViewContentModeScaleAspectFill;

        self.titleLabel=[UILabel newMLStyleWithSize:14 isGrey:NO];

        self.descLabel=[UILabel newMLStyleWithSize:12 isGrey:YES];






    }
    return self;
}

@end