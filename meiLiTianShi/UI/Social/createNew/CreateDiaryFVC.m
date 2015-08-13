//
//  CreateDiaryFVC.m
//  meiLiTianShi
//
//  Created by zcw on 15/7/9.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "CreateDiaryFVC.h"
#import "XLForm.h"
#import "ProjectSelectVC.h"
#import "CategoriesArrayWrap.h"
#import "ImageRowCell.h"
#import "DiaryBookModel.h"
#import "DiaryModel.h"
#import "CreateDiaryBookFVC.h"
#import "MLSession.h"
#import "TSMessage.h"

@interface CreateDiaryFVC ()
@property (nonatomic, strong)DiaryModel *diaryWithoutImage;
@property (nonatomic, strong)NSArray *imagesToUpload;
@property (nonatomic, assign)BOOL uploadFinished;
@property (nonatomic, strong)NSArray *imageUrls;
@end

@implementation CreateDiaryFVC
#define kcates @"categoryIds"
#define kcontent @"content"
#define kDate @"date"
#define kImages @"images"

#define getValue(k) [self.form formRowWithTag:k].value


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"创建日记";

    //set value
    [self.form formRowWithTag:kcates].value=[CategoriesArrayWrap wrapWithCates:self.categories];
    [self.tableView reloadData];

    if(self.needToCreateNewDiaryBookLater){
        self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc] initWithTitle:@"下一步"
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self
                                                                                action:@selector(submit)];
    }

}

-(void)submit {
//    DiaryBookModel *book= [[DiaryBookModel alloc] init];
//    book.categories= getValue(kcates);
//    book.operationTimeNSDate= getValue(kDate);

    DiaryModel *diary=[[DiaryModel alloc]init];
    diary.content= getValue(kcontent);

    NSArray *images= getValue(kImages);

//    CreateDiaryBookFVC *bookFVC= [[CreateDiaryBookFVC alloc] init];
//    bookFVC.diaryBookWithOnlyCates=book;
    self.diaryWithoutImage=diary;
    self.imagesToUpload=images;
    [self uploadImages];

//    [self.navigationController pushViewController:bookFVC
//                                         animated:YES];

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

                                                                                [[MLSession current] createDiaryWithContent:self.diaryWithoutImage.content
                                                                                                                    photoes:urls
                                                                                                                    success:^(NSUInteger id) {
                                                                                                                        [TSMessage showNotificationWithTitle:@"发表成功"
                                                                                                                                                        type:TSMessageNotificationTypeSuccess];
                                                                                                                        [self.navigationController popViewControllerAnimated:YES];
                                                                                                                    } fail:^(NSInteger i, id o) {

                                                                                        }];
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


//
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kcates rowType:XLFormRowDescriptorTypeSelectorPush title:@"项目"];
//    row.required = YES;
//    row.action.viewControllerClass=[ProjectSelectVC class];
//    //row.value=
//    [section addFormRow:row];
//
//
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kDate rowType:XLFormRowDescriptorTypeDate title:@"手术日期"];
//    row.value = [NSDate new];
//    [row.cellConfigAtConfigure setObject:[NSDate new] forKey:@"maximumDate"];
//    [section addFormRow:row];



    row = [XLFormRowDescriptor formRowDescriptorWithTag:kcontent rowType:XLFormRowDescriptorTypeTextView];
    row.cellConfigAtConfigure[@"textView.placeholder"] = @"日记内容";
    [section addFormRow:row];


    row= [XLFormRowDescriptor formRowDescriptorWithTag:kImages rowType:XLFormRowDescriptorTypeImageRow];
    [section addFormRow:row];




    return [super initWithForm:formDescriptor];

}

@end
