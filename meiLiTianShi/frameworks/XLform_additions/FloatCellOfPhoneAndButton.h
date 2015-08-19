//
// Created by zcw on 15/8/18.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FloatLabeledTextFieldCell.h"

extern NSString * const XLFormRowDescriptorTypeFloatLabeledTextField_phoneAndButton;
@protocol FloatCellOfPhoneAndButton_buttonDelegate
-(void)postfixButtonPressed:(UIButton *)button rowDescrptor:(XLFormRowDescriptor *)rowDescriptor;
@end

@interface FloatCellOfPhoneAndButton : FloatLabeledTextFieldCell <UITextFieldDelegate>
@property (nonatomic, strong)UIButton *postfixButton;
@property (nonatomic, strong)UILabel *prefixLabel;
@end