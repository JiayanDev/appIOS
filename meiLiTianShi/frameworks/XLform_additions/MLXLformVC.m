//
// Created by zcw on 15/8/18.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "MLXLformVC.h"
#import "MASConstraintMaker.h"
#import <Masonry/View+MASAdditions.h>


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


-(UIButton *)addStyledBigButtonAtTableFooter_title:(NSString*)title{
    UIView * t= [[UIView alloc] init];
    UIButton * b= [[UIButton alloc] init];
    [b setTitle:title forState:UIControlStateNormal];
//    [b setTitle:@"已发送"
//                        forState:UIControlStateDisabled];
    b.backgroundColor=THEME_COLOR;
    b.titleLabel.font=[UIFont systemFontOfSize:15];
    b.layer.cornerRadius = 4;
    b.clipsToBounds = YES;
    [b setBackgroundImage:[UIImage imageWithColor:THEME_COLOR_HIGHLIGHT_BUTTON] forState:UIControlStateHighlighted];
    [b setBackgroundImage:[UIImage imageWithColor:THEME_COLOR_DISABLED_BUTTON] forState:UIControlStateDisabled];

    [t addSubview:b];
    [b mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@45);
        make.left.equalTo(t.mas_left).with.offset(15);
        make.right.equalTo(t.mas_right).with.offset(-15);
        make.top.equalTo(t.mas_top).with.offset(30);
//        make.bottom.equalTo(t.mas_bottom);
    }];

    self.tableView.tableFooterView=t;
    CGRect r=t.frame;
    r.size.height=90;
    t.frame=r;

    return b;
}

@end