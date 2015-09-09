//
//  TopicListVC.h
//  meiLiTianShi
//
//  Created by zcw on 15/7/3.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KIImagePager.h"
#import "MLStyledTableVC.h"

@interface TopicListVC : MLStyledTableVC <UITableViewDataSource, UITableViewDelegate, KIImagePagerDelegate, KIImagePagerDataSource>

@end
