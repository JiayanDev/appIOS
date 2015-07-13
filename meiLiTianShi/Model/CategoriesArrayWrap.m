//
// Created by zcw on 15/7/10.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "CategoriesArrayWrap.h"
#import "JSONValueTransformer.h"


@implementation CategoriesArrayWrap {

}

-(NSString *)displayText
{
    if(!self.categories || self.categories.count==0){
        return @"未选择";
    }
    return [[self.categories array] componentsJoinedByString:@"，"];
}

-(id)valueData
{
    return self;
}

+(CategoriesArrayWrap *)wrapWithCates:(NSMutableOrderedSet *)cates{
    CategoriesArrayWrap *c=[[CategoriesArrayWrap alloc]init];
    c.categories= [cates mutableCopy];
    return c;
}

//@implementation JSONValueTransformer(CategoriesArrayWrap  )
//
//-(CategoriesArrayWrap*)CategoriesArrayWrapFromNSArray:(NSString*)string{
//    CategoriesArrayWrap* w=[[CategoriesArrayWrap alloc]init];
//    w.categories=
//}
//-(id)JSONObjectFromCategoriesArrayWrap:(CategoriesArrayWrap*)siteset{
//    return [siteset name];
//}


@end