//
//  DiaryListCell.h
//  meiLiTianShi
//
//  Created by zcw on 15/7/19.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiaryListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userDescLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *splitLineHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *diaryContentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *diaryImage1;
@property (weak, nonatomic) IBOutlet UIImageView *diaryImage2;
@property (weak, nonatomic) IBOutlet UIImageView *diaryImage3;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *noImageConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pic1up;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pic2up;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pic3up;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pic1down;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pic2down;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pic3down;

@end
