//
// Created by zcw on 15/9/14.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "NotificationListCell.h"
#import "UIImageView+MLStyle.h"
#import "UILabel+MLStyle.h"


@implementation NotificationListCell {

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.avatarView=[UIImageView newWithRoundRadius:18];
        self.timeLabel=[UILabel newMLStyleWithSize:10 isGrey:YES];
        self.nameLabel=[UILabel newMLStyleWithSize:13 isGrey:NO];
        self.actionLabel=[UILabel newMLStyleWithSize:13 isGrey:NO];
        self.contentLabel=[UILabel newMLStyleWithSize:13 isGrey:NO];
        self.secondContentImageView=[UIImageView new];
        self.secondContentLabel=[UILabel newMLStyleWithSize:13 isGrey:YES];

        self.secondContentImageView.image= [[UIImage imageNamed:@"气泡.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(24,28,19,25)];

        [self.contentView addSubview:self.avatarView];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.actionLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.secondContentImageView];
        [self.secondContentImageView addSubview:self.secondContentLabel];

        [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(17);
            make.left.equalTo(self.contentView).offset(10);
            make.size.mas_equalTo(CGSizeMake(35,35));
        }];

        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.avatarView);
            make.right.equalTo(self.contentView).offset(-15);

        }];

        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.avatarView);
            make.left.equalTo(self.avatarView.mas_right).offset(10);
        }];

        [self.actionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.avatarView);
            make.left.equalTo(self.nameLabel.mas_right).offset(10);
        }];

        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(15);
            make.left.equalTo(self.avatarView.mas_right).offset(10);
            make.bottom.equalTo(self.contentView).offset(17).priority(500);
        }];

        [self.secondContentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(15);
            make.left.equalTo(self.avatarView.mas_right).offset(10);
            make.bottom.equalTo(self.contentView).offset(17).priority(600);
        }];

        [self.secondContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.secondContentImageView).insets(UIEdgeInsetsMake(15,10,10,10));
        }];


    }

    return self;
}

@end