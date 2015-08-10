//
//  IndexTVC.m
//  meiLiTianShi
//
//  Created by zcw on 15/8/10.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "IndexTVC.h"
#import "MLSession.h"
#import "TSMessage.h"
#import "TopicModel.h"
#import "EventModel.h"
#import "IndexCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
@interface IndexTVC ()
@property (strong, nonatomic)NSMutableArray *tableData;
@end
#define kIndexCell @"indexcell"
@implementation IndexTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableData=[NSMutableArray array];
    [self.tableView registerClass:[IndexCell class] forCellReuseIdentifier:kIndexCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"IndexCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kIndexCell];
    [self getData];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tableData.count;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
return 1;
}

-(void)getData{
    [[MLSession current] getIndexList_success:^(NSArray *array) {
        self.tableData= [array mutableCopy];
        [self.tableView reloadData];
    } fail:^(NSInteger i, id o) {
        [TSMessage showNotificationWithTitle:@"出错了"
                                    subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
                                        type:TSMessageNotificationTypeError];
    }];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IndexCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kIndexCell];
    if([self.tableData[indexPath.section] isKindOfClass:[TopicModel class]]){
        TopicModel *data=self.tableData[indexPath.section];
        cell.title.text=[NSString stringWithFormat:@"huati: %@",data.title];
        cell.desc.text=[NSString stringWithFormat:@"huati: %@",data.desc];
        if(data.coverImg){
            [cell.imageView sd_setImageWithURL:data.coverImg
                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                         [cell.imageView setNeedsDisplay];
                                     }];
        }
    }else{
        EventModel *data=self.tableData[indexPath.section];
        cell.title.text=[NSString stringWithFormat:@"huati: %@",data.title];
        cell.desc.text=[NSString stringWithFormat:@"huati: %@",data.desc];
        if(data.coverImg){
            [cell.imageView sd_setImageWithURL:data.coverImg
                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                         [cell.imageView setNeedsDisplay];
                                     }];
        }
    }

    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:kIndexCell cacheByIndexPath:indexPath configuration:^(id cell) {
//        id data = self.tableData[indexPath.section];
//        [self setTheCell:cell withData:data];


    }];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
