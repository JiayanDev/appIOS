//
// Created by zcw on 15/7/2.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "MLSession.h"
#import "MLRequestManager.h"
#import "RespondModel.h"#import "AFHTTPRequestOperationManager.h"

static MLSession *session;
@interface MLSession()
@property NSString *token;
@end
@implementation MLSession {

}

#define SESSION_OUT_OF_DATE -40
#define keyChainId @"MLLogin"


+ (MLSession *)current {
    if(!session){
        session=[[MLSession alloc]init];
    }
    return session;
}

-(void)handleManager:(AFHTTPRequestOperationManager*)manager{
    if(self.token){
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:_token forHTTPHeaderField:@"auth"];
    }
}


-(NSDictionary *)handleParam:(NSDictionary *)param{
    NSMutableDictionary *p=[NSMutableDictionary dictionaryWithDictionary:param];


    return p;

}

-(void)sendGet:(NSString *)url param:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(NSInteger, id))failure {
    NSDate* requestTime = [NSDate new];
    [[MLRequestManager sharedInstance] GET:url
                                 parameters:[self handleParam:param]
                                    success:^(id responseObject) {
                                        [self onSuccess:requestTime
                                         responseObject:responseObject
                                                success:success
                                                failure:failure];
                                    }

                                    failure:^(NSInteger code, id responseObject) {
                                        [self onFailure:code responseObject:responseObject failure:failure];

                                    }];
}


- (void)sendPost:(NSString *)url param:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(NSInteger, id))failure {
    NSDate *requestTime = [NSDate new];
    [[MLRequestManager sharedInstance] POST:url
                                 parameters:[self handleParam:param]
                                    success:^(id responseObject) {
                                        [self onSuccess:requestTime
                                         responseObject:responseObject
                                                success:success
                                                failure:failure];
                                    }

                                    failure:^(NSInteger code, id responseObject) {
                                        [self onFailure:code responseObject:responseObject failure:failure];

                                    }];
}


- (void)onSuccess:(NSDate *)requestTime responseObject:(id)responseObject success:(void (^)(id responseObject))success failure:(void (^)(NSInteger, id))failure {
    @try {
        NSError *error = nil;
        RespondModel *failData = [[RespondModel alloc] initWithDictionary:responseObject
                                                                    error:&error];
        if (failData.code != 0) {
            failure(failData.code, failData.msg);
        } else {
            if (success) {
                success(failData.data);
            }
        }
    }
    @catch (NSException *exception) {
        failure(0, responseObject);
    }

}

- (void)onFailure:(NSInteger)code responseObject:(id)responseObject failure:(void (^)(NSInteger code, id responseObject))failure {


    if (failure) {
        failure(code, responseObject);
    }
}

-(void)registerSuccess:(void (^)(void))success fail:(void (^)(NSInteger, id))failure{
    [self sendGet:@"user/register"
            param:nil
          success:^(NSDictionary * user){
              self.token=user[@"token"];
              success();
          }
          failure:failure];
}

@end