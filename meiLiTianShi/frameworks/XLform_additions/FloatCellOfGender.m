//
// Created by zcw on 15/8/19.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "FloatCellOfGender.h"
#import "JVFloatLabeledTextField.h"
#import "MLCheckBox.h"
#import "MASConstraintMaker.h"

NSString * const XLFormRowDescriptorTypeFloatLabeledTextField_gender = @"XLFormRowDescriptorTypeFloatLabeledTextField_gender";

@interface FloatCellOfGender()
@property (nonatomic, strong)MLCheckBox *nan;
@property (nonatomic, strong)MLCheckBox *nv;
@property (nonatomic, strong)UILabel *label;
@end


@implementation FloatCellOfGender {

}
@synthesize floatLabeledTextField =_floatLabeledTextField;

+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[FloatCellOfGender class] forKey:XLFormRowDescriptorTypeFloatLabeledTextField_gender];
}

-(JVFloatLabeledTextField *)floatLabeledTextField
{
    return nil;
}


-(void)configure
{
//    [super configure];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
//    [self.contentView addSubview:self.floatLabeledTextField];
//    [self.floatLabeledTextField setDelegate:self];

    self.label=[[UILabel alloc]init];
    self.label.text=@"性别";
    self.label.font=[UIFont systemFontOfSize:16];
    self.label.textColor=THEME_COLOR_TEXT_LIGHT_GRAY;
    [self.contentView addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(15);
        make.centerY.equalTo(self.contentView);
    }];

    self.nan= [[MLCheckBox alloc] init];
    [self.nan setTitle:@"男" forState:UIControlStateNormal];
    self.nv= [[MLCheckBox alloc] init];
    [self.nv setTitle:@"女" forState:UIControlStateNormal];
    self.rowDescriptor.value=@1;

    self.nan.delegate=self;
    self.nv.delegate=self;
    [self.nv setSelected:YES];
    self.nv.oppositeCheckbox=self.nan;
    self.nan.oppositeCheckbox=self.nv;


    [self.contentView addSubview:self.nv];
    [self.contentView addSubview:self.nan];

    [self.nv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label.mas_right).with.offset(15);
        make.centerY.equalTo(self.contentView);
        make.width.mas_greaterThanOrEqualTo(@50);

    }];

    [self.nan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nv.mas_right).with.offset(15);
        make.centerY.equalTo(self.contentView);
        make.width.mas_greaterThanOrEqualTo(@50);

    }];

}


- (void)checkbox:(MLCheckBox *)checkBox valueChanged:(BOOL)value {

    if(self.nan.selected){
        self.rowDescriptor.value=@0;
    }else{
        self.rowDescriptor.value=@1;
    }

}
@end
