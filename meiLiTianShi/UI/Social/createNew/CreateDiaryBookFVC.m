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

@interface CreateDiaryBookFVC ()

@end

@implementation CreateDiaryBookFVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(id)init
{
    XLFormDescriptor * formDescriptor = [XLFormDescriptor formDescriptor];
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;

    section = [XLFormSectionDescriptor formSectionWithTitle:@""];

    [formDescriptor addFormSection:section];


    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"hehe" rowType:XLFormRowDescriptorTypeSelectorPush title:@"我的日记本"];
    row.required = YES;
    //row.action.viewControllerClass=[MyDiaryBookListTVC class];
    [section addFormRow:row];



    return [super initWithForm:formDescriptor];

}
@end
