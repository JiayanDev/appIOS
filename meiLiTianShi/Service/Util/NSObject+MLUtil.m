//
// Created by zcw on 15/9/13.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "NSObject+MLUtil.h"


@implementation NSObject (MLUtil)
-(id)selfOrNilNullWithReplacing:(id)replacing{
    if(self && self!=[NSNull null]){
        if([self isKindOfClass:[NSString class]] && ((NSString *)self).length==0){
            return replacing;
        }
        return self;
    }else{
        return replacing;
    }
}
@end