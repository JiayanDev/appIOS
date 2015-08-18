//
// Created by zcw on 15/8/18.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "FloatCellOfPhoneAndButton.h"
#import "JVFloatLabeledTextField.h"
#import "UIView+XLFormAdditions.h"
#import <QuartzCore/QuartzCore.h>


NSString * const XLFormRowDescriptorTypeFloatLabeledTextField_phoneAndButton = @"XLFormRowDescriptorTypeFloatLabeledTextField";

@interface FloatCellOfPhoneAndButton()
@property (nonatomic, strong)UIButton *postfixButton;
@property (nonatomic, strong)UILabel *prefixLabel;
@end


const static CGFloat kHMargin = 15.0f;
const static CGFloat kVMargin = 8.0f;
const static CGFloat kFloatingLabelFontSize = 11.0f;


@implementation FloatCellOfPhoneAndButton {

}

@synthesize floatLabeledTextField =_floatLabeledTextField;

- (instancetype)init {
    if(self=[super init]){

    }
    return self;
}

+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[FloatCellOfPhoneAndButton class] forKey:XLFormRowDescriptorTypeFloatLabeledTextField_phoneAndButton];
}

-(JVFloatLabeledTextField *)floatLabeledTextField
{
    if (_floatLabeledTextField) return _floatLabeledTextField;

    _floatLabeledTextField = [super floatLabeledTextField];
    _floatLabeledTextField.keyboardType=UIKeyboardTypePhonePad;
    [self.contentView addSubview:_floatLabeledTextField];
    return _floatLabeledTextField;
}




-(void)configure
{
//    [super configure];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.contentView addSubview:self.floatLabeledTextField];
    [self.floatLabeledTextField setDelegate:self];

    self.postfixButton= [[UIButton alloc] init];
    [self.postfixButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    self.postfixButton.backgroundColor=THEME_COLOR;
    self.postfixButton.titleLabel.font=[UIFont systemFontOfSize:13];
    self.postfixButton.layer.cornerRadius = 4; // this value vary as per your desire
    self.postfixButton.clipsToBounds = YES;


    self.prefixLabel=[[UILabel alloc] init];
    self.prefixLabel.textAlignment=NSTextAlignmentCenter;
    self.prefixLabel.text=@"86";
    [self.contentView addSubview:self.prefixLabel];
    [self.contentView addSubview:self.postfixButton];


    UIView* lineView=[[UIView alloc]init];
    lineView.backgroundColor=[UIColor colorWithHexString:@"ededed"];
    [self.contentView addSubview:lineView];

    [self.prefixLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(@60);
    }];

    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(THE1PX_CONST));
        make.height.mas_equalTo(@30);
        make.left.equalTo(self.prefixLabel.mas_right);
        make.centerY.equalTo(self.contentView);
    }];


    [self.floatLabeledTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.prefixLabel.mas_right).with.offset(16);
        make.centerY.equalTo(self.contentView);
    }];

    [self.postfixButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.floatLabeledTextField.mas_right).with.offset(5);
        make.right.equalTo(self.contentView.mas_right).with.offset(-kHMargin);
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(@90);
    }];

//    [self.contentView addConstraints:[self layoutConstraints]];
}


//-(NSArray *)layoutConstraints
//{
//    return  nil;
//}

@end