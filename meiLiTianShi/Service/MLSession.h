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
@class LoginWaySelectVC;
@class SendAuthResp;
@class EventModel;

@protocol wxRespondVC
@required - (void)handleWxAuthRespond:(SendAuthResp *)resp;
@end

@interface MLSession : NSObject

@property (nonatomic, strong)NSMutableArray *categories;


@property (nonatomic, strong) UserModel *currentUser;

@property (nonatomic, strong)NSString *deviceToken;

@property (nonatomic, assign)BOOL isLogined;

@property (nonatomic, strong)UIViewController<wxRespondVC> *presentingWxLoginVC;

+ (MLSession *)current;

- (void)handleManager:(AFHTTPRequestOperationManager *)manager;

- (void)appInitGetSessionSuccess:(void (^)(void))success fail:(void (^)(NSInteger, id))failure;

//- (void)registerSuccess:(void (^)(void))success fail:(void (^)(NSInteger, id))failure;

- (void)restoreLoginOrAppinit_Success:(void (^)(void))success fail:(void (^)(NSInteger, id))failure;

- (void)logoutSuccess:(void (^)(void))success fail:(void (^)(NSInteger, id))failure;

- (void)getTopicListWithPageIndicator:(PageIndicator *)pi success:(void (^)(NSArray *))success fail:(void (^)(NSInteger, id))failure;

- (void)getDiaryBookListWithPageIndicator:(PageIndicator *)pi success:(void (^)(NSArray *))success fail:(void (^)(NSInteger, id))failure;

- (void)getPostListWithPageIndicator:(PageIndicator *)pi type:(NSString *)diaryOrTopic categoryId:(NSNumber *)cate success:(void (^)(NSArray *))success fail:(void (^)(NSInteger, id))failure;

- (void)getMyDiaryBookListWithPageIndicator:(PageIndicator *)pi success:(void (^)(NSArray *))success fail:(void (^)(NSInteger, id))failure;

//- (void)getDiaryList_underDiaryBook:(NSUInteger)diaryBookId success:(void (^)(NSArray *))success fail:(void (^)(NSInteger, id))failure;

- (void)getHospitalWithBlurName:(NSString *)blurName pageIndicator:(PageIndicator *)pi success:(void (^)(NSArray *))success fail:(void (^)(NSInteger, id))failure;

- (void)getDoctorWithBlurName:(NSString *)blurName pageIndicator:(PageIndicator *)pi success:(void (^)(NSArray *))success fail:(void (^)(NSInteger, id))failure;

- (void)getImageUploadPolicyAndSignatureWithMod:(NSString *)mod Success:(void (^)(UploadTokenModel *))success fail:(void (^)(NSInteger, id))failure;

- (void)createDiaryBookWithDiaryBook:(DiaryBookModel *)book diary:(DiaryModel *)diary success:(void (^)(NSUInteger id))success fail:(void (^)(NSInteger, id))failure;

- (void)createCommentWithSubject:(NSString *)subject subjectId:(NSNumber *)subjectId content:(NSString *)content success:(void (^)(NSUInteger, NSDictionary *))success fail:(void (^)(NSInteger, id))failure;

- (void)getEventsWithPageIndicator:(PageIndicator *)pi success:(void (^)(NSArray *))success fail:(void (^)(NSInteger, id))failure;

- (void)getUserDetail_success:(void (^)(UserDetailModel *))success fail:(void (^)(NSInteger, id))failure;

- (void)updateUserInfo:(NSDictionary *)infoNeedUpdate success:(void (^)(void))success fail:(void (^)(NSInteger, id))failure;

- (void)uploadOneImage:(UIImage *)image uploadToken:(UploadTokenModel *)uploadToken success:(void (^)(NSString *url))success fail:(void (^)(NSInteger, id))failure;

- (void)uploadImages:(NSArray *)imageDatas uploadToken:(UploadTokenModel *)uploadToken allFinish:(void (^)(NSArray *urls, NSArray *fails, NSArray *remainImageDatas))success;

//- (void)registerWithParam:(NSDictionary *)data success:(void (^)(UserDetailModel *))success fail:(void (^)(NSInteger, id))failure;

- (void)registerWithParam:(NSDictionary *)data password:(NSString *)rawPassword success:(void (^)(UserDetailModel *))success fail:(void (^)(NSInteger, id))failure;

- (void)loginWithPhone:(NSString *)phone password:(NSString *)rawPassword success:(void (^)(UserDetailModel *))success fail:(void (^)(NSInteger, id))failure;

- (void)loginWithWeixinCode:(NSString *)wxCode success:(void (^)(UserDetailModel *, NSString *))success fail:(void (^)(NSInteger, id))failure;

- (void)bindWeixinWithWeixinCode:(NSString *)wxCode success:(void (^)(void))success fail:(void (^)(NSInteger, id))failure;

- (void)sendConfirmCodeWithPhone:(NSString *)phone success:(void (^)(NSString *confirmId))success fail:(void (^)(NSInteger, id))failure;

- (void)validateConfirmCodeWithCode:(NSString *)code confirmId:(NSString *)confirmId success:(void (^)(NSString *receipt))success fail:(void (^)(NSInteger, id))failure;

- (void)forgetAndChangePasswordWithPhoneNum:(NSString *)phoneNum receipt:(NSString *)receipt rawPassword:(NSString *)rawPassword success:(void (^)(void))success fail:(void (^)(NSInteger, id))failure;

- (void)getMyBanMeiEventListWithPageIndicator:(PageIndicator *)pi success:(void (^)(NSArray *))success fail:(void (^)(NSInteger, id))failure;

- (void)getEventDetailWithEventId:(NSUInteger)id1 success:(void (^)(EventModel *))success fail:(void (^)(NSInteger, id))failure;

- (void)eventJoinApply:(NSDictionary *)data success:(void (^)(void))success fail:(void (^)(NSInteger, id))failure;
@end