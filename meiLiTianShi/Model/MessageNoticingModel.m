//
// Created by zcw on 15/9/16.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "MessageNoticingModel.h"
#import "NSString+jsonUtil.h"


@implementation MessageNoticingModel {

}

-(NSDictionary *)toJumpableDict{
    id data;
    if([self.data isDictJsonStringSimple]){
        data= [self.data toJsonObjectWithSimpleReplacingSimleQuoteToDoubleQuote];
    }else{
        data =self.data;
    }

    return @{
            @"action":self.action,
            @"data":data,
    };
};
@end