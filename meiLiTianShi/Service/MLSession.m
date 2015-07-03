//
// Created by zcw on 15/7/2.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "MLSession.h"
#import "MLRequestManager.h"
#import "RespondModel.h"
#import "AFHTTPRequestOperationManager.h"
#import "UICKeyChainStore.h"

static MLSession *session;
@interface MLSession()
@property (nonatomic, strong) NSString *token;
@end
@implementation MLSession {

}

#define SESSION_OUT_OF_DATE -40
#define keyChainId @"MLLogin"
#define kToken @"token"


+ (MLSession *)current {
    if(!session){
        session=[[MLSession alloc]init];
    }
    return session;
}

- (void)setToken:(NSString *)token {
    _token=token;
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:keyChainId];
    keychain[kToken]=token;
}



-(void)handleManager:(AFHTTPRequestOperationManager*)manager{
    if(self.token){
        //manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:_token forHTTPHeaderField:@"AUTHORIZATION"];
        //NSLog(@"token: %@",_token);
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
    [self sendPost:@"user/register"
            param:nil
          success:^(NSDictionary * user){
              self.token=user[@"token"];
              success();
          }
          failure:failure];
}

-(void)quickLoginSuccess:(void (^)(void))success fail:(void (^)(NSInteger, id))failure{
    [self sendPost:@"user/quick_login"
            param:@{@"configVersion":@0}
          success:^(NSDictionary * user){
              if(user[@"token"]){
                  self.token=user[@"token"];
              }
              success();
          }
          failure:failure];
}


-(void)restoreLoginOrRegister_Success:(void (^)(void))success fail:(void (^)(NSInteger, id))failure{
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:keyChainId];

    NSString *token=keychain[kToken];
    self.token=token;
    if(token && [token isKindOfClass:[NSString class]] &&token.length>0 ){
        [self quickLoginSuccess:success
                           fail:failure];
    }else{
        [self registerSuccess:success
                         fail:failure];
    }
}


@end