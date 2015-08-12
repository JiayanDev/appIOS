//
//  TimelineVC.h
//  meiLiTianShi
//
//  Created by zcw on 15/8/12.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDMPhotoBrowser.h"

@interface TimelineVC : UIViewController <UIWebViewDelegate, IDMPhotoBrowserDelegate>
@property (nonatomic, strong)NSNumber *userId;
@end
