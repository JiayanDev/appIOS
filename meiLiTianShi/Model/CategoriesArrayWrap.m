//
// Created by zcw on 15/7/10.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "CategoriesArrayWrap.h"


@implementation CategoriesArrayWrap {

}

-(NSString *)displayText
{
    if(!self.categories || self.categories.count==0){
        return @"未选择";
    }
    return [[self.categories allObjects] componentsJoinedByString:@"，"];
}

-(id)valueData
{
    return self;
}

+(CategoriesArrayWrap *)wrapWithCates:(NSMutableSet *)cates{
    CategoriesArrayWrap *c=[[CategoriesArrayWrap alloc]init];
    c.categories= [cates mutableCopy];
    return c;
}


@end