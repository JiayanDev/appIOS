

#import "MLRequestManager.h"
#import "MLSession.h"

static NSString* BASE_URL = @"http://apptest.jiayantech.com/";


static MLRequestManager* instance = nil;

@interface MLRequestManager ()
@end

@implementation MLRequestManager {
    AFHTTPRequestOperationManager* _manager;
    AFHTTPRequestOperationManager* _managerForJson;
}

+ (MLRequestManager*)sharedInstance {
    if (!instance) {
        @synchronized(BASE_URL) {
            if (!instance) {
                instance = [[MLRequestManager alloc] initWithBaseURL:BASE_URL];
            }
        }
    }
    return instance;
}

- (id)initWithBaseURL:(NSString*)baseUrl {
    self = [super init];
    if (self) {
        _manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
        _managerForJson = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
        [_managerForJson setRequestSerializer:[AFJSONRequestSerializer serializer]];
    }
    return self;
}

- (void)GET:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSInteger, id))failure {
    [[MLSession current] handleManager:_manager];
    NSLog(@"GET %@   param:%@", url,parameters);
    AFHTTPRequestOperation* operation = [_manager
            GET:url
     parameters:parameters
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"GET SUCC %@", responseObject);
            [self onSuccess:operation responseObject:responseObject success:success];                                         }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self onFailure:operation error:error failure:failure];
        }];
    [operation resume];
}

- (void)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSInteger, id))failure {
    NSLog(@"POST %@", url);
    NSLog(@"POST DATA %@", parameters);
    [[MLSession current] handleManager:_manager];
    AFHTTPRequestOperation* operation = [_manager
            POST:url
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"POST SUCC %@", responseObject);
             [self onSuccess:operation responseObject:responseObject success:success];                                         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [self onFailure:operation error:error failure:failure];
         }];
    [operation resume];
}

- (void)POST_NON_AUTH:(NSString *)url parameters:(NSDictionary *)parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))constructingBodyWithBlock success:(void (^)(id))success failure:(void (^)(NSInteger, id))failure {
    NSLog(@"POST %@", url);
    AFHTTPRequestOperation* operation = [_manager
                     POST:url
               parameters:parameters
constructingBodyWithBlock:constructingBodyWithBlock
                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                      [self onSuccess:operation responseObject:responseObject success:success];                                         }
                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                      [self onFailure:operation error:error failure:failure];
                  }];
    [operation resume];
}

- (void)POSTJson:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSInteger, id))failure {
    NSLog(@"POST %@", url);
    NSLog(@"POST DATA %@", parameters);
    AFHTTPRequestOperation* operation = [_managerForJson
            POST:url
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [self onSuccess:operation responseObject:responseObject success:success];                                         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [self onFailure:operation error:error failure:failure];
         }];
    [operation resume];
}

- (void)PUT:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSInteger, id))failure {
    NSLog(@"PUT %@", url);
    AFHTTPRequestOperation* operation = [_manager
            PUT:url
     parameters:parameters
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self onSuccess:operation responseObject:responseObject success:success];                                         }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self onFailure:operation error:error failure:failure];
        }];
    [operation resume];
}

- (void)DELETE:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSInteger, id))failure {
    NSLog(@"DELETE %@", url);
    AFHTTPRequestOperation* operation = [_manager
            DELETE:url
        parameters:parameters
           success:^(AFHTTPRequestOperation *operation, id responseObject) {
               [self onSuccess:operation responseObject:responseObject success:success];                                         }
           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               [self onFailure:operation error:error failure:failure];
           }];
    [operation resume];
}

- (void)onSuccess:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject success:(void (^)(id))success {
    success(responseObject);
}

- (void)onFailure:(AFHTTPRequestOperation *)operation error:(NSError *)error failure:(void (^)(NSInteger, id))failure {
    NSHTTPURLResponse* response = [operation response];
    NSString* contentType = [response MIMEType];
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
        failure(statusCode, nil);
    }
}
@end