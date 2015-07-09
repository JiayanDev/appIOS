//
// Created by zcw on 15/7/9.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CategoryModel : NSObject
@property (nonatomic, assign)NSUInteger id;
@property (nonatomic, strong)NSString *name;

- (id)initWithId:(NSUInteger)id1 name:(NSString *)name;

- (BOOL)isLevel1;

- (NSArray *)chidren;
@end