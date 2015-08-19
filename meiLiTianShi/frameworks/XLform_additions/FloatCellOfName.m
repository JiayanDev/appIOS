//
// Created by zcw on 15/8/19.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "FloatCellOfName.h"
#import "JVFloatLabeledTextField.h"

NSString * const XLFormRowDescriptorTypeFloatLabeledTextField_name = @"XLFormRowDescriptorTypeFloatLabeledTextField_name";


@implementation FloatCellOfName {

}
@synthesize floatLabeledTextField =_floatLabeledTextField;

+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[FloatCellOfName class] forKey:XLFormRowDescriptorTypeFloatLabeledTextField_name];
}

-(JVFloatLabeledTextField *)floatLabeledTextField
{
    if (_floatLabeledTextField) return _floatLabeledTextField;

    _floatLabeledTextField = [super floatLabeledTextField];
    _floatLabeledTextField.keyboardType=UIKeyboardTypeDefault;
    [self.contentView addSubview:_floatLabeledTextField];
    return _floatLabeledTextField;
}

@end