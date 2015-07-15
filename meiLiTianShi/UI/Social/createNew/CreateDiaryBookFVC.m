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
#import "DoctorSelectVC.h"
#import "HospitalSelectVC.h"
#import "XLFormRatingCell.h"
#import "DoctorModel.h"
#import "HospitalModel.h"

@interface CreateDiaryBookFVC ()
@property (nonatomic, assign)BOOL uploadFinished;
@property (nonatomic, strong)NSArray *imageUrls;
@end

@implementation CreateDiaryBookFVC
#define kcates @"categoryIds"
#define kDate @"date"
#define kDoctor @"doctor"
#define kHospital @"hospital"
#define kRate @"rate"
#define kPrice @"price"

#define setValue(tagV,valueV)     [self.form formRowWithTag:tagV].value=valueV;
#define getValue(k) [self.form formRowWithTag:k].value


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"手术信息";
    //[self.form formRowWithTag:kcates].value=self.diaryBookWithOnlyCates.categories;
    self.uploadFinished=NO;
    [self uploadImages];
    setValue(kcates,self.diaryBookWithOnlyCates.categories);
    [self.tableView reloadData];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"保存"
                                                                            style:UIBarButtonItemStylePlain target:self
                                                                           action:@selector(submit)];
    //setValue(kDate, self.di)
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


-(void)submit{
    DiaryBookModel *diaryBook= self.diaryBookWithOnlyCates ;
    diaryBook.operationTimeNSDate= getValue(kDate);
    DoctorModel *doctor= getValue(kDoctor);
    if(doctor.id){
        diaryBook.doctorId=@(doctor.id);
    }else{
        diaryBook.doctorName=doctor.name;
    }

    HospitalModel *hospital= getValue(kHospital);
    if(hospital.id){
        diaryBook.hospitalId=@(hospital.id);
    }else{
        diaryBook.hospitalName=hospital.name;
    }

    diaryBook.categories= getValue(kcates);
    diaryBook.price= getValue(kPrice);
    diaryBook.satisfyLevel= getValue(kRate);
    //diaryBook.previousPhotoes=self.imageUrls;

    DiaryModel* diary=self.diaryWithoutImage;
    diary.photoes=self.imageUrls;

    [[MLSession current] createDiaryBookWithDiaryBook:diaryBook
                                                diary:diary
                                              success:^(NSUInteger id) {
                                                  [TSMessage showNotificationWithTitle:@"创建成功"
                                                                              subtitle:@"哈哈"
                                                                                  type:TSMessageNotificationTypeSuccess];
                                                  [self.navigationController popToRootViewControllerAnimated:YES];
                                              } fail:^(NSInteger i, id o) {
                [TSMessage showNotificationWithTitle:@"出错了"
                                            subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
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

    row = [XLFormRowDescriptor formRowDescriptorWithTag:kDate rowType:XLFormRowDescriptorTypeDate title:@"时间"];
    row.value = [NSDate new];
    [row.cellConfigAtConfigure setObject:[NSDate new] forKey:@"maximumDate"];
    [section addFormRow:row];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:kDoctor rowType:XLFormRowDescriptorTypeSelectorPush title:@"医生"];
    row.required = YES;
    row.action.viewControllerClass=[DoctorSelectVC class];
    [section addFormRow:row];


    row = [XLFormRowDescriptor formRowDescriptorWithTag:kHospital rowType:XLFormRowDescriptorTypeSelectorPush title:@"医院"];
    row.required = YES;
    row.action.viewControllerClass=[HospitalSelectVC class];
    [section addFormRow:row];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:kPrice rowType:XLFormRowDescriptorTypeInteger title:@"价格"];
    [section addFormRow:row];

    section = [XLFormSectionDescriptor formSectionWithTitle:@""];

    [formDescriptor addFormSection:section];


    row = [XLFormRowDescriptor formRowDescriptorWithTag:kRate rowType:XLFormRowDescriptorTypeRate title:@"评价"];
    row.value = @(0);
    [section addFormRow:row];

    return [super initWithForm:formDescriptor];

}
@end
