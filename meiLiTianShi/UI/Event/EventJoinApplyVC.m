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

@interface EventJoinApplyVC ()
@property (nonatomic, strong)EventModel *event;
@end

@implementation EventJoinApplyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[MLSession current] getEventDetailWithEventId:(NSUInteger) [self.eventId integerValue]
                                           success:^(EventModel *model) {

                                               self.event=model;
                                               self.huoDongXiangQing.text=[NSString stringWithFormat:@"%@ \n %@ \n %@ \n %@ ",
                                                               [[NSDate dateWithTimeIntervalSince1970:[model.beginTime unsignedIntegerValue]] displayTextWithDateAndHHMM],
                                                       model.hospitalName,
                                                       model.doctorName,
                                                       [CategoryModel stringWithIdArray:model.categoryIds]

                                               ];

                                           } fail:^(NSInteger i, id o) {

            }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
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
