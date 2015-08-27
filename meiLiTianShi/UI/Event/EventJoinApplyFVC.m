//
// Created by zcw on 15/8/27.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "EventJoinApplyFVC.h"
#import "InfoCellOfListOfKV.h"
#import "XLform_getAndSetValue.h"
#import "PersonCellOfAvatarAndName.h"
#import "MLSession.h"
#import "UserModel.h"
#import "PhoneAndGotoEditButtonCell.h"


@implementation EventJoinApplyFVC {

}


#define kInfoCell @"infocell"
#define kPersonCell @"personcell"
#define kPhoneCell @"phonecell"
#define kNickCell @"nickcell"

- (void)viewDidLoad {
    [super viewDidLoad];
    setValue(kInfoCell,(@[@{@"hehe":@"papa"},@{@"hehe":@"papa"},@{@"hehe":@"papa"}]));
    setValue(kPersonCell,(@{kName:@"hahaha",kAvatar:[MLSession current].currentUser.avatar}));
    setValue(kPhoneCell,[MLSession current].currentUser.phoneNum);
    setValue(kNickCell,(@[@{@"haha":@"nick"}]));
    [self.tableView reloadData];

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