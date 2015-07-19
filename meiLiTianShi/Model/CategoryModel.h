//
// Created by zcw on 15/7/9.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@protocol CategoryModel
@end


@interface CategoryModel : JSONModel
@property (nonatomic, assign)NSUInteger id;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSArray <Optional, CategoryModel>*sub;

- (id)initWithId:(NSUInteger)id1 name:(NSString *)name;

//- (BOOL)isLevel1;

+ (NSString *)stringWithId:(NSUInteger)id1;

- (NSString *)stringWithId:(NSUInteger)id1;
@end