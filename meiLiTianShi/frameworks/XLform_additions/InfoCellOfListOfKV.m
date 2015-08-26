//
// Created by zcw on 15/8/26.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <objc/runtime.h>
#import "InfoCellOfListOfKV.h"


@implementation XLFormRowDescriptor(display_data)

-(void)setDisplayData:(NSMutableDictionary *)newDisplayData {
    objc_setAssociatedObject(self, @selector(displayData), newDisplayData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

- (NSMutableDictionary *)displayData {
    if(objc_getAssociatedObject(self, @selector(displayData))){
        return objc_getAssociatedObject(self, @selector(displayData));
    }else{
        objc_setAssociatedObject(self, @selector(displayData), [NSMutableDictionary dictionary], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return objc_getAssociatedObject(self, @selector(displayData));
    }

}
@end

@implementation InfoCellOfListOfKV {

}
@end