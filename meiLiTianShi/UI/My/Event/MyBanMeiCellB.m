//
// Created by zcw on 15/9/8.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "MyBanMeiCellB.h"
#import "UILabel+MLStyle.h"
#import "UIButton+MLStyle.h"


@implementation MyBanMeiCellB {

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){

        self.thumbImageView=[UIImageView new];
        self.thumbImageView.contentMode=UIViewContentModeScaleAspectFill;
        self.thumbImageView.clipsToBounds=YES;

        self.titleLabel=[UILabel newMLStyleWithSize:14 isGrey:NO];

        self.descLabel=[UILabel newMLStyleWithSize:12 isGrey:YES];

        self.statusLable=[UILabel newMLStyleWithSize:12 isGrey:YES];

        self.timeLabel=[UILabel newMLStyleWithSize:10 isGrey:YES];

        self.pingjiaButton=[UIButton newBorderedColorButtonWithTitle:@"评价" fontSize:12];

        [self.contentView addSubview:self.thumbImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.descLabel];
        [self.contentView addSubview:self.statusLable];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.pingjiaButton];

        [self.thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(17);
            make.top.equalTo(self.contentView).offset(17);
            make.bottom.equalTo(self.contentView).offset(-17);
            make.size.mas_equalTo(CGSizeMake(60,60));
        }];

        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(17);
            make.left.equalTo(self.thumbImageView.mas_right).offset(20);



        }];

        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
            make.left.equalTo(self.thumbImageView.mas_right).offset(20);
        }];

        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.thumbImageView.mas_right).offset(20);
            make.bottom.equalTo(self.contentView).offset(-17);
        }];


        [self.statusLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15);
            make.centerY.equalTo(self.contentView);
        }];

        [self.pingjiaButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15);
            make.centerY.equalTo(self.contentView);
            make.width.mas_greaterThanOrEqualTo(50);
        }];


    }
    return self;
}

@end