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
        self.statusLabel=[UILabel newMLStyleWithSize:12 isGrey:NO];
        self.statusLabel.textColor=[UIColor whiteColor];
        
        self.footView=[UIView new];
        self.doctorAvatar=[UIImageView newWithRoundRadius:15];
        
        self.doctorNameLabel=[UILabel newMLStyleWithSize:12 isGrey:NO];
        self.doctorDescLabel=[UILabel newMLStyleWithSize:12 isGrey:YES];
        self.doctorDescLabel.textColor=THEME_COLOR_TEXT_DARKER_GRAY;

        [self.contentView addSubview:self.backImage];
        [self.backImage addSubview:self.statusBackImage];
        [self.statusBackImage addSubview:self.statusLabel];

        [self.contentView addSubview:self.footView];
        [self.footView addSubview:self.doctorAvatar];
        [self.footView addSubview:self.doctorNameLabel];
        [self.footView addSubview:self.doctorDescLabel];

        self.statusBackImage.image= [[UIImage imageNamed:@"活动状态标签－底.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(14,36,11,34)];
        self.backImage.clipsToBounds=YES;
        self.backImage.contentMode=UIViewContentModeScaleAspectFill;
        self.doctorDescLabel.textAlignment=NSTextAlignmentRight;

        [self.backImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.contentView);
            make.height.equalTo(self.contentView.mas_width).multipliedBy(380.0/750.0);
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
            make.height.mas_equalTo([UIImage imageNamed:@"活动状态标签－底.png"].size.height);
            make.width.mas_greaterThanOrEqualTo([UIImage imageNamed:@"活动状态标签－底.png"].size.width);
//            make.height.equalTo();
//            make.width.equalTo();
        }];

        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.statusBackImage);
            make.centerX.equalTo(self.statusBackImage).offset(4);
            make.right.lessThanOrEqualTo(self.statusBackImage).offset(-10);
            make.left.greaterThanOrEqualTo(self.statusBackImage).offset(14);
        }];

        [self.doctorAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.footView);
            make.left.equalTo(self.footView).offset(14);
            make.size.mas_equalTo(CGSizeMake(30,30));

        }];

        [self.doctorNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.footView);
            make.left.equalTo(self.doctorAvatar.mas_right).offset(12);


        }];

        [self.doctorDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.footView);
            make.right.equalTo(self.footView).offset(-14);
            make.left.equalTo(self.doctorNameLabel.mas_right).offset(10);


        }];






    }
    return self;
}

-(void)setStatusBackColorIsRed:(BOOL)isRed{
    if(isRed){
        self.statusBackImage.image= [[UIImage imageNamed:@"活动状态标签－底.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(14,36,11,34)];
    }else{
        self.statusBackImage.image= [[UIImage imageNamed:@"活动状态标签－底－灰.zip.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(14,36,11,34)];
    }
};


+(int)cellHeight{
    return (int)(SCREEN_WIDTH*380/750.0)+44;
}
@end