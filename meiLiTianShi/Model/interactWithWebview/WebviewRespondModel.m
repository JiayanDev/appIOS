//
// Created by zcw on 15/7/16.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "WebviewRespondModel.h"
#import "WebviewRequestModel.h"



@implementation WebviewRespondModel {

}

+(WebviewRespondModel *)respondWithCode:(NSNumber *)code
                                    msg:(NSString *)msg
                                   data:(id)data{
    WebviewRespondModel *r= [[WebviewRespondModel alloc] init];
    r.code=code;
    r.msg=msg;
    r.data=data;
    return r;
}

-(NSString *)respondToWebview:(UIWebView *)webview withReqeust:(WebviewRequestModel *)requestModel isSuccess:(BOOL)isSucc
{
    NSMutableDictionary *d= [[self toDictionary] mutableCopy];
    NSString *calling=[NSString stringWithFormat:@"%@(%@);",isSucc?requestModel.success:requestModel.error, [self toJSONString]];
    return [webview stringByEvaluatingJavaScriptFromString:calling];
}
@end