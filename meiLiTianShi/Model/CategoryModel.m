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

//-(id)initWithDetail:(NSDictionary *)d{
//    if(self =[super init]){
//        self.id= [d[@"id"] unsignedIntegerValue];
//        self.name=d[@"name"];
//        if(d[@""])
//    }
//    return self;
//}

//-(BOOL)isLevel1{
//    return self.id<100;
//}

//-(NSArray *)chidren{
//
//    if(self.id>100){
//        return nil;
//    }
//
//    NSMutableArray *r=[NSMutableArray array];
//    for (CategoryModel *model in [MLSession current].categories) {
//        if(model.id>self.id*100 && model.id<(self.id+1)*100){
//            [r addObject:model];
//        }
//    }
//    return r;
//}

- (NSString *)description {
    return self.name;
}

-(NSString *)stringWithId:(NSUInteger)id{
    if (self.id==id){
        return self.name;
    }
    for (CategoryModel *category in self.sub) {
        if([category stringWithId:id]){
            return [category stringWithId:id];
        }
    }
    return nil;
}

+(NSString *)stringWithId:(NSUInteger)id{
    for (CategoryModel *category in [MLSession current].categories) {
        if([category stringWithId:id]){
            return [category stringWithId:id];
        }
    }
    return [NSString stringWithFormat:@"未知:%@",@(id)];
}

+(NSString *)stringWithIdArray:(NSArray *)ids{
    NSMutableArray *r=[NSMutableArray array];
    for (NSNumber *anId in ids) {
        [r addObject:[self stringWithId:[anId unsignedIntegerValue]]];
    }

    if(r.count==0){
        return nil;
    }else{
        return [r componentsJoinedByString:@","];
    }
}

+(NSString *)stringWithIdAndNameObjectsArray:(NSArray *)objs{
    NSMutableArray *r=[NSMutableArray array];
    for (NSDictionary *anId in objs) {
        [r addObject:anId[@"name"]];
    }

    if(r.count==0){
        return nil;
    }else{
        return [r componentsJoinedByString:@","];
    }
}

-(NSString *)displayText{
    return self.name;
};
-(id)valueData{
    return self;
};
@end