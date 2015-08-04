//
//  MyBanMeiCell.h
//  meiLiTianShi
//
//  Created by zcw on 15/8/4.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyBanMeiCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *doctorAndHospital;
@property (weak, nonatomic) IBOutlet UILabel *timePoint;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UIButton *goReview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *noButtonConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hasButtonConstraint;

@end
