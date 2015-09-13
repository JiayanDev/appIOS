//
// Created by zcw on 15/9/13.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//


#import "NSDate+XLformPushDisplay.h"
#import "NSNumber+MLUtil.h"


@implementation NSNumber (MLUtil)
-(NSString *)stringOfDateSince1970_blankTip:(NSString *)blankTip{
    if(self){
        return [[NSDate dateWithTimeIntervalSince1970:[self unsignedIntegerValue]] displayText];
    }else{
        return blankTip;
    }
}
@end