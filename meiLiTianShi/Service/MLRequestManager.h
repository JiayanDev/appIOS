

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface MLRequestManager : NSObject
- (id)initWithBaseURL:(NSString *)baseUrl;

- (void)GET:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSInteger, id))failure;

- (void)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSInteger, id))failure;

- (void)POST:(NSString *)url parameters:(NSDictionary *)parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))constructingBodyWithBlock success:(void (^)(id))success failure:(void (^)(NSInteger, id))failure;

- (void)POSTJson:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSInteger, id))failure;

+ (MLRequestManager *)sharedInstance;
- (void)PUT:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSInteger, id))failure;

- (void)DELETE:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSInteger, id))failure;
@end