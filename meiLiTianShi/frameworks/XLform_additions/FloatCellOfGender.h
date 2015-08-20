//
// Created by zcw on 15/8/19.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FloatLabeledTextFieldCell.h"
#import "MLCheckBox.h"

extern NSString * const XLFormRowDescriptorTypeFloatLabeledTextField_gender;

@interface FloatCellOfGender : FloatLabeledTextFieldCell <UITextFieldDelegate, MLCheckBoxDelegate>
@end

