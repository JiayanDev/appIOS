//
// Created by zcw on 15/8/2.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "AreaSelectModel.h"

static NSArray *areaList;

@implementation AreaSelectModel {

}

+(AreaSelectModel *)initAndFindPositionForName:(NSString *)name{
    for (AreaSelectModel *areaSelectModel in [self list]) {
        AreaSelectModel *r=[areaSelectModel findForName:name];
        if(r){
            return r;
        }
    }

    return nil;

}

- (BOOL)isEqual:(AreaSelectModel *)object {
    return self.name==object.name;
}

-(AreaSelectModel *)findForName:(NSString *)name{
    if ([self.name isEqualToString:name]){
        return self;
    }else if(self.children){
        for (AreaSelectModel *child in self.children) {
            AreaSelectModel *r=[child findForName:name];
            if(r){
                return r;
            }
        }
    }
    return nil;
}


+(NSArray *)list{
    if(areaList){
        return areaList;
    }

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:nil error:nil];

    NSMutableArray *r=[NSMutableArray array];
    for (NSDictionary *dictionary in json) {
        [r addObject:[[AreaSelectModel alloc] initWithDictionary:dictionary error:nil]];
    }

    for (AreaSelectModel *areaSelectModel in r) {
        for (AreaSelectModel *child in areaSelectModel.children) {
            child.parent=areaSelectModel;
        }
    }

    areaList=r;

    return r;
}



-(NSString *)displayText{
    return self.name;
};
-(id)valueData{
    return self;
};


@end