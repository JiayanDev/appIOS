//
//  TopicListCell.h
//  meiLiTianShi
//
//  Created by zcw on 15/7/6.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableViewCellWhiteAtSelect.h"

@interface TopicListCell : UITableViewCellWhiteAtSelect
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;
@property (weak, nonatomic) IBOutlet UILabel *downLabel;

@end
