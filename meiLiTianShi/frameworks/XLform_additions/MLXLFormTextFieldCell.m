//
// Created by zcw on 15/8/31.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "MLXLFormTextFieldCell.h"
#import "XLForm.h"


@implementation MLXLFormTextFieldCell {

}

+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[MLXLFormTextFieldCell class] forKey:XLFormRowDescriptorTypeText];
}

- (void)configure {
    [super configure];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView);
    }];
}


- (void)update {
    [super update];
    self.textField.font = [UIFont systemFontOfSize:15];
    self.textField.textColor=THEME_COLOR_TEXT;
}


+ (CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor {
    return 50;
}


@end