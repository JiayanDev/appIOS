//
// Created by zcw on 15/8/26.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XLForm/XLFormRowDescriptor.h>

extern NSString * const XLFormRowDescriptorType_infoCellOfKV;


@interface XLFormRowDescriptor(display_data)
@property (nonatomic, strong)NSMutableDictionary *displayData;
@end
@interface InfoCellOfListOfKV : XLFormBaseCell

@end