//
//  ConfigIndexVC.m
//  meiLiTianShi
//
//  Created by zcw on 15/7/26.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "ConfigIndexVC.h"
#import "XLForm.h"
#import "SuggestionsVC.h"
#import "AboutUsVC.h"

@interface ConfigIndexVC ()

@end

@implementation ConfigIndexVC



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(id)init
{
    XLFormDescriptor * formDescriptor = [XLFormDescriptor formDescriptorWithTitle:@"设置"];
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;

    section = [XLFormSectionDescriptor formSectionWithTitle:@""];

    [formDescriptor addFormSection:section];


    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"mima"
                                                rowType:XLFormRowDescriptorTypeSelectorPush title:@"修改账户密码"];

    //row.action.viewControllerClass=[MyDiaryBookListTVC class];
    [section addFormRow:row];


    section = [XLFormSectionDescriptor formSectionWithTitle:@""];

    [formDescriptor addFormSection:section];


    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"angzhu"
                                                rowType:XLFormRowDescriptorTypeSelectorPush title:@"使用帮助"];

    [section addFormRow:row];


    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"yijian"
                                                rowType:XLFormRowDescriptorTypeSelectorPush title:@"意见反馈"];

    row.action.viewControllerClass=[SuggestionsVC class];
    [section addFormRow:row];



    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"guanyu"
                                                rowType:XLFormRowDescriptorTypeSelectorPush title:@"关于我们"];

    row.action.viewControllerClass=[AboutUsVC class];
    [section addFormRow:row];


    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"kefudianhua"
                                                rowType:XLFormRowDescriptorTypeSelectorPush title:@"客服电话"];

    //row.action.viewControllerClass=[MyDiaryBookListTVC class];
    [section addFormRow:row];



    section = [XLFormSectionDescriptor formSectionWithTitle:@""];

    [formDescriptor addFormSection:section];


    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"tuichu"
                                                rowType:XLFormRowDescriptorTypeSelectorPush title:@"退出登录"];

    //row.action.viewControllerClass=[MyDiaryBookListTVC class];
    [section addFormRow:row];


    return [super initWithForm:formDescriptor];

}

@end
