//
// Created by zcw on 15/9/13.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//


#import "NSDate+XLformPushDisplay.h"
#import "NSNumber+MLUtil.h"


@implementation NSNumber (MLUtil)
-(NSString *)stringOfDateSince1970_blankTip:(NSString *)blankTip{
    if(self && [self unsignedIntegerValue]>0){
        return [[NSDate dateWithTimeIntervalSince1970:[self unsignedIntegerValue]] displayText];
    }else{
        return blankTip;
    }
}


- (NSString *)sizeValueInKbMbGb
{

    double convertedValue = [self doubleValue];
    int multiplyFactor = 0;

    NSArray *tokens = [NSArray arrayWithObjects:@"bytes",@"KB",@"MB",@"GB",@"TB",nil];

    while (convertedValue > 1024) {
        convertedValue /= 1024;
        multiplyFactor++;
    }

    return [NSString stringWithFormat:@"%4.2f %@",convertedValue, [tokens objectAtIndex:multiplyFactor]];
}
@end