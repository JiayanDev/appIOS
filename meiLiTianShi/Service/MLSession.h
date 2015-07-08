//
// Created by zcw on 15/7/2.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFHTTPRequestOperationManager;
@class PageIndicator;


@interface MLSession : NSObject
+ (MLSession *)current;

- (void)handleManager:(AFHTTPRequestOperationManager *)manager;

- (void)registerSuccess:(void (^)(void))success fail:(void (^)(NSInteger, id))failure;

- (void)restoreLoginOrRegister_Success:(void (^)(void))success fail:(void (^)(NSInteger, id))failure;

- (void)getTopicListWithPageIndicator:(PageIndicator *)pi success:(void (^)(NSArray *))success fail:(void (^)(NSInteger, id))failure;

- (void)getDiaryBookListWithPageIndicator:(PageIndicator *)pi success:(void (^)(NSArray *))success fail:(void (^)(NSInteger, id))failure;
@end