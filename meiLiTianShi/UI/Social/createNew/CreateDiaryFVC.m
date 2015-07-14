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

@interface CreateDiaryFVC ()

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
                                                                                action:@selector(gotoDiaryBookCreate)];
    }

}

-(void)gotoDiaryBookCreate{
    DiaryBookModel *book= [[DiaryBookModel alloc] init];
    book.categories= getValue(kcates);
    book.operationTimeNSDate= getValue(kDate);

    DiaryModel *diary=[[DiaryModel alloc]init];
    diary.content= getValue(kcontent);

    NSArray *images= getValue(kImages);

    CreateDiaryBookFVC *bookFVC= [[CreateDiaryBookFVC alloc] init];
    bookFVC.diaryBookWithOnlyCates=book;
    bookFVC.diaryWithoutImage=diary;
    bookFVC.imagesToUpload=images;

    [self.navigationController pushViewController:bookFVC
                                         animated:YES];

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
    //row.value=
    [section addFormRow:row];


    row = [XLFormRowDescriptor formRowDescriptorWithTag:kDate rowType:XLFormRowDescriptorTypeDate title:@"手术日期"];
    row.value = [NSDate new];
    [row.cellConfigAtConfigure setObject:[NSDate new] forKey:@"maximumDate"];
    [section addFormRow:row];



    row = [XLFormRowDescriptor formRowDescriptorWithTag:kcontent rowType:XLFormRowDescriptorTypeTextView];
    row.cellConfigAtConfigure[@"textView.placeholder"] = @"日记内容";
    [section addFormRow:row];


    row= [XLFormRowDescriptor formRowDescriptorWithTag:kImages rowType:XLFormRowDescriptorTypeImageRow];
    [section addFormRow:row];




    return [super initWithForm:formDescriptor];

}

@end
