//
// Created by zcw on 15/9/14.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

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
        

    }

    return self;
}

@end