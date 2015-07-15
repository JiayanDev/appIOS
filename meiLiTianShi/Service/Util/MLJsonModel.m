//
// Created by zcw on 15/7/15.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//
#import "NSArray+toJsonString.h"

#import "MLJsonModel.h"


@implementation MLJsonModel {

}

-(NSDictionary *)toDictionaryWithNSArrayToJSONString {
    NSMutableDictionary *d= [[self toDictionary] mutableCopy];
    NSMutableDictionary *r=[d mutableCopy];
    for (NSString *key in d) {
        id value=d[key];
        if([value isKindOfClass:[NSArray class]]){
            r[key]= [((NSArray *)value) toJsonString];
        }
    }

    return r;

}
@end