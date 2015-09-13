//
// Created by zcw on 15/9/14.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "EventRatingFVC.h"
#import "EventIntroCell_atRating.h"
#import "RatingCell_ATitleAndTwoRates.h"
#import "XLForm.h"
#import "EventModel.h"

#define kIntroCell @"intro"
#define kStarCell @"star"
#define kWordsCell @"words"
@implementation EventRatingFVC {

}


- (void)viewDidLoad {
    [super viewDidLoad];

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

    row = [XLFormRowDescriptor formRowDescriptorWithTag:kIntroCell rowType:XLFormRowDescriptorType_EventIntroCell_atRating];
    [section addFormRow:row];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:kStarCell rowType:XLFormRowDescriptorType_RatingCell_ATitleAndTwoRates];
    [section addFormRow:row];

    section = [XLFormSectionDescriptor formSectionWithTitle:@""];

    [formDescriptor addFormSection:section];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:kWordsCell rowType:XLFormRowDescriptorTypeTextView];

    [section addFormRow:row];





    return [super initWithForm:formDescriptor];

}
@end