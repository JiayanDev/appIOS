//
// Created by zcw on 15/7/9.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "CategoryModel.h"
#import "MLSession.h"


@implementation CategoryModel {

}

-(id)initWithId:(NSUInteger)id name:(NSString *)name{
    if(self=[super init]){
    self.id=id;
    self.name=name;
    }
    return self;
}

-(BOOL)isLevel1{
    return self.id<100;
}

-(NSArray *)chidren{

    if(self.id>100){
        return nil;
    }

    NSMutableArray *r=[NSMutableArray array];
    for (CategoryModel *model in [MLSession current].categories) {
        if(model.id>self.id*100 && model.id<(self.id+1)*100){
            [r addObject:model];
        }
    }
    return r;
}

- (NSString *)description {
    return self.name;
}
@end