//
// Created by zcw on 15/7/23.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "UserDetailModel.h"


@implementation UserDetailModel {

}

-(NSString *)descOfGenderAreaAge{
    NSMutableString *s=[NSMutableString new];
    if(self.gender){
        [s appendString:self.gender.integerValue==1?@"男":@"女"];
        [s appendString:@" "];

    }

    if(self.province){
        [s appendString:self.province];
    }
    if(self.city){
        [s appendString:self.city];
    }

    if(self.birthday){
        NSDate * b= [[NSDate alloc] initWithTimeIntervalSince1970:self.birthday.unsignedIntegerValue];
        NSDate *today = [NSDate date];

        NSDateComponents *ageComponents = [[NSCalendar currentCalendar]
                components:NSYearCalendarUnit
                  fromDate:b
                    toDate:today
                   options:0];

        [s appendString:[NSString stringWithFormat:@"%@岁",@(ageComponents.year)]];
    }

};
@end