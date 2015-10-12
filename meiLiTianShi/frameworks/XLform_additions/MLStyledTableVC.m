//
// Created by zcw on 15/9/1.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "MLStyledTableVC.h"


@implementation MLStyledTableVC {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setSeparatorColor:THEME_COLOR_SEPERATOR_LINE];
    self.tableView.backgroundColor=THEME_COLOR_BACKGROUND;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 0.000001f)];
    self.tableView.sectionHeaderHeight = 0.0;
    self.tableView.sectionFooterHeight = 0.0;

    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
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


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return CGFLOAT_MIN;
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}


- (UIView*)tableView:(UITableView*)tableView
        viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (UIView*)tableView:(UITableView*)tableView
        viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self scrollViewDidScroll:self.tableView];

        [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];

}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self scrollViewDidScroll:self.tableView];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGRect frame = self.fixedBottomView.frame;
    frame.origin.y = scrollView.contentOffset.y + self.tableView.frame.size.height - self.fixedBottomView.frame.size.height;
    self.fixedBottomView.frame = frame;

    [self.view bringSubviewToFront:self.fixedBottomView];
}

- (void)setFixedBottomView:(UIView *)fixedBottomView {
    _fixedBottomView=fixedBottomView;
    CGRect frame = self.fixedBottomView.frame;
    frame.origin.y = self.tableView.contentOffset.y + self.tableView.frame.size.height - self.fixedBottomView.frame.size.height;
    self.fixedBottomView.frame = frame;
}


- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}


@end