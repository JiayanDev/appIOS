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
#import "InfoIndexVC.h"
#import "ConfigIndexVC.h"

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


    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"user" rowType:XLFormRowDescriptorTypeSelectorPush title:@"我的资料"];
    row.action.viewControllerClass=[InfoIndexVC class];
    [section addFormRow:row];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"tongzhi" rowType:XLFormRowDescriptorTypeSelectorPush title:@"我的通知"];
//    row.action.viewControllerClass=[InfoIndexVC class];
    [section addFormRow:row];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"fabu" rowType:XLFormRowDescriptorTypeSelectorPush title:@"我的发布"];
//    row.action.viewControllerClass=[MyDiaryBookListTVC class];
    [section addFormRow:row];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"banmei" rowType:XLFormRowDescriptorTypeSelectorPush title:@"我的伴美"];
//    row.action.viewControllerClass=[MyDiaryBookListTVC class];
    [section addFormRow:row];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"meilitianshi" rowType:XLFormRowDescriptorTypeSelectorPush title:@"美丽天使"];
//    row.action.viewControllerClass=[MyDiaryBookListTVC class];
    [section addFormRow:row];


    section = [XLFormSectionDescriptor formSectionWithTitle:@""];
    [formDescriptor addFormSection:section];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"shezhi" rowType:XLFormRowDescriptorTypeSelectorPush title:@"设置"];
    row.action.viewControllerClass=[ConfigIndexVC class];
    [section addFormRow:row];


    return [super initWithForm:formDescriptor];

}


@end
