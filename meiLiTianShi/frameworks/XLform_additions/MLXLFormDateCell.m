//
// Created by zcw on 15/9/1.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "MLXLFormDateCell.h"
#import "XLForm.h"
#import "MASConstraintMaker.h"


@implementation MLXLFormDateCell {

}


+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[MLXLFormDateCell class] forKey:XLFormRowDescriptorTypeDate];
}

- (void)configure {
    [super configure];
    [self.detailTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView);
    }];

    self.tintColor=THEME_COLOR;
    self.detailTextLabel.font=[UIFont systemFontOfSize:15];
}

//
//- (void)update {
//    [super update];
//    self.textField.font = [UIFont systemFontOfSize:15];
//    self.textField.textColor=THEME_COLOR_TEXT;
//}


+ (CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor {
    return 50;
}

@end