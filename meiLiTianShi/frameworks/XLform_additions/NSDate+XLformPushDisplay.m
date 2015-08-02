//
// Created by zcw on 15/8/2.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "NSDate+XLformPushDisplay.h"


@implementation NSDate (XLformPushDisplay)
-(NSString *)displayText{
//    NSDate* now = [NSDate date];
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
//    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
     fmt.dateFormat = @"yyyy-MM-dd";
     NSString* dateString = [fmt stringFromDate:self];
//     NSLog(@"%@", dateString);
    return dateString;
};
-(id)valueData{
    return self;
};
@end