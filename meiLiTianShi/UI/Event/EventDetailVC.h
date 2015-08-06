//
//  EventDetailVC.h
//  meiLiTianShi
//
//  Created by zcw on 15/8/6.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDMPhotoBrowser.h"

@class EventModel;

@interface EventDetailVC : UIViewController <UIWebViewDelegate, IDMPhotoBrowserDelegate>
@property (nonatomic, strong)EventModel *event;
@end
