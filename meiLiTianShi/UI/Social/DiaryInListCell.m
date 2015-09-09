//
// Created by zcw on 15/9/9.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "DiaryInListCell.h"
#import "UIImageView+MLStyle.h"
#import "UILabel+MLStyle.h"


@implementation DiaryInListCell {

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.images=[NSArray new];
        self.imageViews=[NSMutableArray new];
        self.avatarView=[UIImageView newWithRoundRadius:18];
        self.nameLabel=[UILabel newMLStyleWithSize:12 isGrey:NO];
        self.nameLabel.textColor=THEME_COLOR;

        self.catogoriesLabel=[UILabel newMLStyleWithSize:13 isGrey:YES];
        self.contentLabel=[UILabel newMLStyleWithSize:13 isGrey:NO];
        self.contentLabel.numberOfLines=2;

        self.dateLabel=[UILabel newMLStyleWithSize:10 isGrey:YES];
        self.pinglunAndZanLabel=[UILabel newMLStyleWithSize:10 isGrey:YES];

        [self.contentView addSubview:self.avatarView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.catogoriesLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.pinglunAndZanLabel];



        [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(8);
            make.top.equalTo(self.contentView).offset(15);
            make.size.mas_equalTo(CGSizeMake(35,35));

        }];

        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.avatarView);
            make.left.equalTo(self.avatarView.mas_right).offset(9);


        }];

        [self.catogoriesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.avatarView.mas_right).offset(9);
            make.top.equalTo(self.avatarView.mas_bottom).offset(7);

        }];

        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.avatarView.mas_right).offset(9);
            make.top.equalTo(self.catogoriesLabel.mas_bottom).offset(20);
            make.right.equalTo(self.contentView).offset(-15);
        }];

        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.avatarView);
            make.right.equalTo(self.contentView).offset(-15);
        }];

        [self.pinglunAndZanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15);
            make.bottom.equalTo(self.contentView).offset(-17);
            make.top.equalTo(self.contentLabel.mas_bottom).offset(17).priority(500);
        }];


    }

    return self;
}

- (void)setImages:(NSArray *)images {
    [self.imageViews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    self.imageViews=[NSMutableArray new];
    CGFloat w= (CGFloat) ((SCREEN_WIDTH-8-9-35-15+5)/3.0);
//    _images=images;
    if(images && [images isKindOfClass:[NSArray class]]){
    for (NSString *string in images) {
        NSURL *url=[NSURL URLWithString:string];
        UIImageView *v=[UIImageView new];
        [v sd_setImageWithURL:url];
        [self.contentView addSubview:v];
        [self.imageViews addObject:v];
        NSUInteger index= [images indexOfObject:string];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(w,w));
            if(index==0){
                make.top.equalTo(self.contentLabel.mas_bottom).offset(12);
                make.left.equalTo(self.avatarView.mas_right).offset(9);

            }else if(index%3==0){
                make.top.equalTo(((UIImageView *)self.imageViews[index-3]).mas_bottom).offset(5);
                make.left.equalTo(self.avatarView.mas_right).offset(9);
            }else{
                make.top.equalTo(((UIImageView *)self.imageViews[index-1]));
                make.left.equalTo(((UIImageView *)self.imageViews[index-1]).mas_right).offset(5);
            }


            if(index== [images count]-1){
                make.bottom.equalTo(self.pinglunAndZanLabel.mas_top).offset(-17).priority(600);
            }
        }];
    }
    }





}

@end