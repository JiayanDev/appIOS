//
// Created by zcw on 15/9/14.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "EventRatingFVC.h"
#import "EventIntroCell_atRating.h"
#import "RatingCell_ATitleAndTwoRates.h"
#import "XLForm.h"
#import "EventModel.h"
#import "UIButton+MLStyle.h"
#import "XLform_getAndSetValue.h"
#import "TSMessage.h"
#import "MLSession.h"

#define kIntroCell @"intro"
#define kStarCell @"star"
#define kWordsCell @"words"
@implementation EventRatingFVC {

}


- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    
    self.submitButton=[UIButton newSquareSolidButtonWithTitle:@"发表评价"];
    self.tableView.tableFooterView=[UIView new];
    [self.tableView.tableFooterView addSubview:self.submitButton];
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tableView.tableFooterView);
        make.right.equalTo(self.tableView.tableFooterView);
        make.bottom.equalTo(self.tableView.tableFooterView);
        make.height.mas_equalTo(self.submitButton.frame.size.height);
    }];
    [self.submitButton addTarget:self
                          action:@selector(submitButtonPress)
                forControlEvents:UIControlEventTouchUpInside];
}




- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];

    NSLog(@"%@",NSStringFromCGRect(self.tableView.tableFooterView.frame));
    CGRect r=self.tableView.tableFooterView.frame;
    r.size.height=MAX(64, self.tableView.frame.size.height-r.origin.y-64);
    self.tableView.tableFooterView.frame=r;

}


-(void)submitButtonPress {
    RatingCell_ATitleAndTwoRates*cell= (RatingCell_ATitleAndTwoRates *) [[self.form formRowWithTag:kStarCell] cellForFormController:self];
    if(getValueS(kWordsCell).length==0){
        [TSMessage showNotificationWithTitle:@"请输入评论"
                                        type:TSMessageNotificationTypeWarning];
        return ;
    }

    [[MLSession current] commentEventWithParams:@{
            @"eventId":@(self.eventId),
            @"content":getValueS(kWordsCell),
            @"satisfyLevelToAngel":@(cell.star1.value),
            @"satisfyLevelToDoctor":@(cell.star1.value),
    } success:^{
        [TSMessage showNotificationWithTitle:@"评论成功"
                                        type:TSMessageNotificationTypeSuccess];
        [self.navigationController popViewControllerAnimated:YES];

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