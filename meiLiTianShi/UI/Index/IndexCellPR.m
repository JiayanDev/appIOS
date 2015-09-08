//
// Created by zcw on 15/9/8.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "IndexCellPR.h"
#import "UIImageView+MLStyle.h"
#import "UILabel+MLStyle.h"


@implementation IndexCellPR {

}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){

        self.backImage=[UIImageView new];
        self.statusBackImage=[UIImageView new];
        self.statusLabel=[UILabel newMLStyleWithSize:15 isGrey:NO];
        self.statusLabel.textColor=[UIColor whiteColor];
        
        self.footView=[UIView new];
        self.doctorAvatar=[UIImageView newWithRoundRadius:15];
        
        self.doctorNameLabel=[UILabel newMLStyleWithSize:12 isGrey:NO];
        self.doctorDescLabel=[UILabel newMLStyleWithSize:12 isGrey:YES];

        [self.contentView addSubview:self.backImage];
        [self.backImage addSubview:self.statusBackImage];
        [self.statusBackImage addSubview:self.statusLabel];

        [self.contentView addSubview:self.footView];
        [self.footView addSubview:self.doctorAvatar];
        [self.footView addSubview:self.doctorNameLabel];
        [self.footView addSubview:self.doctorDescLabel];

        [self.backImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.contentView);
            make.height.equalTo(self.contentView).multipliedBy(380.0/750.0);
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
        }];

        [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44);
            make.top.equalTo(self.backImage.mas_bottom);
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        }];

        [self.statusBackImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.backImage).offset(16);
            make.right.equalTo(self.backImage);

        }];




    }
    return self;
}
@end