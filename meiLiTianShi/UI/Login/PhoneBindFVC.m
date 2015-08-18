//
// Created by zcw on 15/8/18.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "PhoneBindFVC.h"
#import "XLForm.h"
#import "FloatCellOfPhoneAndButton.h"


@implementation PhoneBindFVC {

}
-(id)init
{
    XLFormDescriptor * formDescriptor = [XLFormDescriptor formDescriptor];
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;

    section = [XLFormSectionDescriptor formSectionWithTitle:@""];

    [formDescriptor addFormSection:section];


//
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kcates rowType:XLFormRowDescriptorTypeSelectorPush title:@"项目"];
//    row.required = YES;
//    row.action.viewControllerClass=[ProjectSelectVC class];
//    //row.value=
//    [section addFormRow:row];
//
//
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kDate rowType:XLFormRowDescriptorTypeDate title:@"手术日期"];
//    row.value = [NSDate new];
//    [row.cellConfigAtConfigure setObject:[NSDate new] forKey:@"maximumDate"];
//    [section addFormRow:row];



    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"haha" rowType:XLFormRowDescriptorTypeFloatLabeledTextField_phoneAndButton];
    row.title=@"ceshi";
//    row.cellConfigAtConfigure[@"textView.placeholder"] = @"日记内容";
    [section addFormRow:row];






    return [super initWithForm:formDescriptor];

}

@end