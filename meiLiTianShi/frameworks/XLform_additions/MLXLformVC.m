//
// Created by zcw on 15/8/18.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "MLXLformVC.h"


@implementation MLXLformVC {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setSeparatorColor:[UIColor colorWithHexString:@"ededed"]];
    self.tableView.backgroundColor=[UIColor colorWithHexString:@"f6f6f6"];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 0.01f)];

}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    UIEdgeInsets e=UIEdgeInsetsMake(0,5,0,5);
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:e];
    }

    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:e];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [super tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    UIEdgeInsets e=UIEdgeInsetsMake(0,5,0,5);
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:e];
    }

    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:e];
    }
}

@end