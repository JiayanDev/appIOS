//
// Created by zcw on 15/9/23.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (jsonUtil)

- (BOOL)isDictJsonStringSimple;

- (id)toJsonObject;

- (id)toJsonObjectWithSimpleReplacingSimleQuoteToDoubleQuote;

- (id)selfOrBlankWithReplacing:(id)replacing;

@end