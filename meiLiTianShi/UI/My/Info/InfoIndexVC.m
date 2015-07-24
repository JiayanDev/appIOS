//
// Created by zcw on 15/7/22.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <XLForm/XLForm.h>
#import "InfoIndexVC.h"
#import "MLSession.h"
#import "UserModel.h"
#import "AvatarTCell.h"
#import "TSMessage.h"
#import "UserDetailModel.h"


@implementation InfoIndexVC {

}

#define kAvatar @"avatar"
#define kNickname @"nickname"
#define kSex @"sex"
#define kArea @"area"
#define kBirthday @"birthday"
#define kCellphone @"cellphone"
#define kWeixin @"weixin"
#define setValue(tagV,valueV)     [self.form formRowWithTag:tagV].value=valueV;


-(id)init
{
    XLFormDescriptor * formDescriptor = [XLFormDescriptor formDescriptorWithTitle:@"我的资料"];
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;

    section = [XLFormSectionDescriptor formSectionWithTitle:@""];

    [formDescriptor addFormSection:section];


    row = [XLFormRowDescriptor formRowDescriptorWithTag:kAvatar rowType:XLFormRowDescriptorTypeAvatar title:@"头像"];
    //row.action.viewControllerClass=[MyDiaryBookListTVC class];
    [section addFormRow:row];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:kNickname rowType:XLFormRowDescriptorTypeSelectorPush title:@"昵称"];
//    row.action.viewControllerClass=[InfoIndexVC class];
    row.value=[MLSession current].currentUser.name;
    [section addFormRow:row];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:kSex rowType:XLFormRowDescriptorTypeSelectorPush title:@"性别"];
//    row.action.viewControllerClass=[MyDiaryBookListTVC class];
    [section addFormRow:row];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:kArea rowType:XLFormRowDescriptorTypeSelectorPush title:@"地区"];
//    row.action.viewControllerClass=[MyDiaryBookListTVC class];
    [section addFormRow:row];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:kBirthday rowType:XLFormRowDescriptorTypeSelectorPush title:@"生日"];
//    row.action.viewControllerClass=[MyDiaryBookListTVC class];
    [section addFormRow:row];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:kCellphone rowType:XLFormRowDescriptorTypeSelectorPush title:@"手机"];
//    row.action.viewControllerClass=[MyDiaryBookListTVC class];
    [section addFormRow:row];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:kWeixin rowType:XLFormRowDescriptorTypeSelectorPush title:@"微信"];
//    row.action.viewControllerClass=[MyDiaryBookListTVC class];
    [section addFormRow:row];
//
//
//    section = [XLFormSectionDescriptor formSectionWithTitle:@""];
//    [formDescriptor addFormSection:section];
//
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"shezhi" rowType:XLFormRowDescriptorTypeSelectorPush title:@"设置"];
////    row.action.viewControllerClass=[MyDiaryBookListTVC class];
//    [section addFormRow:row];


    return [super initWithForm:formDescriptor];

}


- (void)viewDidLoad {
    [super viewDidLoad];

    [[MLSession current] getUserDetail_success:^(UserDetailModel *model) {

        setValue(kAvatar, model.avatar);
        setValue(kNickname, model.name);
        setValue(kSex, <#valueV#>);


        [self.tableView reloadData];

    } fail:^(NSInteger i, id o) {
        [TSMessage showNotificationWithTitle:@"出错了"
                                    subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
                                        type:TSMessageNotificationTypeError];
    }];
}



@end