//
// Created by zcw on 15/7/15.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>


@interface MLJsonModel : JSONModel
- (NSDictionary *)toDictionaryWithNSArrayToJSONString;
@end