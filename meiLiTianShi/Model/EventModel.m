//
// Created by zcw on 15/7/19.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "EventModel.h"
#import "MLRandom.h"


@implementation EventModel {

}


+(EventModel *)randomOne{

    EventModel *e= [[EventModel alloc] init];
    e.id=arc4random_uniform(50000);
    e.userName=[MLRandom randomChineseStringLengthFrom:3 to:5];
    e.hospitalName=[MLRandom randomChineseStringLengthFrom:5 to:7];
    e.doctorName=[MLRandom randomChineseStringLengthFrom:2 to:3 ];
    e.beginTime=@([[NSDate new] timeIntervalSince1970]);
    e.applyStatus=@"已报名";
    return e;

};
@end