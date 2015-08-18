//
// Created by zcw on 15/8/18.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "FloatCellOfPhoneAndButton.h"
#import "JVFloatLabeledTextField.h"
#import "UIView+XLFormAdditions.h"

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
        self.postfixButton= [[UIButton alloc] init];
        [self.postfixButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        self.prefixLabel=[[UILabel alloc] init];
        self.prefixLabel.text=@"86";
    }
    return self;
}

-(JVFloatLabeledTextField *)floatLabeledTextField
{
    if (_floatLabeledTextField) return _floatLabeledTextField;

    _floatLabeledTextField = [super floatLabeledTextField];
    _floatLabeledTextField.keyboardType=UIKeyboardTypePhonePad;
    return _floatLabeledTextField;
}


-(void)configure
{
//    [super configure];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.contentView addSubview:self.floatLabeledTextField];
    [self.floatLabeledTextField setDelegate:self];

    [self.prefixLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(kHMargin);
        make.centerY.equalTo(self.contentView);
    }];

    [self.floatLabeledTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.prefixLabel).with.offset(5);
        make.centerY.equalTo(self.contentView);
    }];

    [self.postfixButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.floatLabeledTextField).with.offset(5);
        make.right.equalTo(self.contentView).with.offset(-kHMargin);
        make.centerY.equalTo(self.contentView);
    }];

//    [self.contentView addConstraints:[self layoutConstraints]];
}


//-(NSArray *)layoutConstraints
//{
//    NSMutableArray * result = [[NSMutableArray alloc] init];
//
//    NSDictionary * views = @{@"floatLabeledTextField": self.floatLabeledTextField};
//    NSDictionary *metrics = @{@"hMargin":@(kHMargin),
//            @"vMargin":@(kVMargin)};
//
//    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(hMargin)-[floatLabeledTextField]-(hMargin)-|"
//                                                                        options:0
//                                                                        metrics:metrics
//                                                                          views:views]];
//    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(vMargin)-[floatLabeledTextField]-(vMargin)-|"
//                                                                        options:0
//                                                                        metrics:metrics
//                                                                          views:views]];
//    return result;
//}

@end