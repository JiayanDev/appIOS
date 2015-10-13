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
#import "MLXLFormSelectorCell.h"
#import "AvatarAndNameAndDescCell.h"
#import "XLform_getAndSetValue.h"
#import "NotificationListTVC.h"
#import "TimeLineVCB.h"
#import "UserModel.h"
#import "UserDetailModel.h"

@interface MyIndexVC ()
@property (nonatomic, strong)XLFormDescriptor *logginedFormDescriptor;
@property (nonatomic, strong)XLFormDescriptor *noLoginFormDescriptor;
@end

@implementation MyIndexVC

#define kLogin @"login"
#define kUser @"user"
#define kMyTimeline @"mytimeline"

- (void)viewDidLoad {
    [super viewDidLoad];
    [MLStyleManager styleTheNavigationBar:self.navigationController.navigationBar];
    // Do any additional setup after loading the view from its nib.
    self.title=@"我的";
//    if([[MLSession current].currentUser.role isEqualToString:@"angel"]){
//
//    }else{
//        [self.form formRowWithTag:kMyTimeline].hidden=@YES;
//    }
    [MLStyleManager removeBackTextForNextScene:self];


}

-(id)init
{
    XLFormDescriptor *logginedFormDescriptor = [XLFormDescriptor formDescriptor];
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;

    section = [XLFormSectionDescriptor formSectionWithTitle:@""];

    [logginedFormDescriptor addFormSection:section];


    row = [XLFormRowDescriptor formRowDescriptorWithTag:kUser rowType:XLFormRowDescriptorType_AvatarAndNameAndDescCell title:@"我的资料"];
    row.action.viewControllerClass=[InfoIndexVC class];

    [section addFormRow:row];

    section = [XLFormSectionDescriptor formSectionWithTitle:@""];
    [logginedFormDescriptor addFormSection:section];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:kMyTimeline rowType:XLFormRowDescriptorTypeSelectorPush title:@"我的主页"];
    row.cellConfigAtConfigure[@"imageView.image"]=[UIImage imageNamed:@"我的_我的日志.png"];
    if(![[MLSession current].currentUser.role isEqualToString:@"angel"]){
        row.hidden=@YES;

    }
    [section addFormRow:row];



    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"tongzhi" rowType:XLFormRowDescriptorTypeSelectorPush title:@"我的通知"];
    row.cellConfigAtConfigure[@"imageView.image"]=[UIImage imageNamed:@"我的_我的通知.png"];
    row.action.viewControllerClass=[NotificationListTVC class];
    [section addFormRow:row];

//    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"fabu" rowType:XLFormRowDescriptorTypeSelectorPush title:@"我的发布"];
////    row.action.viewControllerClass=[MyDiaryBookListTVC class];
//    [section addFormRow:row];

    section = [XLFormSectionDescriptor formSectionWithTitle:@""];
    [logginedFormDescriptor addFormSection:section];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"banmei" rowType:XLFormRowDescriptorTypeSelectorPush title:@"我的伴美"];
    row.action.viewControllerClass=[MyBanMeiListTVC class];
    row.cellConfigAtConfigure[@"imageView.image"]=[UIImage imageNamed:@"我的_我的伴美.png"];
    [section addFormRow:row];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"meilitianshi" rowType:XLFormRowDescriptorTypeSelectorPush title:@"美丽天使"];
    row.action.viewControllerClass=[MyMeiLiTianShiVC class];
    row.cellConfigAtConfigure[@"imageView.image"]=[UIImage imageNamed:@"我的_美丽天使.png"];
    [section addFormRow:row];


    section = [XLFormSectionDescriptor formSectionWithTitle:@""];
    [logginedFormDescriptor addFormSection:section];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"shezhi" rowType:XLFormRowDescriptorTypeSelectorPush title:@"设置"];
    row.action.viewControllerClass=[ConfigIndexVC class];
    row.cellConfigAtConfigure[@"imageView.image"]=[UIImage imageNamed:@"我的_设置.png"];
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
    }else if([formRow.tag isEqualToString:kMyTimeline]){
        TimeLineVCB *vc=[TimeLineVCB new];
        vc.userId= @([MLSession current].currentUser.id);
        [self.navigationController pushViewController:vc
                                             animated:YES];
    }
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([MLSession current].isLogined){
        self.form=self.logginedFormDescriptor;
    }else{
        self.form=self.noLoginFormDescriptor;
    }

//    if([MLSession current].currentUserDetail){
//        setValue(kUser,[MLSession current].currentUserDetail);
//    }else{
        [[MLSession current] getUserDetail_success:^(UserDetailModel *model) {
            setValue(kUser,model);
            [self.tableView reloadData];
            if([model.role isEqualToString:@"angel"]){
                [self.form formRowWithTag:kMyTimeline].hidden=@NO;
            }else{
                [self.form formRowWithTag:kMyTimeline].hidden=@YES;
            }
        } fail:^(NSInteger i, id o) {

        }];
//    }




    [self.tableView reloadData];

}


@end
