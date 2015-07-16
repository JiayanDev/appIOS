//
// Created by zcw on 15/7/16.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
#import <UIKit/UIKit.h>

@class WebviewRequestModel;


@interface WebviewRespondModel : JSONModel
@property (nonatomic, strong) NSNumber *code;
@property (nonatomic, strong) NSDictionary <Optional> *data;
@property (nonatomic, strong) NSString <Optional>*msg;

+ (WebviewRespondModel *)respondWithCode:(NSNumber *)code msg:(NSString *)msg data:(id)data;

- (NSString *)respondToWebview:(UIWebView *)webview withReqeust:(WebviewRequestModel *)requestModel isSuccess:(BOOL)isSucc;
@end