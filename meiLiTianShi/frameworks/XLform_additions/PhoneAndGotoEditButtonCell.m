//
// Created by zcw on 15/8/27.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "PhoneAndGotoEditButtonCell.h"
#import "MASConstraintMaker.h"
#import "UILabel+MLStyle.h"
#import "PhoneBindFVC.h"

NSString * const XLFormRowDescriptorType_PhoneAndGotoEditButtonCell = @"XLFormRowDescriptorType_PhoneAndGotoEditButtonCell";

@interface PhoneAndGotoEditButtonCell()
@property (nonatomic, strong)UILabel *phoneLabel;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong) UIButton *gotoEditLabel;
@end
@implementation PhoneAndGotoEditButtonCell {

}


+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[PhoneAndGotoEditButtonCell class] forKey:XLFormRowDescriptorType_PhoneAndGotoEditButtonCell];
}


- (void)configure {

    self.phoneLabel=[UILabel newMLStyleWithSize:15 isGrey:NO];
    self.titleLabel=[UILabel newMLStyleWithSize:15 isGrey:YES];
    self.gotoEditLabel= [UIButton buttonWithType:UIButtonTypeCustom];

    [self.contentView addSubview:self.phoneLabel];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.gotoEditLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.centerY.equalTo(self.contentView);
    }];

    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(16);
        make.centerY.equalTo(self.contentView);

    }];

    [self.gotoEditLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-9);
        make.centerY.equalTo(self.contentView);

    }];



    [self.gotoEditLabel setTitle:@"更换" forState:UIControlStateNormal];
    [self.gotoEditLabel setTitleColor:THEME_COLOR forState:UIControlStateNormal];
    self.gotoEditLabel.titleLabel.font=[UIFont systemFontOfSize:15];
    self.titleLabel.text=@"手机";

    [self.gotoEditLabel addTarget:self
                           action:@selector(changePhone)
                 forControlEvents:UIControlEventTouchUpInside];

    self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

}


-(void)changePhone{
    PhoneBindFVC *vc=[PhoneBindFVC new];
    vc.type=PhoneBindVcType_changePhone;
    [self.formViewController presentViewController:[[UINavigationController alloc] initWithRootViewController:vc]
                                          animated:YES
                                        completion:nil];
}


- (void)update {

    self.phoneLabel.text=self.rowDescriptor.value;

}

+ (CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor {
    return 50;
}


@end