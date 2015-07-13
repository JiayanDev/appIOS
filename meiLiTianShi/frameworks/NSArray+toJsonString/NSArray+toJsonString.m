//
// Created by zcw on 15/7/13.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "NSArray+toJsonString.h"


@implementation NSArray (toJsonString)
- (NSString*)toJsonString
{
    NSString* json = nil;

    NSError* error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    return (error ? nil : json);
}
@end