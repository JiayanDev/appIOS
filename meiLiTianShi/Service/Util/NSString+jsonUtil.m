//
// Created by zcw on 15/9/23.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "NSString+jsonUtil.h"


@implementation NSString (jsonUtil)
-(BOOL)isDictJsonStringSimple{
    return [self hasPrefix:@"{"]&&[self hasSuffix:@"}"];
}

-(id)toJsonObject{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    return json;
}


-(id)toJsonObjectWithSimpleReplacingSimleQuoteToDoubleQuote{
    return [[self stringByReplacingOccurrencesOfString:@"'" withString:@"\""] toJsonObject];
}
@end