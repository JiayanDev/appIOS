//
// Created by zcw on 15/7/6.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "PageIndicator.h"


@implementation PageIndicator {

}

+(PageIndicator *)initWithSinceId:(NSNumber *)sinceId maxId:(NSNumber *)maxId{
    return [[self alloc] initWithDictionary:@{@"sinceId":sinceId,@"maxId":maxId}
                                      error:nil];
}
@end