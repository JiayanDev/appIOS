//
// Created by zcw on 15/10/15.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "SuggestionsVCB.h"
#import "XLForm.h"
#import "FloatCellOfName.h"
#import "XLform_getAndSetValue.h"
#import "TSMessage.h"
#import "MLSession.h"


@implementation SuggestionsVCB {

}


#define kContent @"kconetnc"
#define kContact @"contact"

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



    row = [XLFormRowDescriptor formRowDescriptorWithTag:kContent rowType:XLFormRowDescriptorTypeTextView];
    row.cellConfigAtConfigure[@"textView.placeholder"] = @"请提供您的宝贵意见";
    [section addFormRow:row];

    section = [XLFormSectionDescriptor formSectionWithTitle:@""];

    [formDescriptor addFormSection:section];


    row= [XLFormRowDescriptor formRowDescriptorWithTag:kContact rowType:XLFormRowDescriptorTypeFloatLabeledTextField_name];
    row.title=@"联系方式(QQ/手机),非必填";
    [section addFormRow:row];




    return [super initWithForm:formDescriptor];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.buttonSubmit= [self addStyledBigButtonAtTableFooter_title:@"提交"];
    [self.buttonSubmit addTarget:self
                    action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    self.title=@"意见反馈";
}


-(void)submit{
    if(getValueS(kContent).length<1){
        [TSMessage showNotificationWithTitle:@"请填写内容" type:TSMessageNotificationTypeWarning];
        return;
    }

    [[MLSession current] submitFeedbackWithContent:getValue(kContent)
                                           contact:getValue(kContact)
                                           success:^{
                                               [TSMessage showNotificationWithTitle:@"您的建议提交成功" type:TSMessageNotificationTypeSuccess];
                                               [self.navigationController popViewControllerAnimated:YES];
                                           } fail:^(NSInteger i, id o) {
                [TSMessage showNotificationWithTitle:@"出错了"
                                            subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
                                                type:TSMessageNotificationTypeError];
            }];
}

@end