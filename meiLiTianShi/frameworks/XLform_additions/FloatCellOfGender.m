//
// Created by zcw on 15/8/19.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "FloatCellOfGender.h"
#import "JVFloatLabeledTextField.h"

NSString * const XLFormRowDescriptorTypeFloatLabeledTextField_gender = @"XLFormRowDescriptorTypeFloatLabeledTextField_gender";


@implementation FloatCellOfGender {

}
@synthesize floatLabeledTextField =_floatLabeledTextField;

+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[FloatCellOfGender class] forKey:XLFormRowDescriptorTypeFloatLabeledTextField_gender];
}

-(JVFloatLabeledTextField *)floatLabeledTextField
{
    if (_floatLabeledTextField) return _floatLabeledTextField;

    _floatLabeledTextField = [super floatLabeledTextField];
    _floatLabeledTextField.keyboardType=UIKeyboardTypeNumberPad;
    [self.contentView addSubview:_floatLabeledTextField];
    return _floatLabeledTextField;
}

