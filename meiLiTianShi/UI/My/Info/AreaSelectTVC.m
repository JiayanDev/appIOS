//
//  AreaSelectTVC.m
//  meiLiTianShi
//
//  Created by zcw on 15/8/2.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "AreaSelectTVC.h"
#import "AreaSelectModel.h"
#import <CoreLocation/CoreLocation.h>


@interface AreaSelectTVC ()
@property (nonatomic, strong)NSArray * tableList;
@property(strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic, assign)BOOL locateFail;
@property (nonatomic, strong)AreaSelectModel *currentCity;

@end

@implementation AreaSelectTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.clearsSelectionOnViewWillAppear = YES;

    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"cell"];

    if(self.parent){
        self.tableList= self.parent.children;
    }else{
        self.tableList=  [AreaSelectModel list];
        [self startLocate];

    }


}

-(void)startLocate{
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManager requestWhenInUseAuthorization];
        }
        [self.locationManager startUpdatingLocation];
    } else {
        self.locateFail=YES;
        [self.tableView reloadData];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *currentLocation = [locations lastObject]; // 最后一个值为最新位置
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    // 根据经纬度反向得出位置城市信息
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            AreaSelectModel *model = [AreaSelectModel initAndFindPositionForName:placeMark.locality];
            if (!model) {
                model = [AreaSelectModel initAndFindPositionForName:[placeMark.locality stringByReplacingOccurrencesOfString:@"市"
                                                                                                                  withString:@""]];
            }
            self.currentCity = model;
            // ? placeMark.locality : placeMark.administrativeArea;
            if (!self.currentCity) {
                self.locateFail = YES;
            }

            [self.tableView reloadData];


        } else if (error == nil && placemarks.count == 0) {
            self.locateFail = YES;
            [self.tableView reloadData];

        } else if (error) {
            self.locateFail = YES;
            [self.tableView reloadData];

        }
    }];

    [manager stopUpdatingLocation];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if(self.parent){
        return 1;
    }else{
        return 2;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


    if(!self.parent&&section==0){
        return 1;
    }else{
        return self.tableList.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!self.parent && indexPath.section == 0) {
        if(self.locateFail){
            cell.textLabel.text=@"定位失败";
            cell.accessoryType=UITableViewCellAccessoryNone;
        }else if(self.currentCity){
            cell.textLabel.text=self.currentCity.name;
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        else{
            cell.textLabel.text=@"定位中...";
            cell.accessoryType=UITableViewCellAccessoryNone;

        }
    } else {
        AreaSelectModel *data;


        data = self.tableList[indexPath.row];


        cell.textLabel.text = data.name;
        if(data.children){
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }else{
            cell.accessoryType=UITableViewCellAccessoryNone;
        }

    }


    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AreaSelectModel *data;
    if (!self.parent && indexPath.section == 0) {
        if(self.currentCity){
            self.rowDescriptor.value = self.currentCity;
            for (UIViewController *one in [[self.navigationController viewControllers] reverseObjectEnumerator]) {
                if (![one isKindOfClass:[AreaSelectTVC class]]) {
                    [self.navigationController popToViewController:one animated:YES];
                    break;
                }
            }
        }
    } else {


        data = self.tableList[indexPath.row];
        if (data.children) {
            AreaSelectTVC *vc = [[AreaSelectTVC alloc] init];
            vc.parent = data;
            vc.rowDescriptor = self.rowDescriptor;
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            self.rowDescriptor.value = data;
            for (UIViewController *one in [[self.navigationController viewControllers] reverseObjectEnumerator]) {
                if (![one isKindOfClass:[AreaSelectTVC class]]) {
                    [self.navigationController popToViewController:one animated:YES];
                    break;
                }
            }
        }

    }
}
@end
