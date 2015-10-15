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
#import "MLSession.h"
#import "PhoneBindVC.h"
#import "TSMessage.h"
#import "GeneralWebVC.h"
#import "MLStyleManager.h"
#import "ChangePasswordFVC.h"
#import "SuggestionsVCB.h"
#import "RMUniversalAlert.h"

@interface ConfigIndexVC ()

@end

@implementation ConfigIndexVC

#define kChangePassword @"changepassword"
#define kLogout @"logout"
#define kHelp @"bangzhu"
#define kPhone @"phnone"

- (void)viewDidLoad {
    [super viewDidLoad];

[MLStyleManager removeBackTextForNextScene:self];
}


-(id)init
{
    XLFormDescriptor * formDescriptor = [XLFormDescriptor formDescriptorWithTitle:@"设置"];
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;

    if ([MLSession current].isLogined) {
        section = [XLFormSectionDescriptor formSectionWithTitle:@""];

        [formDescriptor addFormSection:section];


        row = [XLFormRowDescriptor formRowDescriptorWithTag:kChangePassword
                                                    rowType:XLFormRowDescriptorTypeSelectorPush title:@"修改账户密码"];

        //row.action.viewControllerClass=[MyDiaryBookListTVC class];
        [section addFormRow:row];
    }


    section = [XLFormSectionDescriptor formSectionWithTitle:@""];

    [formDescriptor addFormSection:section];


    row = [XLFormRowDescriptor formRowDescriptorWithTag:kHelp
                                                rowType:XLFormRowDescriptorTypeSelectorPush title:@"使用帮助"];

    [section addFormRow:row];


    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"yijian"
                                                rowType:XLFormRowDescriptorTypeSelectorPush title:@"意见反馈"];

    row.action.viewControllerClass=[SuggestionsVCB class];
    [section addFormRow:row];



    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"guanyu"
                                                rowType:XLFormRowDescriptorTypeSelectorPush title:@"关于我们"];

    row.action.viewControllerClass=[AboutUsVC class];
    [section addFormRow:row];


    row = [XLFormRowDescriptor formRowDescriptorWithTag:kPhone
                                                rowType:XLFormRowDescriptorTypeSelectorPush title:@"客服电话"];
    row.cellConfig[@"detailTextLabel.text"] = PHONE_JIAYAN;
//    [UITableViewCell new].detailTextLabel

    //row.action.viewControllerClass=[MyDiaryBookListTVC class];
    [section addFormRow:row];


    if ([MLSession current].isLogined) {
        section = [XLFormSectionDescriptor formSectionWithTitle:@""];

        [formDescriptor addFormSection:section];


        row = [XLFormRowDescriptor formRowDescriptorWithTag:kLogout
                                                    rowType:XLFormRowDescriptorTypeSelectorPush title:@"退出登录"];

        //row.action.viewControllerClass=[MyDiaryBookListTVC class];
        [section addFormRow:row];
    }


    return [super initWithForm:formDescriptor];

}


- (void)didSelectFormRow:(XLFormRowDescriptor *)formRow {
    [super didSelectFormRow:formRow];
    if([formRow.tag isEqualToString:kChangePassword]){
//        PhoneBindVC *vc= [[PhoneBindVC alloc] init];
//        vc.type=PhoneBindVcType_changePasswordFirstStep;
        ChangePasswordFVC *vc=[ChangePasswordFVC new];
        [self.navigationController pushViewController:vc animated:YES];

    }else if([formRow.tag isEqualToString:kLogout]){
        [[MLSession current] logoutSuccess:^{
            [TSMessage showNotificationWithTitle:@"已经退出"
                                            type:TSMessageNotificationTypeMessage];
            [self.navigationController popViewControllerAnimated:YES];
        } fail:^(NSInteger i, id o) {
            [TSMessage showNotificationWithTitle:@"出错了"
                                        subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
                                            type:TSMessageNotificationTypeError];
        }];
    }else if([formRow.tag isEqualToString:kHelp]){
        GeneralWebVC *vc=[GeneralWebVC new];
        vc.url=[NSURL URLWithString:@"http://apptest.jiayantech.com/html/help.html"];
        vc.title=@"帮助";
        [self.navigationController pushViewController:vc animated:YES];

    }else if([formRow.tag isEqualToString:kPhone]){

        [RMUniversalAlert showAlertInViewController:self
                                          withTitle:@"提示"
                                            message:[NSString stringWithFormat: @"要拨打我们的客服电话 %@ 吗?",PHONE_JIAYAN]
                                  cancelButtonTitle:@"取消"
                             destructiveButtonTitle:nil
                                  otherButtonTitles:@[@"确定"]
                                           tapBlock:^(RMUniversalAlert *alert, NSInteger buttonIndex){
                                               if(buttonIndex==2){
                                                   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",PHONE_JIAYAN]]];
                                               }

                                           }];


    }
}

@end
