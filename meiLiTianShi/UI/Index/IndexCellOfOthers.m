//
// Created by zcw on 15/9/8.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "IndexCellOfOthers.h"


@implementation IndexCellOfOthers {

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backImage=[UIImageView new];
        self.backImage.clipsToBounds=YES;
        [self.contentView addSubview:self.backImage];
        self.backImage.contentMode=UIViewContentModeScaleAspectFill;
        [self.backImage mas_makeConstraints:^(MASConstraintMaker *make) {

            make.height.equalTo(self.contentView.mas_width).multipliedBy(380.0/750.0);
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}
@end