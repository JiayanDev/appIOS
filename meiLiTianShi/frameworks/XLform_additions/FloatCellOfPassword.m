//
// Created by zcw on 15/8/19.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "FloatCellOfPassword.h"
#import "JVFloatLabeledTextField.h"

NSString * const XLFormRowDescriptorTypeFloatLabeledTextField_password = @"XLFormRowDescriptorTypeFloatLabeledTextField_password";


@implementation FloatCellOfPassword {

}
@synthesize floatLabeledTextField =_floatLabeledTextField;

+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[FloatCellOfPassword class] forKey:XLFormRowDescriptorTypeFloatLabeledTextField_password];
}

-(JVFloatLabeledTextField *)floatLabeledTextField
{
    if (_floatLabeledTextField) return _floatLabeledTextField;

    _floatLabeledTextField = [super floatLabeledTextField];
    _floatLabeledTextField.secureTextEntry=YES;
    [self.contentView addSubview:_floatLabeledTextField];
    return _floatLabeledTextField;
}


@end