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
#import "MLSession.h"
#import "LoginWaySelectVC.h"
#import "MyBanMeiListTVC.h"
#import "MyMeiLiTianShiVC.h"
#import "MLStyleManager.h"

@interface MyIndexVC ()
@property (nonatomic, strong)XLFormDescriptor *logginedFormDescriptor;
@property (nonatomic, strong)XLFormDescriptor *noLoginFormDescriptor;
@end

@implementation MyIndexVC

#define kLogin @"login"

- (void)viewDidLoad {
    [super viewDidLoad];
    [MLStyleManager styleTheNavigationBar:self.navigationController.navigationBar];
    // Do any additional setup after loading the view from its nib.
    self.title=@"我的";
}

-(id)init
{
    XLFormDescriptor *logginedFormDescriptor = [XLFormDescriptor formDescriptor];
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;

    section = [XLFormSectionDescriptor formSectionWithTitle:@""];

    [logginedFormDescriptor addFormSection:section];


    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"user" rowType:XLFormRowDescriptorTypeSelectorPush title:@"我的资料"];
    row.action.viewControllerClass=[InfoIndexVC class];
    [section addFormRow:row];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"tongzhi" rowType:XLFormRowDescriptorTypeSelectorPush title:@"我的通知"];
//    row.action.viewControllerClass=[InfoIndexVC class];
    [section addFormRow:row];

//    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"fabu" rowType:XLFormRowDescriptorTypeSelectorPush title:@"我的发布"];
////    row.action.viewControllerClass=[MyDiaryBookListTVC class];
//    [section addFormRow:row];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"banmei" rowType:XLFormRowDescriptorTypeSelectorPush title:@"我的伴美"];
    row.action.viewControllerClass=[MyBanMeiListTVC class];
    [section addFormRow:row];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"meilitianshi" rowType:XLFormRowDescriptorTypeSelectorPush title:@"美丽天使"];
    row.action.viewControllerClass=[MyMeiLiTianShiVC class];
    [section addFormRow:row];


    section = [XLFormSectionDescriptor formSectionWithTitle:@""];
    [logginedFormDescriptor addFormSection:section];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"shezhi" rowType:XLFormRowDescriptorTypeSelectorPush title:@"设置"];
    row.action.viewControllerClass=[ConfigIndexVC class];
    [section addFormRow:row];

    self.logginedFormDescriptor=logginedFormDescriptor;


    self.noLoginFormDescriptor= [XLFormDescriptor formDescriptor];
    section = [XLFormSectionDescriptor formSectionWithTitle:@""];

    [self.noLoginFormDescriptor addFormSection:section];


    row = [XLFormRowDescriptor formRowDescriptorWithTag:kLogin rowType:XLFormRowDescriptorTypeButton title:@"登陆"];
    //row.action.viewControllerClass=[InfoIndexVC class];
    [section addFormRow:row];


    section = [XLFormSectionDescriptor formSectionWithTitle:@""];
    [self.noLoginFormDescriptor addFormSection:section];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"shezhi" rowType:XLFormRowDescriptorTypeSelectorPush title:@"设置"];
    row.action.viewControllerClass=[ConfigIndexVC class];
    [section addFormRow:row];


    if([MLSession current].isLogined){
        return [super initWithForm:logginedFormDescriptor];
    }else{
        return [super initWithForm:self.noLoginFormDescriptor];
    }

}


- (void)didSelectFormRow:(XLFormRowDescriptor *)formRow {
    [super didSelectFormRow:formRow];
    if([formRow.tag isEqualToString:kLogin]){
        LoginWaySelectVC *vc= [[LoginWaySelectVC alloc] init];
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc]
                           animated:YES
                         completion:^{

                         }];
    }
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([MLSession current].isLogined){
        self.form=self.logginedFormDescriptor;
    }else{
        self.form=self.noLoginFormDescriptor;
    }

    [self.tableView reloadData];

}


@end
