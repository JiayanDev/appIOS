//
//  LoginWaySelectVC.h
//  meiLiTianShi
//
//  Created by zcw on 15/7/28.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLSession.h"

@class SendAuthResp;

@interface LoginWaySelectVC : UIViewController <wxRespondVC>

- (void)handleWxAuthRespond:(SendAuthResp *)resp;
@end
