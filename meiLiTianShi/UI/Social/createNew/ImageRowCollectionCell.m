//
// Created by zcw on 15/9/14.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "ImageRowCollectionCell.h"


@implementation ImageRowCollectionCell {

}
//
//- (instancetype)init {
//    self = [super init];
//    if (self) {
//        self.imageViewSmall=[UIImageView new];
//        self.imageViewSmall.contentMode=UIViewContentModeScaleAspectFill;
//        self.removeButton=[UIButton new];
//        [self.removeButton setImage:[UIImage imageNamed:@"男.png"]
//                           forState:UIControlStateNormal];
//
//
//        [self.contentView addSubview:self.imageViewSmall];
//        [self.contentView addSubview:self.removeButton];
//
//        [self.imageViewSmall mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(22,22,0,0));
//
//        }];
//
//        [self.removeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.contentView).offset(3);
//            make.left.equalTo(self.contentView).offset(3);
//        }];
//    }
//
//    return self;
//}
//
//
//- (id)initWithCoder:(NSCoder *)coder {
//    self = [super initWithCoder:coder];
//    if (self) {
//        self.imageViewSmall=[UIImageView new];
//        self.imageViewSmall.contentMode=UIViewContentModeScaleAspectFill;
//        self.removeButton=[UIButton new];
//        [self.removeButton setImage:[UIImage imageNamed:@"男.png"]
//                           forState:UIControlStateNormal];
//
//
//        [self.contentView addSubview:self.imageViewSmall];
//        [self.contentView addSubview:self.removeButton];
//
//        [self.imageViewSmall mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(22,22,0,0));
//
//        }];
//
//        [self.removeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.contentView).offset(3);
//            make.left.equalTo(self.contentView).offset(3);
//        }];
//    }
//
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        self.imageViewSmall=[UIImageView new];
        self.imageViewSmall.contentMode=UIViewContentModeScaleAspectFill;
        self.imageViewSmall.clipsToBounds=YES;
        self.removeButton=[UIButton new];
        [self.removeButton setImage:[UIImage imageNamed:@"取消.png"]
                           forState:UIControlStateNormal];


        [self.contentView addSubview:self.imageViewSmall];
        [self.contentView addSubview:self.removeButton];

        [self.imageViewSmall mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(11,11,0,0));

        }];

        [self.removeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(3);
            make.left.equalTo(self.contentView).offset(3);
            make.size.mas_equalTo([UIImage imageNamed:@"取消.png"].size);
        }];


    }

    return self;
}


@end