//
//  EventJoinApplyVC.m
//  meiLiTianShi
//
//  Created by zcw on 15/8/6.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "EventJoinApplyVC.h"
#import "CTCheckbox.h"
#import "MLSession.h"
#import "NSDate+XLformPushDisplay.h"
#import "EventModel.h"
#import "CategoryModel.h"
#import "UserModel.h"
#import "TSMessage.h"
#import "EventJoinApplySuccVC.h"
#import "UserDetailModel.h"

@interface EventJoinApplyVC ()
@property (nonatomic, strong)EventModel *event;
@property (nonatomic, strong)UserDetailModel *userDetailModel;
@end

@implementation EventJoinApplyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isAgree.textLabel.text=@"我已同意<现场伴美活动准则>";
    [[MLSession current] getUserDetail_success:^(UserDetailModel *model) {
        self.userDetailModel=model;
        self.baoMingXinXi.text = [NSString stringWithFormat:
                @"昵称:%@ \n电话:%@ \n所在地:%@",
                        model.name,
                        model.phone,
                model.city

        ];
    } fail:^(NSInteger i, id o) {

    }];

    [[MLSession current] getEventDetailWithEventId:(NSUInteger) [self.eventId integerValue]
                                           success:^(EventModel *model) {

                                               self.event = model;
                                               self.huoDongXiangQing.text = [NSString stringWithFormat:
                                                       @"时间:%@ \n医院:%@ \n医生:%@ \n项目:%@ ",
                                                       [[NSDate dateWithTimeIntervalSince1970:[model.beginTime unsignedIntegerValue]] displayTextWithDateAndHHMM],
                                                       model.hospitalName,
                                                       model.doctorName,
                                                       [CategoryModel stringWithIdArray:model.categoryIds]

                                               ];

                                           } fail:^(NSInteger i, id o) {
                [TSMessage showNotificationWithTitle:@"出错了"
                                            subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
                                                type:TSMessageNotificationTypeError];
            }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}
- (IBAction)submitButtonPress:(id)sender {
    if(!self.isAgree.checked){
        [TSMessage showNotificationWithTitle:@"请同意准则后再确认报名"
                                        type:TSMessageNotificationTypeWarning];
        return ;
    }

    [[MLSession current] eventJoinApply:@{
            @"eventId":self.eventId,
            @"phone":self.userDetailModel.phone,
            @"name":self.userDetailModel.name,
            @"gender":self.userDetailModel.gender,
    } success:^{
        EventJoinApplySuccVC *vc= [[EventJoinApplySuccVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } fail:^(NSInteger i, id o) {
        [TSMessage showNotificationWithTitle:@"出错了"
                                    subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
                                        type:TSMessageNotificationTypeError];
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
