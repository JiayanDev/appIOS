//
// Created by zcw on 15/8/28.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "MLXLFormSelectorCell.h"
#import "XLForm.h"

//NSString * const XLFormRowDescriptorTypeSelectorPush = @"XLFormRowDescriptor_MLXLFormSelectorCell";

@implementation MLXLFormSelectorCell {

}
+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[MLXLFormSelectorCell class] forKey:XLFormRowDescriptorTypeSelectorPush];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textLabel.font=[UIFont systemFontOfSize:15];

        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(16);
        }];

        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.imageView.mas_right).offset(16);
            make.left.equalTo(self.contentView).offset(16).priority(500);
        }];
    }

    return self;
}


- (void)configure {
    [super configure];

}

-(void)update{
    [super update];
//    self.accessoryType = self.rowDescriptor.isDisabled ? UITableViewCellAccessoryNone : UITableViewCellAccessoryDisclosureIndicator;;
//    self.editingAccessoryType = self.accessoryType;
//    [self.textLabel setText:self.rowDescriptor.title];
    self.textLabel.font=[UIFont systemFontOfSize:15];
    self.textLabel.textColor=THEME_COLOR_TEXT;


    self.detailTextLabel.font=[UIFont systemFontOfSize:15];
    self.detailTextLabel.textColor=THEME_COLOR_TEXT_LIGHT_GRAY;

//    [self.textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.contentView);
//        make.left.equalTo(self.imageView.mas_right).offset(16);
//        make.left.equalTo(self.contentView).offset(16).priority(500);
//    }];
//    self.selectionStyle = self.rowDescriptor.isDisabled ? UITableViewCellSelectionStyleNone : UITableViewCellSelectionStyleDefault;
//    self.textLabel.text = [NSString stringWithFormat:@"%@%@", self.rowDescriptor.title, self.rowDescriptor.required && self.rowDescriptor.sectionDescriptor.formDescriptor.addAsteriskToRequiredRowsTitle ? @"*" : @""];
//    self.detailTextLabel.text = [self valueDisplayText];
}

+ (CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor {
    return 50;
}
@end