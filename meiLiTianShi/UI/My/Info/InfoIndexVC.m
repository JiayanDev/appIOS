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
#import "XLFormTextDetailViewController.h"
#import "AreaSelectTVC.h"
#import "AreaSelectModel.h"
#import "RMUniversalAlert.h"
#import "PhoneBindVC.h"
#import "AvatarDetailVC.h"

@interface InfoIndexVC()
@property (nonatomic, strong)UserDetailModel *detailModel;
@end
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
    row.action.viewControllerClass=[AvatarDetailVC class];
    [section addFormRow:row];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:kNickname rowType:XLFormRowDescriptorTypeSelectorPush title:@"昵称"];
    row.action.viewControllerClass=[XLFormTextDetailViewController class];
    row.pushConfigs[kPushInnerRowType]=XLFormRowDescriptorTypeText;
    //row.pushConfigs[kPushInnerTitle]=XLFormRowDescriptorTypeText;
    row.value=[MLSession current].currentUser.name;
    [section addFormRow:row];

//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kSex rowType:XLFormRowDescriptorTypeSelectorPush title:@"性别"];
// Selector Push
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kSex rowType:XLFormRowDescriptorTypeSelectorPush title:@"性别"];
    row.selectorOptions = @[[XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"男"],
            [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"女"],
    ];
    [section addFormRow:row];

    //row.value = [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"Option 2"];    [section addFormRow:row];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:kArea rowType:XLFormRowDescriptorTypeSelectorPush title:@"地区"];
    //row.value=[AreaSelectModel initAndFindPositionForName:<#(NSString *)name#>]
    row.action.viewControllerClass=[AreaSelectTVC class];
    [section addFormRow:row];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:kBirthday rowType:XLFormRowDescriptorTypeSelectorPush title:@"生日"];
//    row.action.viewControllerClass=[MyDiaryBookListTVC class];
    row.action.viewControllerClass=[XLFormTextDetailViewController class];
    row.pushConfigs[kPushInnerRowType]=XLFormRowDescriptorTypeDate;
    //row.pushConfigs[kPushInnerTitle]=XLFormRowDescriptorTypeText;
//    row.value=[MLSession current].currentUser.name;
    [section addFormRow:row];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:kCellphone rowType:XLFormRowDescriptorTypeSelectorPush title:@"手机"];
//    row.action.viewControllerClass=[MyDiaryBookListTVC class];
    row.disabled=@YES;
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
    [self getData];

}


-(void)getData{
    [[MLSession current] getUserDetail_success:^(UserDetailModel *model) {

        self.detailModel=model;
        setValue(kAvatar, model.avatar);
        setValue(kNickname, model.name);
        setValue(kSex, [model.gender boolValue]
                ?
                [XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"男"]
                :
                [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"女"]);
        setValue(kArea,[AreaSelectModel initAndFindPositionForName:model.city]);
        if(model.birthday){
            setValue(kBirthday,[NSDate dateWithTimeIntervalSince1970:[model.birthday unsignedIntegerValue]])
        }

        setValue(kCellphone,model.phone);
        setValue(kWeixin,model.bindWX?@"已绑定":@"未绑定");



        [self.tableView reloadData];

    } fail:^(NSInteger i, id o) {
        [TSMessage showNotificationWithTitle:@"出错了"
                                    subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
                                        type:TSMessageNotificationTypeError];
    }];
}

- (void)didSelectFormRow:(XLFormRowDescriptor *)formRow {
    [super didSelectFormRow:formRow];
    if([formRow.tag isEqualToString:kWeixin]){

        [RMUniversalAlert showActionSheetInViewController:self
                                                withTitle:nil
                                                  message:nil
                                        cancelButtonTitle:@"取消"
                                   destructiveButtonTitle:nil
                                        otherButtonTitles:@[self.detailModel.bindWX?
                                                @"更换绑定的微信":
                                                @"绑定微信"]
                       popoverPresentationControllerBlock:nil
                                                 tapBlock:^(RMUniversalAlert *alert, NSInteger buttonIndex){
                                                     if (buttonIndex == alert.cancelButtonIndex) {
                                                         NSLog(@"Cancel Tapped");
                                                     } else if (buttonIndex >= alert.firstOtherButtonIndex) {

                                                         PhoneBindVC *vc= [[PhoneBindVC alloc] init];
                                                         vc.type=PhoneBindVcType_bindWechatFirstStep;
                                                         [self.navigationController pushViewController:vc
                                                                                              animated:YES];
                                                     }
                                                 }];
    }
}


- (void)formRowDescriptorValueHasChanged:(XLFormRowDescriptor *)formRow oldValue:(id)oldValue newValue:(id)newValue {
//    if([formRow.tag isEqualToString:]){
//
//    }
}


@end