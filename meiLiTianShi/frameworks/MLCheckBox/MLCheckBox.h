//
// Created by zcw on 15/8/19.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MLCheckBox;

@protocol MLCheckBoxDelegate
-(void)checkbox:(MLCheckBox *)checkBox valueChanged:(BOOL)value;
@end

@interface MLCheckBox : UIButton
@property (nonatomic, strong)MLCheckBox* oppositeCheckbox;
@property (nonatomic, strong)NSObject <MLCheckBoxDelegate>*delegate;
@end