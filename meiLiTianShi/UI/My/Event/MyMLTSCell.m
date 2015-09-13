//
// Created by zcw on 15/9/11.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All self.rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "MyMLTSCell.h"
#import "MASConstraintMaker.h"


@implementation MyMLTSCell {

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {



       self.lefts=[NSMutableArray new];
        self.rights=[NSMutableArray new];


        for (int i = 0; i < 3; ++i) {


//            NSLog(@"%@",dictionary);
            UIImageView *left=[UIImageView new];
//            left.text= [dictionary allKeys][0];
//            left.textColor=THEME_COLOR_TEXT_LIGHT_GRAY;
//            left.font=[UIFont systemFontOfSize:15];

            UILabel *right=[UILabel new];
//            right.text=[dictionary allValues][0];
            right.textColor=THEME_COLOR_TEXT;
            right.font=[UIFont systemFontOfSize:15];
            [self.lefts addObject:left];
            [self.rights addObject:right];
            [self.contentView addSubview:left];
            [self.contentView addSubview:right];
        }



        for (NSUInteger i = 0; i < self.lefts.count; ++i) {
            UILabel *l=self.lefts[i];
            UILabel *r=self.rights[i];
            if(i==0){
                [l mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.contentView).offset(16);
                }];
            }else{
                [l mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(((UILabel *)self.lefts[i-1]).mas_bottom).offset(18);
                }];
            }

            [l mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(16);
                make.size.mas_equalTo(CGSizeMake(16,16));

            }];

            [r mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(l);
                make.left.equalTo(l.mas_right).offset(16);
            }];


            if(i==self.lefts.count-1 &&i>0){
                [l mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(self.contentView).offset(-16);
                }];
            }
        }

    }

    return self;
}

@end