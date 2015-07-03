//
// Created by zcw on 15/7/2.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFHTTPRequestOperationManager;


@interface MLSession : NSObject
+ (MLSession *)current;

- (void)handleManager:(AFHTTPRequestOperationManager *)manager;

- (void)registerSuccess:(void (^)(void))success fail:(void (^)(NSInteger, id))failure;

- (void)restoreLoginOrRegister_Success:(void (^)(void))success fail:(void (^)(NSInteger, id))failure;
@end