//
// Created by zcw on 15/7/6.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "MLRandom.h"


@implementation MLRandom {

}

static NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
static NSString * chineses=@"萧条冷落的庭院，吹来了斜风细雨，一层层的院门紧紧关闭。春天的娇花开即将放，嫩柳也渐渐染绿。寒食节即将临近，又到了令人烦恼的时日，推敲险仄的韵律写成诗篇，从沉醉的酒意中清醒，还是闲散无聊的情绪，别有一番闲愁在心头。远飞的大雁尽行飞过，可心中的千言万语却难以托寄。连日来楼上春寒泠冽，帘幕垂得低低。玉栏杆我也懒得凭倚。锦被清冷，香火已消，我从短梦中醒来。这情景，使本来已经愁绪万千的我不能安卧。清晨的新露涓涓，新发出的桐叶一片湛绿，不知增添了多少游春的意绪。太阳已高，晨烟初放，再看看今天是不是又一个放晴的好天气。";


+(NSString*)randomChineseStringLengthFrom:(int)min to:(int)max{
    int len=arc4random_uniform(max-min)+min;
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];

    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [chineses characterAtIndex: arc4random_uniform([chineses length])]];
    }

    return randomString;
}

@end