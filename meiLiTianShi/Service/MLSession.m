//
// Created by zcw on 15/7/2.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "MLSession.h"
#import "MLRequestManager.h"
#import "RespondModel.h"
#import "AFHTTPRequestOperationManager.h"
#import "UICKeyChainStore.h"
#import "PageIndicator.h"
#import "TopicModel.h"
#import "DiaryBookModel.h"
#import "CategoryModel.h"
#import "DiaryModel.h"
#import "HospitalModel.h"
#import "DoctorModel.h"
#import "UploadTokenModel.h"
#import "NSArray+toJsonString.h"

static MLSession *session;
@interface MLSession()
@property (nonatomic, strong) NSString *token;
//@property (nonatomic, strong) dispatch_queue_t uploadQueue;

@end
@implementation MLSession {

}

#define SESSION_OUT_OF_DATE -40
#define keyChainId @"MLLogin"
#define kToken @"token"

#define USE_DEBUG_MOCK 1


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

- (void)sendPost_nonAuth:(NSString*)url
              parameters:(NSDictionary*)parameters
        constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))constructingBodyWithBlock
        successWithoutPreDecode:(void (^)(id responseObject))success failure:(void (^)(NSInteger code, id responseObject))failure {
    NSDate* requestTime = [NSDate new];
    [[MLRequestManager sharedInstance]
            POST_NON_AUTH:url
               parameters:parameters
constructingBodyWithBlock:constructingBodyWithBlock
                  success:^(id responseObject) {
                      success(responseObject);
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
        failure(0, [NSString stringWithFormat:@"EXCEPTION: %@ \n RESPOND:%@",exception,responseObject] );
    }

}

- (void)onFailure:(NSInteger)code responseObject:(id)responseObject failure:(void (^)(NSInteger code, id responseObject))failure {


    if (failure) {
        failure(code, responseObject);
    }
}

-(void)handleCategories:(NSDictionary *)user{
    if(user[@"projectCategory"] &&user[@"projectCategory"][@"data"]){
        self.categories=[NSMutableArray array];
        for (NSString *number in user[@"projectCategory"][@"data"]) {
            [self.categories addObject:[[CategoryModel alloc] initWithId:(NSUInteger) [number integerValue]
                                                                    name:user[@"projectCategory"][@"data"][number]]];
        }
    }
}

-(void)registerSuccess:(void (^)(void))success fail:(void (^)(NSInteger, id))failure{
    [self sendPost:@"user/register"
            param:nil
          success:^(NSDictionary * user){
              self.token=user[@"token"];
              [self handleCategories:user];
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

              [self handleCategories:user];

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


-(void)getTopicListWithPageIndicator:(PageIndicator *)pi success:(void(^)(NSArray *))success  fail:(void (^)(NSInteger, id))failure{
//    #if USE_DEBUG_MOCK
//        NSMutableArray *r=[NSMutableArray array];
//    for (int i = 0; i < 10; ++i) {
//        [r addObject:[TopicModel randomOne]];
//    }
//    success(r);
//    #else
    [self sendGet:@"topic/getTopicList"
            param:[pi toDictionary]
          success:^(id o) {
              NSMutableArray *r=[NSMutableArray array];
              for (NSDictionary *oned in (NSArray *) o) {
                  [r addObject:[[TopicModel alloc] initWithDictionary:oned error:nil]];
              }
              success(r);
          } failure:failure];
//#endif
}

-(void)getDiaryBookListWithPageIndicator:(PageIndicator *)pi success:(void(^)(NSArray *))success  fail:(void (^)(NSInteger, id))failure{

    [self sendGet:@"diary/getHeaderList"
            param:[pi toDictionary]
          success:^(id o) {
              NSMutableArray *r=[NSMutableArray array];
              for (NSDictionary *oned in (NSArray *) o) {
                  [r addObject:[[DiaryBookModel alloc] initWithDictionary:oned error:nil]];
              }
              success(r);
          } failure:failure];

}


-(void)getPostListWithPageIndicator:(PageIndicator *)pi type:(NSString *)diaryOrTopic
                         categoryId:(NSNumber *)cate
                            success:(void(^)(NSArray *))success  fail:(void (^)(NSInteger, id))failure{
    NSMutableDictionary *d=[NSMutableDictionary dictionary];
    [d addEntriesFromDictionary:[pi toDictionary]];
    if(diaryOrTopic){
        d[@"type"]=diaryOrTopic;
    }
    if(cate){
        d[@"categoryId"]=cate;
    }

    [self sendGet:@"post/list"
            param:d
          success:^(id o) {
              NSMutableArray *r=[NSMutableArray array];
              for (NSDictionary *oned in (NSArray *) o) {
                  if([oned[@"type"] isEqualToString:@"diary"]){
                      [r addObject:[[DiaryModel alloc] initWithDictionary:oned error:nil]];
                  }else{
                      [r addObject:[[TopicModel alloc] initWithDictionary:oned error:nil]];
                  }

              }
              success(r);
          } failure:failure];

}



-(void)getMyDiaryBookListWithPageIndicator:(PageIndicator *)pi success:(void(^)(NSArray *))success  fail:(void (^)(NSInteger, id))failure{

    [self sendGet:@"diary/my_header"
            param:[pi toDictionary]
          success:^(id o) {
              NSMutableArray *r=[NSMutableArray array];
              for (NSDictionary *oned in (NSArray *) o) {
                  [r addObject:[[DiaryBookModel alloc] initWithDictionary:oned error:nil]];
              }
              success(r);
          } failure:failure];
}




-(void)getHospitalWithBlurName:(NSString *)blurName pageIndicator:(PageIndicator *)pi success:(void(^)(NSArray *))success  fail:(void (^)(NSInteger, id))failure{
    NSMutableDictionary *d=[NSMutableDictionary dictionary];
    [d addEntriesFromDictionary:[pi toDictionary]];
    if(blurName){
        d[@"blurName"]=blurName;
    }

    [self sendGet:@"hospital/option"
            param:d
          success:^(id o) {
              NSMutableArray *r=[NSMutableArray array];
              for (NSDictionary *oned in (NSArray *) o) {
                  [r addObject:[[HospitalModel alloc] initWithDictionary:oned error:nil]];
              }
              success(r);
          } failure:failure];

}


-(void)getDoctorWithBlurName:(NSString *)blurName pageIndicator:(PageIndicator *)pi success:(void(^)(NSArray *))success  fail:(void (^)(NSInteger, id))failure{
    NSMutableDictionary *d=[NSMutableDictionary dictionary];
    [d setValuesForKeysWithDictionary:[pi toDictionary]];
    if(blurName){
        d[@"blurName"]=blurName;
    }

    [self sendGet:@"doctor/option"
            param:d
          success:^(id o) {
              NSMutableArray *r=[NSMutableArray array];
              for (NSDictionary *oned in (NSArray *) o) {
                  [r addObject:[[DoctorModel alloc] initWithDictionary:oned error:nil]];
              }
              success(r);
          } failure:failure];

}


-(void)getImageUploadPolicyAndSignatureWithMod:(NSString *)mod
                                       Success:(void (^)(UploadTokenModel *))success fail:(void (^)(NSInteger, id))failure{
    [self sendGet:@"uploader/sign"
             param:@{@"mod":mod}
           success:^(NSDictionary * po){

               UploadTokenModel *t= [[UploadTokenModel alloc] initWithDictionary:po
                                                                           error:nil];


               success(t);
           }
           failure:failure];
}


-(void)createDiaryBookWithDiaryBook:(DiaryBookModel *)book diary:(DiaryModel *)diary
                            success:(void (^)(NSUInteger id))success fail:(void (^)(NSInteger, id))failure{
    NSMutableDictionary *d=[NSMutableDictionary dictionary];
    [d setValuesForKeysWithDictionary:[book toDictionaryWithNSArrayToJSONString]];
    d[@"post_content"]=diary.content;
    d[@"post_photoes"]= [diary.photoes toJsonString];
    [d removeObjectForKey:@"id"];
    [self sendPost:@"diary/create" param:d success:^(id o) {
        NSUInteger id= [o[@"id"] unsignedIntValue];
        success(id);
    } failure:failure];
}


- (void)uploadImages:(NSArray *)imageDatas
         uploadToken:(UploadTokenModel *)uploadToken
           allFinish:(void (^)(NSArray *urls, NSArray *fails, NSArray *remainImageDatas))allFinish {
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];

    NSMutableArray *mImages = [imageDatas mutableCopy];
    NSMutableArray *mutableOperations = [NSMutableArray array];
    NSMutableArray *imageUrls = [NSMutableArray array];
    NSMutableArray *fails = [NSMutableArray array];
    for (id image in mImages) {
        NSData *imageData;
        if ([image isKindOfClass:[UIImage class]]) {
            imageData = UIImageJPEGRepresentation((UIImage *) image, 85);

        } else {
            imageData = (NSData *) image;
        }
//        NSURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://example.com/upload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//            [formData appendPartWithFileURL:fileURL name:@"images[]" error:nil];
//        }];


        NSError *serializationError = nil;
        NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer]
                multipartFormRequestWithMethod:@"POST"
                                     URLString:[[NSURL URLWithString:@"http://v0.api.upyun.com/jiayanimg/"] absoluteString]
                                    parameters:@{
                                            @"policy" : uploadToken.policy,
                                            @"signature" : uploadToken.signature
                                    }
                     constructingBodyWithBlock:^(id <AFMultipartFormData> formData) {

                         [formData appendPartWithFileData:imageData name:@"file" fileName:@"file" mimeType:@"image/jpeg"];

                     }
                                         error:&serializationError];


        AFHTTPRequestOperationManager *m=[AFHTTPRequestOperationManager manager];
        m.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];

        AFHTTPRequestOperation *operation = [m
                HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    if ([responseObject[@"code"] integerValue] == 200) {
                        [imageUrls addObject:[NSString stringWithFormat:@"http://jiayanimg.b0.upaiyun.com/%@", responseObject[@"url"]]];
                    }else{
                        NSHTTPURLResponse *response = [operation response];
                        NSString *contentType = [response MIMEType];
                        NSInteger statusCode = [response statusCode];
                        NSLog(@"Error to POST %@ - [%d] %@", [[operation request] URL], statusCode, [operation responseString]);
                        [fails addObject:[NSString stringWithFormat:@"CODE:%d RESPONSE:%@", statusCode, [operation responseString]]];
                    }

                    [mImages removeObject:image];
                }
                                        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSHTTPURLResponse *response = [operation response];
                    NSString *contentType = [response MIMEType];
                    NSInteger statusCode = [response statusCode];

                    if (([contentType compare:@"text/plain"] == NSOrderedSame)
                            || ([contentType compare:@"text/html"] == NSOrderedSame)) {
                        NSLog(@"Error to POST %@ - [%d] %@", [[operation request] URL], statusCode, [operation responseString]);
                        [fails addObject:[NSString stringWithFormat:@"CODE:%d RESPONSE:%@", statusCode, [operation responseString]]];

                    }
                    else if ([contentType compare:@"application/json"] == NSOrderedSame) {
                        NSLog(@"Error to POST %@ - [%d] %@", [[operation request] URL], statusCode, [operation responseObject]);
                        [fails addObject:[NSString stringWithFormat:@"CODE:%d RESPONSE:%@", statusCode, [operation responseObject]]];
                    }
                    else {
                        NSLog(@"Error to POST %@ - [%d]", [[operation request] URL], statusCode);
                        [fails addObject:[NSString stringWithFormat:@"CODE:%d RESPONSE:%@", statusCode, [operation responseString]]];
                    }
                }];


//
//        AFHTTPRequestOperation *operation = [manager POST:@"http://v0.api.upyun.com/jiayanimg/"
//                                               parameters:@{
//                                                       @"policy" : uploadToken.policy,
//                                                       @"signature" : uploadToken.signature
//                                               }
//                                constructingBodyWithBlock:^(id <AFMultipartFormData> formData) {
//                                    [formData appendPartWithFormData:imageData name:@"file"];
//                                }
//                                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                                                      if ([responseObject[@"mImages"] integerValue] == 200) {
//                                                          [imageUrls addObject:[NSString stringWithFormat:@"http://jiayanimg.b0.upaiyun.com/%@", responseObject[@"url"]]];
//                                                      }
//
//                                                      [mImages removeObject:image];
//                                                  }
//                                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                                                      NSHTTPURLResponse *response = [operation response];
//                                                      NSString *contentType = [response MIMEType];
//                                                      NSInteger statusCode = [response statusCode];
//
//                                                      if (([contentType compare:@"text/plain"] == NSOrderedSame)
//                                                              || ([contentType compare:@"text/html"] == NSOrderedSame)) {
//                                                          NSLog(@"Error to POST %@ - [%d] %@", [[operation request] URL], statusCode, [operation responseString]);
//                                                          [fails addObject:[NSString stringWithFormat:@"CODE:%d RESPONSE:%@", statusCode, [operation responseString]]];
//
//                                                      }
//                                                      else if ([contentType compare:@"application/json"] == NSOrderedSame) {
//                                                          NSLog(@"Error to POST %@ - [%d] %@", [[operation request] URL], statusCode, [operation responseObject]);
//                                                          [fails addObject:[NSString stringWithFormat:@"CODE:%d RESPONSE:%@", statusCode, [operation responseObject]]];
//                                                      }
//                                                      else {
//                                                          NSLog(@"Error to POST %@ - [%d]", [[operation request] URL], statusCode);
//                                                          [fails addObject:[NSString stringWithFormat:@"CODE:%d RESPONSE:%@", statusCode, [operation responseString]]];
//                                                      }
//                                                  }];
//
        //AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];

        [mutableOperations addObject:operation];
    }


    NSArray *operations = [AFURLConnectionOperation batchOfRequestOperations:mutableOperations
                                                               progressBlock:^(NSUInteger numberOfFinishedOperations, NSUInteger totalNumberOfOperations) {
                                                                   NSLog(@"%lu of %lu complete", numberOfFinishedOperations, totalNumberOfOperations);
                                                               }
                                                             completionBlock:^(NSArray *operations) {
                                                                 NSLog(@"All operations in batch complete");
                                                                 allFinish(imageUrls,fails,mImages);
                                                             }];
    [[NSOperationQueue mainQueue] addOperations:operations waitUntilFinished:NO];
}


@end