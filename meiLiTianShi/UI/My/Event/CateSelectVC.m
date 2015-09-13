//
// Created by zcw on 15/9/13.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "CateSelectVC.h"
#import "MLStyleManager.h"
#import "MLSession.h"
#import "CategoryModel.h"

@interface  CateSelectVC()
@property (nonatomic, strong)NSArray * categories;
@end

@implementation CateSelectVC {

}

- (NSArray *)categories {
    return [MLSession current].categories;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [MLStyleManager removeBackTextForNextScene:self];

    self.clearsSelectionOnViewWillAppear = YES;

    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell= [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    CategoryModel *model=self.categories[indexPath.row];
    cell.textLabel.text=model.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    self.rowDescriptor.value=self.categories[indexPath.row];
    [self.navigationController popViewControllerAnimated:YES];
}

@end