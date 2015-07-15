//
// Created by zcw on 15/7/7.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "DiaryBookModel.h"
#import "CategoriesArrayWrap.h"
#import "CategoryModel.h"


@implementation DiaryBookModel {

}
+ (id)randomOne {
    return nil;
}

- (void)setOperationTimeNSDate:(NSDate <Ignore> *)operationTimeNSDate {
    _operationTimeNSDate=operationTimeNSDate;
    self.operationTime= @([operationTimeNSDate timeIntervalSince1970]);
}

- (void)setCategories:(CategoriesArrayWrap <Ignore> *)categories {
    _categories=categories;
    NSMutableArray *r=[NSMutableArray array];
    for (CategoryModel *category in categories.categories) {
        [r addObject:@(category.id)];

    }

    self.categoryIds=r;
}
@end