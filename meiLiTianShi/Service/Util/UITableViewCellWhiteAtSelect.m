//
// Created by zcw on 15/9/23.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "UITableViewCellWhiteAtSelect.h"


@implementation UITableViewCellWhiteAtSelect {

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    UIView * selectedBackgroundView = [[UIView alloc] init];
    [selectedBackgroundView setBackgroundColor:[UIColor colorWithHexString:@"ffffff"]]; // set color here
    [self setSelectedBackgroundView:selectedBackgroundView];
}
@end