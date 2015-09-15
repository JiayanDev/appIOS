//
// Created by zcw on 15/9/14.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLXLformVC.h"

@class EventModel;


@interface EventRatingFVC : MLXLformVC
@property (nonatomic, assign)NSUInteger eventId;
@property(nonatomic, strong) UIButton *submitButton;
@end