//
// Created by zcw on 15/8/19.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "FloatCellOfGender.h"
#import "JVFloatLabeledTextField.h"
#import "MLCheckBox.h"
#import "MASConstraintMaker.h"

NSString * const XLFormRowDescriptorTypeFloatLabeledTextField_gender = @"XLFormRowDescriptorTypeFloatLabeledTextField_gender";

@interface FloatCellOfGender()
@property (nonatomic, strong)MLCheckBox *nan;
@property (nonatomic, strong)MLCheckBox *nv;
@property (nonatomic, strong)UILabel *label;
@end


@implementation FloatCellOfGender {

}
@synthesize floatLabeledTextField =_floatLabeledTextField;

+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[FloatCellOfGender class] forKey:XLFormRowDescriptorTypeFloatLabeledTextField_gender];
}

-(JVFloatLabeledTextField *)floatLabeledTextField
{
    return nil;
}


-(void)configure
{
//    [super configure];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
//    [self.contentView addSubview:self.floatLabeledTextField];
//    [self.floatLabeledTextField setDelegate:self];

    self.label=[[UILabel alloc]init];
    self.label.text=self.rowDescriptor.title;
    self.label.textColor=THEME_COLOR_TEXT_LIGHT_GRAY;
    [self.contentView addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(15);
        make.centerY.equalTo(self.contentView);
    }];

    self.nan= [[MLCheckBox alloc] init];
    self.nv= [[MLCheckBox alloc] init];
    self.rowDescriptor.value=@1;

    self.nan.delegate=self;
    self.nv.delegate=self;
    [self.nv setSelected:YES];
    self.nv.oppositeCheckbox=self.nan;
    self.nan.oppositeCheckbox=self.nv;


    [self.contentView addSubview:self.nv];
    [self.contentView addSubview:self.nan];

    [self.nv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label.mas_left).with.offset(15);
        make.centerY.equalTo(self.contentView);

    }];

    [self.nan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nv.mas_left).with.offset(15);
        make.centerY.equalTo(self.contentView);

    }];

//
//    self.postfixButton= [[UIButton alloc] init];
//    [self.postfixButton setTitle:@"发送验证码" forState:UIControlStateNormal];
//    [self.postfixButton setTitle:@"已发送"
//                        forState:UIControlStateDisabled];
//    self.postfixButton.backgroundColor=THEME_COLOR;
//    self.postfixButton.titleLabel.font=[UIFont systemFontOfSize:13];
//    self.postfixButton.layer.cornerRadius = 4; // this value vary as per your desire
//    self.postfixButton.clipsToBounds = YES;
//
//    [self.postfixButton setBackgroundImage:[UIImage imageWithColor:THEME_COLOR_HIGHLIGHT_BUTTON] forState:UIControlStateHighlighted];
//    [self.postfixButton setBackgroundImage:[UIImage imageWithColor:THEME_COLOR_DISABLED_BUTTON] forState:UIControlStateDisabled];
//
//    [self.postfixButton addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
//
//
//    self.prefixLabel=[[UILabel alloc] init];
//    self.prefixLabel.textAlignment=NSTextAlignmentCenter;
//    self.prefixLabel.text=@"86";
//    [self.contentView addSubview:self.prefixLabel];
//    [self.contentView addSubview:self.postfixButton];
//
//
//    UIView* lineView=[[UIView alloc]init];
//    lineView.backgroundColor=[UIColor colorWithHexString:@"ededed"];
//    [self.contentView addSubview:lineView];
//
//    [self.prefixLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView.mas_left).with.offset(0);
//        make.centerY.equalTo(self.contentView);
//        make.width.mas_equalTo(@60);
//    }];
//
//    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(@(THE1PX_CONST));
//        make.height.mas_equalTo(@30);
//        make.left.equalTo(self.prefixLabel.mas_right);
//        make.centerY.equalTo(self.contentView);
//    }];
//
//
//    [self.floatLabeledTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.prefixLabel.mas_right).with.offset(16);
//        make.centerY.equalTo(self.contentView);
//    }];
//
//    [self.postfixButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.floatLabeledTextField.mas_right).with.offset(5);
//        make.right.equalTo(self.contentView.mas_right).with.offset(-kHMargin);
//        make.centerY.equalTo(self.contentView);
//        make.width.mas_equalTo(@90);
//        make.height.mas_equalTo(@30);
//    }];
//
//    [self.contentView addConstraints:[self layoutConstraints]];
}


- (void)checkbox:(MLCheckBox *)checkBox valueChanged:(BOOL)value {

    if(self.nan.selected){
        self.rowDescriptor.value=@0;
    }else{
        self.rowDescriptor.value=@1;
    }

}
@end
