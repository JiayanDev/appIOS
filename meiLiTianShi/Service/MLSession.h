//
// Created by zcw on 15/7/2.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Masonry/MASConstraintMaker.h>

@class AFHTTPRequestOperationManager;
@class PageIndicator;
@class UploadTokenModel;
@class DiaryBookModel;
@class DiaryModel;
@class UserModel;
@class UserDetailModel;


@interface MLSession : NSObject

@property (nonatomic, strong)NSMutableArray *categories;


@property (nonatomic, strong) UserModel *currentUser;

@property (nonatomic, strong)NSString *deviceToken;

+ (MLSession *)current;

- (void)handleManager:(AFHTTPRequestOperationManager *)manager;

- (void)appInitGetSessionSuccess:(void (^)(void))success fail:(void (^)(NSInteger, id))failure;

- (void)registerSuccess:(void (^)(void))success fail:(void (^)(NSInteger, id))failure;

- (void)restoreLoginOrRegister_Success:(void (^)(void))success fail:(void (^)(NSInteger, id))failure;

- (void)getTopicListWithPageIndicator:(PageIndicator *)pi success:(void (^)(NSArray *))success fail:(void (^)(NSInteger, id))failure;

- (void)getDiaryBookListWithPageIndicator:(PageIndicator *)pi success:(void (^)(NSArray *))success fail:(void (^)(NSInteger, id))failure;

- (void)getPostListWithPageIndicator:(PageIndicator *)pi type:(NSString *)diaryOrTopic categoryId:(NSNumber *)cate success:(void (^)(NSArray *))success fail:(void (^)(NSInteger, id))failure;

- (void)getMyDiaryBookListWithPageIndicator:(PageIndicator *)pi success:(void (^)(NSArray *))success fail:(void (^)(NSInteger, id))failure;

- (void)getDiaryList_underDiaryBook:(NSUInteger)diaryBookId success:(void (^)(NSArray *))success fail:(void (^)(NSInteger, id))failure;

- (void)getHospitalWithBlurName:(NSString *)blurName pageIndicator:(PageIndicator *)pi success:(void (^)(NSArray *))success fail:(void (^)(NSInteger, id))failure;

- (void)getDoctorWithBlurName:(NSString *)blurName pageIndicator:(PageIndicator *)pi success:(void (^)(NSArray *))success fail:(void (^)(NSInteger, id))failure;

- (void)getImageUploadPolicyAndSignatureWithMod:(NSString *)mod Success:(void (^)(UploadTokenModel *))success fail:(void (^)(NSInteger, id))failure;

- (void)createDiaryBookWithDiaryBook:(DiaryBookModel *)book diary:(DiaryModel *)diary success:(void (^)(NSUInteger id))success fail:(void (^)(NSInteger, id))failure;

- (void)createCommentWithSubject:(NSString *)subject subjectId:(NSNumber *)subjectId content:(NSString *)content success:(void (^)(NSUInteger, NSDictionary *))success fail:(void (^)(NSInteger, id))failure;

- (void)getEventsWithPageIndicator:(PageIndicator *)pi success:(void (^)(NSArray *))success fail:(void (^)(NSInteger, id))failure;

- (void)getUserDetail_success:(void (^)(UserDetailModel *))success fail:(void (^)(NSInteger, id))failure;

- (void)uploadImages:(NSArray *)imageDatas uploadToken:(UploadTokenModel *)uploadToken allFinish:(void (^)(NSArray *urls, NSArray *fails, NSArray *remainImageDatas))success;
@end