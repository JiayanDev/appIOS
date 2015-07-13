//
// Created by zcw on 15/7/10.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CategoriesArrayWrap : NSObject
@property (nonatomic, strong)NSMutableOrderedSet *categories;

+ (CategoriesArrayWrap *)wrapWithCates:(NSMutableOrderedSet *)cates;
@end