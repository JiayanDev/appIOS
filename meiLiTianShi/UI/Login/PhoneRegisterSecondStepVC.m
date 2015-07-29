//
//  PhoneRegisterSecondStepVC.m
//  meiLiTianShi
//
//  Created by zcw on 15/7/29.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "PhoneRegisterSecondStepVC.h"
#import "MLSession.h"
#import "TSMessage.h"

@interface PhoneRegisterSecondStepVC ()
@property (weak, nonatomic) IBOutlet UITextField *nickInput;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sexSegment;
@property (weak, nonatomic) IBOutlet UITextField *password1;
@property (weak, nonatomic) IBOutlet UITextField *password2;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation PhoneRegisterSecondStepVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)registerButtonPress:(id)sender {
    NSDictionary *d=@{
            @"phoneNum":self.phoneNum,
            @"name":self.nickInput.text,
            @"gender":@(1-self.sexSegment.selectedSegmentIndex),
            @"receipt":self.receipt,
    };

    [[MLSession current] registerWithParam:d
                                  password:self.password1.text
                                   success:^(UserDetailModel *model) {
                                       [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];

                                   } fail:^(NSInteger i, id o) {
                [TSMessage showNotificationInViewController:self.navigationController
                                                      title:@"出错了"
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
