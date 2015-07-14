//
//  CreateDiaryBookFVC.m
//  meiLiTianShi
//
//  Created by zcw on 15/7/9.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "CreateDiaryBookFVC.h"
#import "XLForm.h"
#import "CategoryModel.h"
#import "DiaryBookModel.h"
#import "DiaryModel.h"
#import "ProjectSelectVC.h"
#import "MLSession.h"
#import "TSMessage.h"

@interface CreateDiaryBookFVC ()
@property (nonatomic, assign)BOOL uploadFinished;
@property (nonatomic, strong)NSArray *imageUrls;
@end

@implementation CreateDiaryBookFVC
#define kcates @"categoryIds"

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.form formRowWithTag:kcates].value=self.diaryBookWithOnlyCates.categories;
    self.uploadFinished=NO;
    [self uploadImages];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)uploadImages{
    [[MLSession current]
            getImageUploadPolicyAndSignatureWithMod:@"diary"
                                            Success:^(UploadTokenModel *model) {
                                                [[MLSession current] uploadImages:self.imagesToUpload
                                                                      uploadToken:model
                                                                        allFinish:^(NSArray *urls, NSArray *fails, NSArray *remainImageDatas) {
                                                                            self.uploadFinished = YES;
                                                                            self.imageUrls = urls;
                                                                            if (fails.count > 0) {
                                                                                [TSMessage showNotificationWithTitle:@"上传中出错了"
                                                                                                            subtitle:[NSString stringWithFormat:
                                                                                                                    @"成功：%lu个，失败：%lu个，失败信息：%@",
                                                                                                                    urls.count, fails.count, [fails componentsJoinedByString:@"\n"]]
                                                                                                                type:TSMessageNotificationTypeError];
                                                                            } else {

                                                                            }

                                                                        }];
                                            } fail:^(NSInteger i, id o) {
                [TSMessage showNotificationWithTitle:@"获取token出错" subtitle:[NSString stringWithFormat:@"%ld %@", (long)i, o]
                                                type:TSMessageNotificationTypeError];
            }];

}

-(id)init
{
    XLFormDescriptor * formDescriptor = [XLFormDescriptor formDescriptor];
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;

    section = [XLFormSectionDescriptor formSectionWithTitle:@""];

    [formDescriptor addFormSection:section];


    row = [XLFormRowDescriptor formRowDescriptorWithTag:kcates rowType:XLFormRowDescriptorTypeSelectorPush title:@"项目"];
    row.required = YES;
    row.action.viewControllerClass=[ProjectSelectVC class];
    [section addFormRow:row];



    return [super initWithForm:formDescriptor];

}
@end
