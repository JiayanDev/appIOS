//
//  MyIndexVC.m
//  meiLiTianShi
//
//  Created by zcw on 15/7/7.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "MyIndexVC.h"
#import "XLForm.h"
#import "MyDiaryBookListTVC.h"

@interface MyIndexVC ()

@end

@implementation MyIndexVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"我的";
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
    row.action.viewControllerClass=[MyDiaryBookListTVC class];
    [section addFormRow:row];



    return [super initWithForm:formDescriptor];

}


@end
