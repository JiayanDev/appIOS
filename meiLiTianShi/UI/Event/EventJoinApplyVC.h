//
//  EventJoinApplyVC.h
//  meiLiTianShi
//
//  Created by zcw on 15/8/6.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CTCheckbox;

@interface EventJoinApplyVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *huoDongXiangQing;
@property (weak, nonatomic) IBOutlet UITextView *baoMingXinXi;
@property (weak, nonatomic) IBOutlet CTCheckbox *isAgree;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end
