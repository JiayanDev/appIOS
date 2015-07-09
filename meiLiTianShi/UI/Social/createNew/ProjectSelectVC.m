//
//  ProjectSelectVC.m
//  meiLiTianShi
//
//  Created by zcw on 15/7/9.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "ProjectSelectVC.h"
#import "MLSession.h"
#import "CategoryModel.h"

@interface ProjectSelectVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableLeft;
@property (weak, nonatomic) IBOutlet UITableView *tableRight;
@property (nonatomic, strong)NSMutableArray *firstLevelCates;
@property (nonatomic, strong)CategoryModel *selectedFirstLevelCate;
@property (nonatomic, strong)NSMutableSet *selectedCates;
@end

@implementation ProjectSelectVC
#define kCell @"cell"
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableLeft.delegate=self;
    self.tableLeft.dataSource=self;
    self.tableRight.delegate=self;
    self.tableRight.dataSource=self;

    [self.tableLeft registerClass:[UITableViewCell class]
           forCellReuseIdentifier:kCell];
    [self.tableRight registerClass:[UITableViewCell class]
           forCellReuseIdentifier:kCell];

    self.automaticallyAdjustsScrollViewInsets=NO;
    CGFloat topLayoutGuide = self.topLayoutGuide.length + self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height;
    self.tableLeft.contentInset = UIEdgeInsetsMake(topLayoutGuide, 0, 0, 0);
    self.tableRight.contentInset = UIEdgeInsetsMake(topLayoutGuide, 0, 0, 0);
    self.selectedCates=[NSMutableSet set];
}

-(BOOL)hidesBottomBarWhenPushed
{
    return YES;
}

-(NSMutableArray *)firstLevelCates {
    if(_firstLevelCates){
        return _firstLevelCates;
    }else{
        _firstLevelCates=[NSMutableArray array];
        for (CategoryModel *model in [MLSession current].categories) {
            if([model isLevel1]){
                [_firstLevelCates addObject:model];
            }
        }
        return _firstLevelCates;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([tableView isEqual:self.tableLeft]){
        return self.firstLevelCates.count;
    }else{
        if(!self.selectedFirstLevelCate){
            return 0;
        }else{
            return [self.selectedFirstLevelCate chidren].count;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([tableView isEqual:self.tableLeft]){
        UITableViewCell *cell=[self.tableLeft dequeueReusableCellWithIdentifier:kCell];
        cell.textLabel.text=((CategoryModel *)self.firstLevelCates[indexPath.row]).name;

        return cell;
    }else{
        if(!self.selectedFirstLevelCate){
            return nil;
        }else{
            UITableViewCell *cell=[self.tableRight dequeueReusableCellWithIdentifier:kCell];
            CategoryModel *model=((CategoryModel *)self.selectedFirstLevelCate.chidren[indexPath.row]);
            cell.textLabel.text=model.name;
            //cell.selectionStyle=UITableViewCellSelectionStyleNone;
            if ([self.selectedCates containsObject:model]){
                cell.accessoryType=UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType=UITableViewCellAccessoryNone;
            }
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([tableView isEqual:self.tableLeft]){
        self.selectedFirstLevelCate=self.firstLevelCates[indexPath.row];
        [self.tableRight reloadData];
    }else{
        CategoryModel *model=((CategoryModel *)self.selectedFirstLevelCate.chidren[indexPath.row]);
        if([self.selectedCates containsObject:model]){
            [self.selectedCates removeObject:model];
        }else{
            [self.selectedCates addObject:model];
        }
        NSArray *array = @[indexPath];
        [tableView reloadRowsAtIndexPaths:array withRowAnimation: UITableViewRowAnimationFade];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

@end
