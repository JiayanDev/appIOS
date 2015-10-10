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
#import "WXApiObject.h"
#import "UploadTokenModel.h"
#import "UserModel.h"
#import "NSArray+toJsonString.h"
#import "UserModel.h"
#import "EventModel.h"
#import "UserDetailModel.h"
#import "NSString+MD5.h"
#import "LoginWaySelectVC.h"
#import "MessageNoticingModel.h"
#import "UIImage+Resizing.h"

static MLSession *session;
@interface MLSession()

//@property (nonatomic, strong) dispatch_queue_t uploadQueue;

@end
@implementation MLSession {

}

#define SESSION_OUT_OF_DATE -40
#define keyChainId @"MLLogin"
#define kToken @"token"
#define kIsLogined @"islogined"
#define kCategories @"categories"

#define USE_DEBUG_MOCK 0
#define USE_TRY_FOR_SUCCESS 0


+ (MLSession *)current {
    if(!session){
        session=[[MLSession alloc]init];
        session.isLogined= [[NSUserDefaults standardUserDefaults] boolForKey:kIsLogined];
        session.categories= [[NSUserDefaults standardUserDefaults] objectForKey:kCategories];
    }
    return session;
}

- (void)setToken:(NSString *)token {
    _token=token;
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:keyChainId];
    keychain[kToken]=token;
}

-(void)setIsLogined:(BOOL)isLogined {
    _isLogined=isLogined;
    [[NSUserDefaults standardUserDefaults] setBool:isLogined forKey:kIsLogined];

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
    #if USE_TRY_FOR_SUCCESS
    @try {
        #endif
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
#if USE_TRY_FOR_SUCCESS
    }
    @catch (NSException *exception) {
        failure(0, [NSString stringWithFormat:@"EXCEPTION: %@ \n RESPOND:%@",exception,responseObject] );
    }
    #endif

}

- (void)onFailure:(NSInteger)code responseObject:(id)responseObject failure:(void (^)(NSInteger code, id responseObject))failure {


    if (failure) {
        failure(code, responseObject);
    }
}

-(void)handleCategories:(NSDictionary *)user{
    if(user[@"projectCategory"] &&user[@"projectCategory"][@"data"]){
        self.categories=[NSMutableArray array];
        for (NSDictionary *one in user[@"projectCategory"][@"data"]) {
//            [self.categories addObject:[[CategoryModel alloc] initWithId:(NSUInteger) [number integerValue]
//                                                                    name:user[@"projectCategory"][@"data"][number]]];
            [self.categories addObject:[[CategoryModel alloc] initWithDictionary:one
                                                                           error:nil]];
        }

//        [[NSUserDefaults standardUserDefaults] setObject:self.categories forKey:kCategories];
    }

}
//
//-(NSNumber *)currentCategoriesConfigVersion{
//
//}

-(void)appInitGetSessionSuccess:(void (^)(void))success fail:(void (^)(NSInteger, id))failure{
    NSMutableDictionary *d= [@{@"configVersion" : @0} mutableCopy];
    if(self.deviceToken){
        d[@"deviceToken"]=self.deviceToken;
    }
    [self sendPost:@"app/init"
             param:d
           success:^(NSDictionary * user){

               if(user[@"token"]){
                   self.token=user[@"token"];
               }
               [self handleCategories:user];
//               self.currentUser= [[UserModel alloc] initWithDictionary:user
//                                                                 error:nil];
               success();
           }
           failure:failure];
}

//-(void)registerSuccess:(void (^)(void))success fail:(void (^)(NSInteger, id))failure{
//    [self sendPost:@"user/register"
//            param:nil
//          success:^(NSDictionary * user){
//              self.token=user[@"token"];
//              [self handleCategories:user];
//              self.currentUser= [[UserModel alloc] initWithDictionary:user
//                                                                error:nil];
//              success();
//          }
//          failure:failure];
//}




-(void)restoreLoginOrAppinit_Success:(void (^)(void))success fail:(void (^)(NSInteger, id))failure{
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:keyChainId];

    NSString *token=keychain[kToken];
    self.token=token;
    if(self.isLogined ){
        [self quickLoginSuccess:^{
            success();
            [self getUserDetail_success:^(UserDetailModel *model) {

            } fail:^(NSInteger i, id o) {

            }];

        } fail:^(NSInteger i, id o) {
            self.isLogined=NO;
            [self appInitGetSessionSuccess:success
                                      fail:failure];
        }];




    }else{
        [self appInitGetSessionSuccess:success
                                  fail:failure];
    }
}

-(void)logoutSuccess:(void (^)(void))success fail:(void (^)(NSInteger, id))failure{
    self.token=nil;
    self.isLogined=NO;
    [self appInitGetSessionSuccess:success fail:failure];

}


-(void)getUserDetail_success:(void(^)(UserDetailModel *))success  fail:(void (^)(NSInteger, id))failure{



    [self sendGet:@"user/detail"
            param:nil
          success:^(id o) {
              self.currentUserDetail=[[UserDetailModel alloc] initWithDictionary:o error:nil];
              success([[UserDetailModel alloc] initWithDictionary:o error:nil]);
          } failure:failure];

}

-(void)updateUserInfo:(NSDictionary *)infoNeedUpdate success:(void(^)(void))success  fail:(void (^)(NSInteger, id))failure{
    [self sendPost:@"user/update"
             param:infoNeedUpdate
           success:^(id o) {
               success();
           } failure:failure];
}

-(void)checkUserHasPasswordSucc:(void (^)(BOOL hasPassword))success fail:(void (^)(NSInteger, id))failure{
    [self sendGet:@"user/has/psw"
            param:nil
          success:^(id o) {
              success([o[@"hasPSW"] boolValue]);
          } failure:failure];
}

-(void)changeUserPasswordWithOriginalRawPassword:(NSString *)oldPassword newRawPassword:(NSString *)newRawPassword
                                         success:(void (^)(void))success fail:(void (^)(NSInteger, id))failure{
    NSMutableDictionary *d=[NSMutableDictionary new];
    d[@"newPsw"]= [newRawPassword MD5String];
    if(oldPassword){
        d[@"currPsw"]= [oldPassword MD5String];
    }

    [self sendPost:@"user/update/psw"
             param:d
           success:^(id o) {
               success();
           } failure:failure];
}


-(void)changeUserPhoneWithPhoneNum:(NSString *)phoneNum receipt:(NSString *)receipt
                                         success:(void (^)(void))success fail:(void (^)(NSInteger, id))failure{

    [self sendPost:@"user/update/phone"
             param:@{
                     @"phoneNum":phoneNum,
                     @"receipt":receipt,
             }
           success:^(id o) {
               self.currentUser.phoneNum=phoneNum;
               self.currentUserDetail.phone=phoneNum;
               success();
           } failure:failure];
}



#pragma mark - 日志 话题

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
                  NSLog(@"getPostListWithPageIndicator: %@",oned);
                  if([oned[@"type"] isEqualToString:@"diary"]){
                      [r addObject:[[DiaryModel alloc] initWithDictionary:oned error:nil]];
                  }else{
                      [r addObject:[[TopicModel alloc] initWithDictionary:oned error:nil]];
                  }

              }
              success(r);
          } failure:failure];

}


-(void)getRecommendTopicList_success:(void(^)(NSArray *))success  fail:(void (^)(NSInteger, id))failure{
    [self sendGet:@"recommend/topic/list"
                 param:nil
          success:^(id o) {
              NSMutableArray *r=[NSMutableArray array];
              for (NSDictionary *oned in (NSArray *) o) {
                  [r addObject:[[TopicModel alloc] initWithDictionary:oned error:nil]];
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


//-(void)createDiaryBookWithDiaryBook:(DiaryBookModel *)book diary:(DiaryModel *)diary
//                            success:(void (^)(NSUInteger id))success fail:(void (^)(NSInteger, id))failure{
//    NSMutableDictionary *d=[NSMutableDictionary dictionary];
//    [d setValuesForKeysWithDictionary:[book toDictionaryWithNSArrayToJSONString]];
//    d[@"post_content"]=diary.content;
//    d[@"post_photoes"]= [diary.photoes toJsonString];
//    [d removeObjectForKey:@"id"];
//    [self sendPost:@"diary/create" param:d success:^(id o) {
//        NSUInteger id= [o[@"id"] unsignedIntValue];
//        success(id);
//    } failure:failure];
//}

-(void)createDiaryWithContent:(NSString *)content photoes:(NSArray *)photoes  success:(void (^)(NSUInteger id))success fail:(void (^)(NSInteger, id))failure{
    [self sendPost:@"diary/post"
             param:@{@"content":content,@"photoes":photoes?[photoes toJsonString]:@"[]"}
           success:^(id o) {
                NSUInteger id= [o[@"id"] unsignedIntValue];
                success(id);
           } failure:failure];
}


-(void)createCommentWithSubject:(NSString *)subject
                      subjectId:(NSNumber *)subjectId
                        content:(NSString *)content
        success:(void (^)(NSUInteger id,NSDictionary *respondObject))success fail:(void (^)(NSInteger, id))failure{
    [self sendPost:@"post/comment"
             param:@{
                     @"subject":subject,
                     @"subjectId":subjectId,
                     @"content":content,
             } success:^(id o) {
                NSUInteger id= [o[@"id"] unsignedIntValue];
                success(id,o);
            } failure:failure];

}




-(void)likePostId:(NSNumber *)iden
          success:(void(^)(void))success
             fail:(void (^)(NSInteger, id))failure{



    [self sendPost:@"post/like"
            param:@{@"id":iden}
          success:^(id o) {
              success();
          } failure:failure];

}


-(void)cancelLikePostId:(NSNumber *)iden
          success:(void(^)(void))success
             fail:(void (^)(NSInteger, id))failure{



    [self sendPost:@"post/cancel_like"
             param:@{@"postId":iden}
           success:^(id o) {
               success();
           } failure:failure];

}



-(NSData*)imageDataWithUploadResizingAndCompressToJpeg:(UIImage *)image{
    return UIImageJPEGRepresentation([image scaleDownToCoverSizeAndNoZoomForSmall:CGSizeMake(600, 600)], 85);
}


-(void)uploadOneImage:(UIImage *)image
        uploadToken:(UploadTokenModel *)uploadToken
        success:(void (^)(NSString *url))success fail:(void (^)(NSInteger, id))failure {
    NSLog(@"upload:%@",uploadToken);

    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    NSData *imageData = [self imageDataWithUploadResizingAndCompressToJpeg:image];

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


    AFHTTPRequestOperationManager *m = [AFHTTPRequestOperationManager manager];
    m.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];

    AFHTTPRequestOperation *operation = [m
            HTTPRequestOperationWithRequest:request
                                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                        if ([responseObject[@"code"] integerValue] == 200) {
                                            NSLog(@"success:%@",responseObject);
                                            success([NSString stringWithFormat:@"http://jiayanimg.b0.upaiyun.com/%@", responseObject[@"url"]]);
                                        } else {
                                            NSHTTPURLResponse *response = [operation response];
                                            NSString *contentType = [response MIMEType];
                                            NSInteger statusCode = [response statusCode];
                                            NSLog(@"Error to POST %@ - [%d] %@", [[operation request] URL], statusCode, [operation responseString]);
                                            failure(statusCode, [operation responseString]);
                                        }

                                    }
                                    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                        NSHTTPURLResponse *response = [operation response];
                                        NSString *contentType = [response MIMEType];
                                        NSInteger statusCode = [response statusCode];

                                        if (([contentType compare:@"text/plain"] == NSOrderedSame)
                                                || ([contentType compare:@"text/html"] == NSOrderedSame)) {
                                            NSLog(@"Error to POST %@ - [%d] %@", [[operation request] URL], statusCode, [operation responseString]);
                                            failure(statusCode, [operation responseString]);
                                        }
                                        else if ([contentType compare:@"application/json"] == NSOrderedSame) {
                                            NSLog(@"Error to POST %@ - [%d] %@", [[operation request] URL], statusCode, [operation responseObject]);
                                            failure(statusCode, [operation responseObject]);
                                        }
                                        else {
                                            NSLog(@"Error to POST %@ - [%d]", [[operation request] URL], statusCode);
                                            failure(statusCode, [operation responseString]);
                                        }
                                    }];

    [manager.operationQueue addOperation:operation];

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
            imageData = [self imageDataWithUploadResizingAndCompressToJpeg:image];

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


#pragma mark - 登陆 注册

-(void)registerWithParam:(NSDictionary *)data
                password:(NSString *)rawPassword
                 success:(void(^)(UserModel *))success
                    fail:(void (^)(NSInteger, id))failure{
    NSMutableDictionary *d= [data mutableCopy];
//    d[@"configVersion"]= @1.0;
    if (self.deviceToken){
        d[@"deviceToken"]=self.deviceToken;
    }

    if(rawPassword){
        d[@"psw"]= [rawPassword MD5String];
    }



    [self sendPost:@"user/register"
            param:d
          success:^(id o) {
              if(o[@"token"]){
                  self.token=o[@"token"];
              }
              UserModel *m=[[UserModel alloc] initWithDictionary:o error:nil];
              self.isLogined=YES;
              self.currentUser= [[UserModel alloc] initWithDictionary:o error:nil];
              success(m);
              [self getUserDetail_success:^(UserDetailModel *model) {

              } fail:^(NSInteger i, id o) {

              }];
          } failure:failure];

}




-(void)loginWithPhone:(NSString *)phone password:(NSString *)rawPassword
                 success:(void(^)(UserModel *))success
                    fail:(void (^)(NSInteger, id))failure{
    NSMutableDictionary *d= [NSMutableDictionary dictionary];
//    d[@"configVersion"]= @1.0;
    if (self.deviceToken){
        d[@"deviceToken"]=self.deviceToken;
    }
    d[@"phoneNum"]=phone;
    d[@"psw"]= [rawPassword MD5String];


    [self sendPost:@"user/login"
             param:d
           success:^(id o) {
               if(o[@"token"]){
                   self.token=o[@"token"];
               }
               UserModel *m=[[UserModel alloc] initWithDictionary:o error:nil];
               self.isLogined=YES;
               self.currentUser= [[UserModel alloc] initWithDictionary:o error:nil];
               success(m);
               [self getUserDetail_success:^(UserDetailModel *model) {

               } fail:^(NSInteger i, id o) {

               }];
           } failure:failure];

}



-(void)loginWithWeixinCode:(NSString *)wxCode
              success:(void(^)(UserModel *,NSString *wxReceipt))success
                 fail:(void (^)(NSInteger, id))failure{
    NSMutableDictionary *d= [NSMutableDictionary dictionary];
//    d[@"configVersion"]= @1.0;
    if (self.deviceToken){
        d[@"deviceToken"]=self.deviceToken;
    }
    d[@"wxCode"]=wxCode;

    [self sendPost:@"user/login"
             param:d
           success:^(id o) {
               if(o[@"token"]){
                   self.token=o[@"token"];
               }

               if(o[@"wxReceipt"]){
                   success(nil,o[@"wxReceipt"]);
                   [self getUserDetail_success:^(UserDetailModel *model) {

                   } fail:^(NSInteger i, id o) {

                   }];
               }else{
                   UserModel *m=[[UserModel alloc] initWithDictionary:o error:nil];
                   self.isLogined=YES;
                   self.currentUser= [[UserModel alloc] initWithDictionary:o error:nil];
                   success(m,nil);
               }
           } failure:failure];

}

//todo not finish
-(void)bindWeixinWithWeixinCode:(NSString *)wxCode


                   success:(void(^)(void))success
                      fail:(void (^)(NSInteger, id))failure{
    NSMutableDictionary *d= [NSMutableDictionary dictionary];


    d[@"wxCode"]=wxCode;

    [self sendPost:@"user/bind_account"
             param:d
           success:^(id o) {
               if(o[@"token"]){
                   self.token=o[@"token"];
               }

               success();
           } failure:failure];

}



-(void)quickLoginSuccess:(void (^)(void))success fail:(void (^)(NSInteger, id))failure{
    [self sendPost:@"user/quick_login"
             param:@{@"configVersion":@0}
           success:^(NSDictionary * user){
               if(user[@"token"]){
                   self.token=user[@"token"];
               }

               self.currentUser= [[UserModel alloc] initWithDictionary:user
                                                                 error:nil];

               [self handleCategories:user];

               success();
           }
           failure:failure];
}

-(void)judgePhoneIsAlreadyExsitedUser:(NSString *)phone
                              success:(void (^)(BOOL isExist))success
                                 fail:(void (^)(NSInteger, id))failure{
    [self sendGet:@"user/phone/exist"
            param:@{@"phoneNum":phone}
          success:^(NSDictionary * o){

              success([((NSNumber *) o[@"exist"]) boolValue]);
          }
          failure:failure];
}


-(void)sendConfirmCodeWithPhone:(NSString *)phone
                        success:(void (^)(NSString *confirmId))success fail:(void (^)(NSInteger, id))failure{
    [self sendGet:@"user/confirm_code/code"
             param:@{@"phoneNum":phone}
           success:^(NSDictionary * o){

               success(o[@"confirmId"]);
           }
           failure:failure];
}



-(void)validateConfirmCodeWithCode:(NSString *)code confirmId:(NSString *)confirmId
                        success:(void (^)(NSString *receipt))success fail:(void (^)(NSInteger, id))failure{
    [self sendPost:@"user/confirm_code/confirm"
             param:@{@"code":code,@"confirmId":confirmId}
           success:^(NSDictionary * o){

               success(o[@"receipt"]);
           }
           failure:failure];
}


-(void)forgetAndChangePasswordWithPhoneNum:(NSString *)phoneNum
                                   receipt:(NSString *)receipt
                               rawPassword:(NSString *)rawPassword
                           success:(void (^)(void))success
                                      fail:(void (^)(NSInteger, id))failure{
    [self sendPost:@"user/reset/psw"
             param:@{@"phone":phoneNum,@"receipt":receipt,@"newPsw":[rawPassword MD5String]}
           success:^(NSDictionary * o){

               success();
           }
           failure:failure];
}

#pragma mark - 活动

-(void)getEventsWithPageIndicator:(PageIndicator *)pi success:(void(^)(NSArray *))success  fail:(void (^)(NSInteger, id))failure{
    NSMutableDictionary *d=[NSMutableDictionary dictionary];
    [d setValuesForKeysWithDictionary:[pi toDictionary]];


    [self sendGet:@"event/list"
            param:d
          success:^(id o) {
              NSMutableArray *r=[NSMutableArray array];
              for (NSDictionary *oned in (NSArray *) o) {
                  [r addObject:[[EventModel alloc] initWithDictionary:oned error:nil]];
              }
              success(r);
          } failure:failure];

}

-(void)getMyBanMeiEventListWithPageIndicator:(PageIndicator *)pi success:(void(^)(NSArray *))success  fail:(void (^)(NSInteger, id))failure{
    #if USE_DEBUG_MOCK
        NSMutableArray *r=[NSMutableArray array];
    for (int i = 0; i < 10; ++i) {
        [r addObject:[EventModel randomOne]];
    }
    success(r);
    #else
    [self sendGet:@"company/event/my_list"
            param:[pi toDictionary]
          success:^(id o) {
              NSMutableArray *r=[NSMutableArray array];
              for (NSDictionary *oned in (NSArray *) o) {
                  [r addObject:[[EventModel alloc] initWithDictionary:oned error:nil]];
              }
              success(r);
          } failure:failure];
    #endif
}


-(void)getMyMeilitianshiEventListWithPageIndicator:(PageIndicator *)pi success:(void(^)(NSArray *))success  fail:(void (^)(NSInteger, id))failure{
#if USE_DEBUG_MOCK
    NSMutableArray *r=[NSMutableArray array];
    for (int i = 0; i < 10; ++i) {
        [r addObject:[EventModel randomOne]];
    }
    success(r);
#else
    [self sendGet:@"event/list"
            param:[pi toDictionary]
          success:^(id o) {
              NSMutableArray *r=[NSMutableArray array];
              for (NSDictionary *oned in (NSArray *) o) {
                  [r addObject:[[EventModel alloc] initWithDictionary:oned error:nil]];
              }
              success(r);
          } failure:failure];
#endif
}

-(void)createEventWithCategories:(NSArray *)categories
        success:(void(^)(NSUInteger id))success  fail:(void (^)(NSInteger, id))failure{

    [self sendPost:@"event/create"
             param:@{@"categoryIds": [categories toJsonString]}
           success:^(id o) {
               success([o[@"id"] unsignedIntegerValue]);
           } failure:failure];
}



-(void)getEventDetailWithEventId:(NSUInteger)id
                         success:(void(^)(EventModel *))success  fail:(void (^)(NSInteger, id))failure{
//#if USE_DEBUG_MOCK
//    NSMutableArray *r=[NSMutableArray array];
//    for (int i = 0; i < 10; ++i) {
//        [r addObject:[EventModel randomOne]];
//    }
//    success(r);
//#else
    [self sendGet:@"event/detail"
            param:@{@"id":@(id)}
          success:^(NSDictionary* o) {
              EventModel *d= [[EventModel alloc] initWithDictionary:o error:nil];
              success(d);
          } failure:failure];
//#endif
}


-(void)eventJoinApply:(NSDictionary *)data success:(void(^)( void))success  fail:(void (^)(NSInteger, id))failure{
    [self sendPost:@"event/apply"
             param:data
           success:^(id o) {
               success();
           } failure:failure];
}


-(void)commentEventWithParams:(NSDictionary *)param success:(void(^)( void))success  fail:(void (^)(NSInteger, id))failure{
    [self sendPost:@"event/comment"
             param:param success:^(id o) {
                success();
            } failure:failure];
}

#pragma mark - shouye

-(void)getIndexList_success:(void(^)(NSArray *))success  fail:(void (^)(NSInteger, id))failure{
//#if USE_DEBUG_MOCK
//    NSMutableArray *r=[NSMutableArray array];
//    for (int i = 0; i < 10; ++i) {
//        [r addObject:[EventModel randomOne]];
//    }
//    success(r);
//#else
    [self sendGet:@"homepage/event/list"
            param:nil
          success:^(id o) {
              NSMutableArray *r=[NSMutableArray array];
              for (NSDictionary *oned in (NSArray *) o) {
                  if ([oned[@"type"] isEqualToString:@"topic"]){
                      [r addObject:[[TopicModel alloc] initWithDictionary:oned error:nil]];
                  }else{
                      [r addObject:[[EventModel alloc] initWithDictionary:oned error:nil]];
                  }

              }
              success(r);
          } failure:failure];
//#endif
}


#pragma mark - 通知

-(void)getNotificationListWithPageIndicator:(PageIndicator *)pi success:(void(^)(NSArray *))success  fail:(void (^)(NSInteger, id))failure{
//    #if USE_DEBUG_MOCK
//        NSMutableArray *r=[NSMutableArray array];
//    for (int i = 0; i < 10; ++i) {
//        [r addObject:[TopicModel randomOne]];
//    }
//    success(r);
//    #else
    [self sendGet:@"user/msg/list"
            param:[pi toDictionary]
          success:^(id o) {
              NSMutableArray *r=[NSMutableArray array];
              for (NSDictionary *oned in (NSArray *) o) {
                  [r addObject:[[MessageNoticingModel alloc] initWithDictionary:oned error:nil]];
              }
              success(r);
          } failure:failure];
//#endif
}

@end