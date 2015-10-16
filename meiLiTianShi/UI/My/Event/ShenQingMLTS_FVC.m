//
// Created by zcw on 15/9/11.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "ShenQingMLTS_FVC.h"

#import "InfoCellOfListOfKV.h"
#import "XLform_getAndSetValue.h"
#import "MyMeiLiTianShiVC.h"
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
#import "XLForm.h"
#import "CateSelectVC.h"
#import "MLStyleManager.h"

@interface ShenQingMLTS_FVC()
@property (nonatomic, strong)UserDetailModel *userDetailModel;

@end
@implementation ShenQingMLTS_FVC {
    UIButton *b;
    UIView *v;
    UILabel *l;
}
//#define kInfoCell @"infocell"
//#define kPersonCell @"personcell"
#define kPhoneCell @"phonecell"
#define kNickCell @"nickcell"
#define kCateCell @"catecell"

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"申请成为美丽天使";
    [MLStyleManager removeBackTextForNextScene:self];
//    setValue(kInfoCell,(@[
//            @{@"项目":([self.eventInfo valueForKeyPath:@"categoryIds"]!=[NSNull null]?[self.eventInfo valueForKeyPath:@"categoryIds"]:@"null")},
//            @{@"医生":[self.eventInfo valueForKeyPath:@"doctorName"]},
//            @{@"时间":[self.eventInfo valueForKeyPath:@"beginTime"]}]));
//    setValue(kPersonCell,(@{kName:[self.eventInfo valueForKeyPath:@"angelUserInfo.name"],
//            kAvatar:[self.eventInfo valueForKeyPath:@"angelUserInfo.avatar"],}));
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
    l.text=@"信息确认无误并提交后，亲们将会在1~3个工作日内收到系统信息通知。可在“我的”-“我的通知”当中查看通知信息喔。";
    l.lineBreakMode=NSLineBreakByCharWrapping;
    l.numberOfLines=0;


    [b addTarget:self
          action:@selector(submitButtonPress:)
forControlEvents:UIControlEventTouchUpInside];
}

-(void)getData{

};






- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];

    NSLog(@"%@",NSStringFromCGRect(self.tableView.tableFooterView.frame));
    CGRect r=self.tableView.tableFooterView.frame;
    r.size.height=MAX(64, self.tableView.frame.size.height-r.origin.y-64);
    self.tableView.tableFooterView.frame=r;

    setValue(kPhoneCell,[MLSession current].currentUser.phoneNum);
    [self.tableView reloadData];
}

- (IBAction)submitButtonPress:(id)sender {


    CategoryModel *model=getValue(kCateCell);
    if(!model){
        [TSMessage showNotificationWithTitle:@"请选择部位"
                                        type:TSMessageNotificationTypeError];
    }
    [[MLSession current] createEventWithCategories:@[@(model.id)]
                                           success:^(NSUInteger id) {
                                               [RMUniversalAlert showAlertInViewController:self
                                                                                 withTitle:@"申请成功"
                                                                                   message:@"请耐心等待工作人员与您联系"
                                                                         cancelButtonTitle:@"确定"
                                                                    destructiveButtonTitle:nil
                                                                         otherButtonTitles:nil
                                                                                  tapBlock:^(RMUniversalAlert *alert, NSInteger buttonIndex){
                                                                                      [self.parentVC getDataWithScrollingToTop:YES];
                                                                                      [self.navigationController popToRootViewControllerAnimated:YES];
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


//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kPersonCell rowType:XLFormRowDescriptorType_personCellOfAvatarAndName];
//    [section addFormRow:row];
//
//
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kInfoCell rowType:XLFormRowDescriptorType_infoCellOfKV];
//    [section addFormRow:row];
//
//
//    section = [XLFormSectionDescriptor formSectionWithTitle:@""];

    [formDescriptor addFormSection:section];
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kNickCell rowType:XLFormRowDescriptorType_infoCellOfKV];
    [section addFormRow:row];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:kPhoneCell rowType:XLFormRowDescriptorType_PhoneAndGotoEditButtonCell];
    [section addFormRow:row];


    row = [XLFormRowDescriptor formRowDescriptorWithTag:kCateCell rowType:XLFormRowDescriptorTypeSelectorPush];
    row.title=@"部位";
    row.action.viewControllerClass=[CateSelectVC class];
    row.cellConfig[@"textLabel.textColor"]=THEME_COLOR_TEXT_LIGHT_GRAY;
    row.cellConfig[@"detailTextLabel.textColor"]=THEME_COLOR_TEXT;
    [section addFormRow:row];





    return [super initWithForm:formDescriptor];

}




@end