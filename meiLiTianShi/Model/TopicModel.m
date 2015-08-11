//
// Created by zcw on 15/7/6.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "TopicModel.h"
#import "MLRandom.h"


@implementation TopicModel {

}

+(TopicModel *)randomOne{
    TopicModel *a=[[TopicModel alloc]init];
    a.likeCount=@(arc4random_uniform(100));
    a.commentCount=@(arc4random_uniform(100));
    a.content=[MLRandom randomChineseStringLengthFrom:10 to:30];
    return a;
}
@end