//
// Created by zcw on 15/8/18.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "FloatCellOfNumber.h"
#import "JVFloatLabeledTextField.h"

NSString * const XLFormRowDescriptorTypeFloatLabeledTextField_number = @"XLFormRowDescriptorTypeFloatLabeledTextField_number";


@implementation FloatCellOfNumber {

}
@synthesize floatLabeledTextField =_floatLabeledTextField;

+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[FloatCellOfNumber class] forKey:XLFormRowDescriptorTypeFloatLabeledTextField_number];
}

-(JVFloatLabeledTextField *)floatLabeledTextField
{
    if (_floatLabeledTextField) return _floatLabeledTextField;

    _floatLabeledTextField = [super floatLabeledTextField];
    _floatLabeledTextField.keyboardType=UIKeyboardTypeNumberPad;
    [self.contentView addSubview:_floatLabeledTextField];
    return _floatLabeledTextField;
}


@end