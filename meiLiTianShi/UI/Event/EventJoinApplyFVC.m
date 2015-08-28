//
// Created by zcw on 15/8/27.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "EventJoinApplyFVC.h"
#import "InfoCellOfListOfKV.h"
#import "XLform_getAndSetValue.h"
#import "PersonCellOfAvatarAndName.h"
#import "MLSession.h"
#import "UserModel.h"
#import "PhoneAndGotoEditButtonCell.h"
#import "UILabel+MLStyle.h"
#import "EventModel.h"
#import "NSDate+XLformPushDisplay.h"
#import "CategoryModel.h"
#import "TSMessage.h"
#import "UserDetailModel.h"
#import "RMUniversalAlert.h"

@interface EventJoinApplyFVC()
@property (nonatomic, strong)EventModel *event;
@property (nonatomic, strong)UserDetailModel *userDetailModel;
@end
@implementation EventJoinApplyFVC {
    UIButton *b;
    UIView *v;
    UILabel *l;
}


#define kInfoCell @"infocell"
#define kPersonCell @"personcell"
#define kPhoneCell @"phonecell"
#define kNickCell @"nickcell"

- (void)viewDidLoad {
    [super viewDidLoad];
    setValue(kInfoCell,(@[
            @{@"项目":([self.eventInfo valueForKeyPath:@"categoryIds"]!=[NSNull null]?[self.eventInfo valueForKeyPath:@"categoryIds"]:@"null")},
            @{@"医生":[self.eventInfo valueForKeyPath:@"doctorName"]},
            @{@"时间":[self.eventInfo valueForKeyPath:@"beginTime"]}]));
    setValue(kPersonCell,(@{kName:[self.eventInfo valueForKeyPath:@"angelUserInfo.name"],
            kAvatar:[self.eventInfo valueForKeyPath:@"angelUserInfo.avatar"],}));
    setValue(kPhoneCell,[MLSession current].currentUser.phoneNum);
    setValue(kNickCell,(@[@{@"昵称":[MLSession current].currentUser.name}]));
    [self.tableView reloadData];

    [self layoutTheBottom];
    [self getData];



}


-(void)layoutTheBottom{
    self.tableView.tableFooterView=[UIView new];
    b=[UIButton new];
    THEME_BUTTON(b);
    [self.tableView.tableFooterView addSubview:b];
    [b mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@45);
        make.bottom.equalTo(self.tableView.tableFooterView).offset(-17);
        make.left.equalTo(self.tableView.tableFooterView).offset(17);
        make.right.equalTo(self.tableView.tableFooterView).offset(-17);
    }];

    v=[UIView new];
    v.backgroundColor=[UIColor colorWithHexString:@"ededed"];

    l=[UILabel newMLStyleWithSize:12 isGrey:YES];
    l.textColor=[UIColor colorWithHexString:@"8a8a8a"];

    [self.tableView.tableFooterView addSubview:v];
    [v addSubview:l];

    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(b.mas_top).offset(-17);
        make.left.equalTo(self.tableView.tableFooterView).offset(17);
        make.right.equalTo(self.tableView.tableFooterView).offset(-17);
    }];

    [l mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(v).insets(UIEdgeInsetsMake(15,17,15,17));
    }];

    [b setTitle:@"确认报名" forState:UIControlStateNormal];
    l.text=@"确认报名确认报名确认报名确认报名确认报名确认报名确认报名确认报名确认报名确认报名确认报名确认报名确认报名确认报名确认报名";
    l.lineBreakMode=NSLineBreakByCharWrapping;
    l.numberOfLines=0;


    [b addTarget:self
          action:@selector(submitButtonPress:)
forControlEvents:UIControlEventTouchUpInside];
}

-(void)getData{
    [[MLSession current] getEventDetailWithEventId:(NSUInteger) [self.eventId integerValue]
                                           success:^(EventModel *model) {

                                               self.event = model;
//                                               self.huoDongXiangQing.text = [NSString stringWithFormat:
//                                                       @"时间:%@ \n医院:%@ \n医生:%@ \n项目:%@ ",
//                                                       [[NSDate dateWithTimeIntervalSince1970:[model.beginTime unsignedIntegerValue]] displayTextWithDateAndHHMM],
//                                                       model.hospitalName,
//                                                       model.doctorName,
//                                                       [CategoryModel stringWithIdArray:model.categoryIds]
//
//                                               ];

                                           } fail:^(NSInteger i, id o) {
                [TSMessage showNotificationWithTitle:@"出错了"
                                            subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
                                                type:TSMessageNotificationTypeError];
            }];


    [[MLSession current] getUserDetail_success:^(UserDetailModel *model) {
        self.userDetailModel=model;
    } fail:^(NSInteger i, id o) {

    }];
};






- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];

    NSLog(@"%@",NSStringFromCGRect(self.tableView.tableFooterView.frame));
    CGRect r=self.tableView.tableFooterView.frame;
    r.size.height=MAX(64, self.tableView.frame.size.height-r.origin.y-64);
    self.tableView.tableFooterView.frame=r;

}

- (IBAction)submitButtonPress:(id)sender {


    [[MLSession current] eventJoinApply:@{
            @"eventId":self.eventId,
            @"phone":self.userDetailModel.phone,
            @"name":self.userDetailModel.name,
            @"gender":self.userDetailModel.gender,
    } success:^{
        [RMUniversalAlert showAlertInViewController:self
                                          withTitle:@"提示"
                                            message:@"报名已提交,请等待工作人员审核"
                                  cancelButtonTitle:@"确定"
                             destructiveButtonTitle:nil
                                  otherButtonTitles:nil
                                           tapBlock:^(RMUniversalAlert *alert, NSInteger buttonIndex){

                                               [self.navigationController popViewControllerAnimated:YES];
                                           }];

    } fail:^(NSInteger i, id o) {
        [TSMessage showNotificationWithTitle:@"出错了"
                                    subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
                                        type:TSMessageNotificationTypeError];
    }];
}


-(id)init
{
    XLFormDescriptor * formDescriptor = [XLFormDescriptor formDescriptor];
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;

    section = [XLFormSectionDescriptor formSectionWithTitle:@""];

    [formDescriptor addFormSection:section];


    row = [XLFormRowDescriptor formRowDescriptorWithTag:kPersonCell rowType:XLFormRowDescriptorType_personCellOfAvatarAndName];
    [section addFormRow:row];


    row = [XLFormRowDescriptor formRowDescriptorWithTag:kInfoCell rowType:XLFormRowDescriptorType_infoCellOfKV];
    [section addFormRow:row];


    section = [XLFormSectionDescriptor formSectionWithTitle:@""];

    [formDescriptor addFormSection:section];
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kNickCell rowType:XLFormRowDescriptorType_infoCellOfKV];
    [section addFormRow:row];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:kPhoneCell rowType:XLFormRowDescriptorType_PhoneAndGotoEditButtonCell];
    [section addFormRow:row];






    return [super initWithForm:formDescriptor];

}



@end